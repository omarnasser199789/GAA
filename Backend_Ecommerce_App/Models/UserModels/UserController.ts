import * as express from "express";
import Payload from "../Token/Payload";
import TokenData from "../Token/TokenData";
import UserDto from "../UserModels/User.dto";
import BaseController from "../BaseController";
import validationMiddleware from "../../middleware/validation.middleware";
const jwt = require("jsonwebtoken");
const bcrypt = require('bcrypt');
const crypto = require('crypto');
const messages = []

class UsersController extends BaseController {
  public loginRoute = "/User/Login";
  public generateQrRoute = "/User/GenerateQR";
  public RegisterRoute = "/User/Register";
  public getAllUsersRoute = "/User";
  public createUpdateUserRoute = "/User";
  public router = express.Router();
  constructor() {
    super();
    this.intializeRoutes();
  }

  public intializeRoutes() {
    this.router.post(this.loginRoute, this.login);
    this.router.post(this.generateQrRoute, this.generateQR);
    this.router.post(
      this.RegisterRoute, // Use the correct route for registration
      validationMiddleware(UserDto),
      this.registerUser // Change the route handler to registerUser
    );
  }

  public addSocketFunc() {
    this.io.on('connection', (socket) => {
      const username = socket.handshake.query.username
      socket.on('message', async (data) => {
      console.log(data);
      // console.log(data['uid']);
      // console.log(data['loginKey']);
      console.log(data['userUID']);
      console.log(data['phoneNumber']);

      const loginWithQrKey = await this.prismaClient.loginWithQrKey.findUnique({
        where: {
          uid: data['uid']
        },
      });
   
      // If the user doesn't exist or the uid doesn't match, return an error
      if (!loginWithQrKey || !(await bcrypt.compare(loginWithQrKey.loginKey, data['loginKey']))) {
        messages.push("Error")
        this.io.emit('message', "Error")
      }else{


        
        // Find the user by phone number in the database
      const user = await this.prismaClient.user.findUnique({
        where: {
          phoneNumber:data['phoneNumber']
        },
      });
      // If the user doesn't exist or the uid doesn't match, return an error
      if (!user || !(await bcrypt.compare(data['userUID'], user.uid))) {
        messages.push("Error")
        this.io.emit('message', "Error")
      }else{
          // Create a token for the authenticated user
          const tokenData = this.createToken(user.id);
        
          const message = {
            message: "200",
            token: tokenData.token,
          }
          messages.push(message)
          this.io.emit('message', message) 

      }
      }

      


      })
    });
  }

  public generateQR = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    const { systemGUID } = request.body;
    try {
      // Example usage: Generate a random key of length 16
      const _loginKey = this.generateRandomKey(16);
      console.log('Login Key:', _loginKey);
      // Hash the password before saving it
      const hashedLoginKey = await bcrypt.hash(_loginKey, 10);
  
      const key = await this.prismaClient.loginWithQrKey.findUnique({
        where: {
          uid: systemGUID
        },
      });
  
      // If the user exists and the uid matches, update the loginKey
      if (key) {
        const updatedLoginWithQrKey = await this.prismaClient.loginWithQrKey.update({
          where: {
            uid: systemGUID
          },
          data: {
            loginKey: _loginKey, // Update the loginKey with the new value
          },
        });
  
        return response.json({
          message: 'Success generate login key',
          loginKey: hashedLoginKey,
          uid: updatedLoginWithQrKey.uid,
        });
      } else {
        const loginWithQrKey = await this.prismaClient.loginWithQrKey.create({
          data: {
            uid: systemGUID,
            loginKey: _loginKey,
          },
        });
  
        return response.json({
          message: 'Success generate login key',
          loginKey: hashedLoginKey,
          uid: loginWithQrKey.uid,
        });
      }
    } catch (err) {
      console.error(err);
      return response.status(500).json({ error: 'Generate login key failed' });
    }
  };
  
  // Function to generate a random key of a specific length
  public generateRandomKey(length) {
  return crypto.randomBytes(Math.ceil(length / 2)).toString('hex').slice(0, length);
  }

  public login = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    const { phoneNumber, fcmToken, uid } = request.body;
  
    try {
      // Find the user by phone number in the database
      const user = await this.prismaClient.user.findUnique({
        where: {
          phoneNumber
        },
      });
  
      // If the user doesn't exist or the uid doesn't match, return an error
      if (!user || !(await bcrypt.compare(uid, user.uid))) {
        return response.status(400).json({ error: 'Invalid phone number or uid' });
      }
  
      // Update the user's fcmToken
      const updatedUser = await this.prismaClient.user.update({
        where: { id: user.id },
        data: { fcmToken },
      });
  
      // Create a token for the authenticated user
      const tokenData = this.createToken(updatedUser.id);
  
      // Return the token and sanitized user information (without sensitive fields like password)
      const sanitizedUser = this.sanitizeUser(updatedUser);
  
      return response.json({
        message: 'Login successful',
        token: tokenData.token,
        user: sanitizedUser,
      });
    } catch (err) {
      console.error(err);
      return response.status(500).json({ error: 'Login failed' });
    }
  };
 
  private createToken(userId: string): TokenData {
    const expiresIn = 5000; // an hour
    const secret =  process.env.ACCESS_TOKEN_SECRET || "defaultSecret";
    const dataStoredInToken: Payload = {
      id: userId,
    };
    return {
      expiresIn,
      token: jwt.sign(dataStoredInToken, secret),
    };
  }

  private registerUser = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    const { username, phoneNumber, fcmToken,email,uid} = request.body;

    // Check if the username is already taken
    const existingUser = await this.prismaClient.user.findFirst({
      where: {
        OR: [
          { email },
          { phoneNumber },
          { uid }
        ]
      }
    });
    
    if (existingUser) {
      return response.status(400).json({ error: 'User with this email or phone number already exists.' });
    }
      

    // Hash the password before saving it
    const hashedUid = await bcrypt.hash(uid, 10);

    try {
      const user = await this.prismaClient.user.create({
        data: {
          uid:hashedUid,
          username,
          phoneNumber:phoneNumber,
          fcmToken:fcmToken,
          email:email,
          roles: {
            connect: {
              name: 'user', // Assuming 'user' is the default role name
            },
          },
        },
      });

      // Create a token for the authenticated user
      const tokenData = this.createToken(user.id);

      // Sanitize the user object before sending the response
      const sanitizedUser = this.sanitizeUser(user);

      // Return a success response for registration
      return response.json({ 
        message: 'Registration successful',
        token: tokenData.token,
        user: sanitizedUser,
        });
    } catch (err) {
      console.error(err);
      return response.status(500).json({ error: 'Registration failed' });
    }
  };

  private sanitizeUser(user: any): any {
    // Exclude sensitive properties (fcmToken, uid, deleted) from the user object
    const { fcmToken, uid, deleted, ...sanitizedUser } = user;
    return sanitizedUser;
  }
}

export default UsersController;
