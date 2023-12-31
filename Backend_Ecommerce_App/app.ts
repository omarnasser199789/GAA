import * as express from "express";
import * as bodyParser from "body-parser";
import errorMiddleware from "./middleware/error.middleware";
const cors = require("cors");
const http = require("http");
const { Server } = require("socket.io");

class App {
  public app: express.Application;
  public port: 4000;
  public server = http.createServer(this);
  public io = new Server(this.server);

  constructor(controllers, port) {
    this.app = express();
    this.port = port;
    this.initializeMiddlewares();
    this.initializeControllers(controllers);
    this.initializeErrorHandling();
  }

  private initializeMiddlewares() {
    this.app.use(cors());
    this.app.use(bodyParser.json());
    this.app.use("/uploads", express.static("uploads"));
  }

  private initializeControllers(controllers) {
    controllers.forEach((controller) => {
      controller.io = this.io;

      if (controller.addSocketFunc !== undefined) controller.addSocketFunc();

      this.app.use("/", controller.router);
    });
  }

  private initializeErrorHandling() {
    this.app.use(errorMiddleware);
  }

  public listen() {
    this.server.listen(3000, () => {
      console.log("listening on *:3000");
    });

    this.app.listen(this.port, () => {
      console.log(`App listening on the port ${this.port}`);
    });
  }
}

export default App;
