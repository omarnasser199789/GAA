require("dotenv").config();
import App from "./app";
import UsersController from "./Models/UserModels/UserController";
import BannerController from "./Models/Banner/Banner.Controller";

const app = new App([new UsersController(), new BannerController()], 3100);

app.listen();
