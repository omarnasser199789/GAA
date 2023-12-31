import * as express from "express";
import BaseController from "../BaseController";
import CreateUpdateDTO from "./Banner.dto";
import ServerException from "../../exceptions/ServerException";
import * as path from "path";
import { spawn } from "child_process";
import * as fs from "fs";

class BannerController extends BaseController {
  public tableName = "Banner";
  public read = `/${this.tableName}/`;
  public generateAndroidVersion = `/GenerateAndroidVersion/`;
  public generateIOSVersion = `/GenerateIOSVersion/`;
  public router = express.Router();

  constructor() {
    super();
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.post(this.generateAndroidVersion, this.generateAndroidApp.bind(this));
  }

  private async executeCommand(command: string, args: string[], onSuccess: () => void, onError: (code: number) => void) {
    try {
      const childProcess = spawn(command, args, { stdio: "inherit" });
      childProcess.on("exit", (code, signal) => {
        if (code !== 0) {
          console.error(`Command '${command}' failed with exit code ${code}`);
          onError(code);
        } else {
          onSuccess();
        }
      });
    } catch (error) {
      console.error(`Error executing '${command}':`, error);
      onError(-1); // Handle general error
    }
  }

  private async generateAndroidApp(request: express.Request, response: express.Response, next: express.NextFunction) {
    const createOrUpdateObject: CreateUpdateDTO = request.body;

    try {
      // Step 1: Build Template
      await this.executeCommand("mason", ["make", "acadimiat",
        "--app_name", `${createOrUpdateObject.appName}`,
        "--primary_color", `${createOrUpdateObject.primaryColor}`,
        "--base_url", `${createOrUpdateObject.baseUrl}`,
        "--base_signalr_url", `${createOrUpdateObject.baseSignalrUrl}`,
      ], () => {
        console.log("Build Template => Succeeded");

        // Step 2: Save the current directory
        const originalDir = process.cwd();

        // Step 3: Navigate to the acadimiat directory
        const currentDir = process.cwd();
        const acadimiatPath = path.resolve(currentDir, "acadimiat");
        console.log("Navigating to:", acadimiatPath);
        process.chdir(acadimiatPath);

        // Step 4: Flutter pub get
        this.executeCommand("flutter", ["pub", "get"], () => {
          console.log("(Flutter pub get) => Succeeded");

          // Step 5: Build Android
          this.executeCommand("flutter", ["build", "apk"], () => {
            console.log("Build Android => Succeeded");

            // Path to the built APK
            // const apkPath = path.resolve(currentDir, "build/app/outputs/flutter-apk/app-release.apk");

            // Step 6: Navigate back to the original directory
            process.chdir(originalDir);
            console.log("Back to original directory:", originalDir);

            // Step 7: Delay for 10 seconds before removing the acadimiat directory
            // setTimeout(() => {
            //   fs.rmdirSync(acadimiatPath, { recursive: true });
            //   console.log("Removed directory:", acadimiatPath);
            //
            // }, 10000); // 10 seconds delay

            // Step 8: Respond with success
            response.json({ message: "Build successful" });
          }, (code) => {
            console.error(`Build Android failed with exit code ${code}`);
            next(new ServerException());
          });
        }, (code) => {
          console.error(`(Flutter pub get) failed with exit code ${code}`);
          next(new ServerException());
        });
      }, (code) => {
        console.error(`Build Template failed with exit code ${code}`);
        next(new ServerException());
      });
    } catch (error) {
      console.error("Error in generateNewApp:", error);
      next(new ServerException());
    }
  }
}

export default BannerController;
