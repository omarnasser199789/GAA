import * as express from "express";
import CreateUpdateTeamPersonDTO from "./Team.dto";
import validationMiddleware from "../../middleware/validation.middleware";
import authMiddleware from "../../middleware/auth.middleware";
import BaseController from "../BaseController";
import HttpException from "../../exceptions/HttpExceptions";
import NotFoundException from "../../exceptions/NotFoundException";
import permissionsMiddleware from "../../middleware/permissions.middleware";
import ServerException from "../../exceptions/ServerException";
const { saveFilesToS3, storeImage } = require("../../utils/fileUploadHandler");

class TeamController extends BaseController {
  public read = "/Team/";
  public delete = "/Team/:id";
  public single = "/Team/:id";
  public create = "/Team/";
  public router = express.Router();

  constructor() {
    super();
    this.intializeRoutes();
  }

  public intializeRoutes() {
    this.router.get(this.read, this.getAllTeamPersons);
    this.router.get(this.single, this.getSingleMember);
    this.router.post(
      this.create,
      authMiddleware,
      storeImage,
      validationMiddleware(CreateUpdateTeamPersonDTO),
      this.createOrUpdateTeamPerson
    );
    this.router.delete(this.delete, authMiddleware, this.deleteTeamPerson);
  }

  getAllTeamPersons = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    try {
      const { page, pageSize } = request.query;
      const teamPersons = await this.prismaClient.teamPerson.findMany({
        where: {
          deleted: false,
        },
        take: +pageSize,
        skip: pageSize * page,
        orderBy: [
          {
            id: "desc",
          },
        ],
      });
      const TeamPersonsCount = await this.prismaClient.teamPerson.count({
        where: {
          deleted: false,
        },
      });
      response.json({
        data: teamPersons,
        count: TeamPersonsCount,
        pages: this.calculatePages(pageSize, TeamPersonsCount),
      });
    } catch (error) {
      console.error(error);
      next(new ServerException());
    }
  };
  getSingleMember = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    try{
      const teamPersonObject = await this.prismaClient.teamPerson.findFirst({
        where: {
          deleted: false,
          id:+request.params.id
        },
      });
      if(!teamPersonObject){
        next(new NotFoundException(request.params.id,'Team Person'));
        return
      }
      response.json(teamPersonObject)
    } catch (error) {
      console.error(error);
      next(new ServerException());
    }
  }

  deleteTeamPerson = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    try {
      await this.prismaClient.teamPerson.update({
        where: {
          id: +request.params.id,
        },
        data: {
          deleted: true,
        },
      });
      response.sendStatus(200);
    } catch (error) {
      console.error(error);
      next(new ServerException());
    }
  };

  createOrUpdateTeamPerson = async (
    request: express.Request,
    response: express.Response,
    next: express.NextFunction
  ) => {
    try {
      const createOrUpdateObject: CreateUpdateTeamPersonDTO = request.body;
      const { user } = request;
      const filesPaths: any[] = await saveFilesToS3(request.files.image);
      if (createOrUpdateObject.id === undefined && filesPaths.length == 0) {
        next(new HttpException(422, "Image is missing"));
        return;
      }
      if (createOrUpdateObject.id === undefined) {
        const newTeamPerson = await this.prismaClient.teamPerson.create({
          data: {
            name: createOrUpdateObject.name,
            kr_name: createOrUpdateObject.kr_name || '',
            ar_name: createOrUpdateObject.ar_name,
            title: createOrUpdateObject.title,
            kr_title: createOrUpdateObject.kr_title || '',
            ar_title: createOrUpdateObject.ar_title,
            imagePath: filesPaths[0].path,
            createdBy: user.id,
          },
        });

        response.json(newTeamPerson);
      } else {
        let data: any = {
          name: createOrUpdateObject.name,
          kr_name: createOrUpdateObject.kr_name,
          ar_name: createOrUpdateObject.ar_name,
          title: createOrUpdateObject.title,
          kr_title: createOrUpdateObject.kr_title,
          ar_title: createOrUpdateObject.ar_title,
        };

        if (filesPaths.length != 0) data.imagePath = filesPaths[0].path;

        const teamPerson = await this.prismaClient.teamPerson.update({
          where: {
            id: +createOrUpdateObject.id,
          },
          data: data,
        });

        response.json(teamPerson);
      }
    } catch (error) {
      console.error(error);
      next(new ServerException());
    }
  };
}

export default TeamController;
