require("dotenv").config();
import App from "./app";
import UsersController from "./Models/UserModels/UserController";
import GenerateAppController from "./Models/GenerateAppModel/GenerateApp.Controller";

const app = new App([new UsersController(), new GenerateAppController()], 3100);

app.listen();
