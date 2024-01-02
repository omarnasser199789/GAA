import * as express from 'express';
import BaseController from '../BaseController';
import CreateUpdateDTO from './Banner.dto';
import ServerException from '../../exceptions/ServerException';
import * as path from 'path';
import { spawn } from 'child_process';
import HttpException from '../../exceptions/HttpExceptions';
import validationMiddleware from '../../middleware/validation.middleware';
import * as fs from 'fs';

const {
    storeImage
} = require('../../utils/fileUploadHandler');

class BannerController extends BaseController {
    public tableName = 'Banner';
    public read = `/${this.tableName}/`;
    public generateAndroidVersion = `/GenerateAndroidVersion/`;
    public generateIOSVersion = `/GenerateIOSVersion/`;
    public router = express.Router();

    constructor() {
        super();
        this.initializeRoutes();
    }

    private initializeRoutes() {
        this.router.post(
            this.generateAndroidVersion,
            storeImage,
            validationMiddleware(CreateUpdateDTO),
            this.generateAndroidApp.bind(this)
        );
    }

    private async executeCommand(
        command: string,
        args: string[],
        onSuccess: () => void,
        onError: (code: number) => void
    ) {
        try {
            const childProcess = spawn(command, args, { stdio: 'inherit' });
            childProcess.on('exit', (code, signal) => {
                if (code !== 0) {
                    console.error(
                        `Command '${command}' failed with exit code ${code}`
                    );
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

    private async generateAndroidApp(
        request: express.Request,
        response: express.Response,
        next: express.NextFunction
    ) {
        try {
            const createOrUpdateObject: CreateUpdateDTO = request.body;
            const { icon } = request.files;
            console.log({ icon });

            /// Check if image is missing when creating a new category
            if (!icon || icon.length === 0) {
                next(new HttpException(422, 'App icon is missing'));
                return;
            }

            // Get the properties of the uploaded icon file
            const { buffer } = icon[0];

            // Rename and save the file (example: save it to the 'uploads' directory with a new name)
            const newFileName = 'logo.png'; // Replace with your desired file name
            const targetDirectory =
                '/Users/omernasser/Documents/GitHub/GAA/bricks/generate_acadimiat_app/acadimiat/__brick__/acadimiat/assets'; // Replace with your target directory

            // Write the buffer content to the new file in the target directory
            const newFilePath = path.join(targetDirectory, newFileName);
            console.log({ newFilePath });
            fs.writeFileSync(newFilePath, buffer);

            // Step 1: Build Template
            await this.executeCommand(
                'mason',
                [
                    'make',
                    'acadimiat',
                    '--app_name',
                    `${createOrUpdateObject.appName}`,
                    '--primary_color',
                    `${createOrUpdateObject.primaryColor}`,
                    '--base_url',
                    `${createOrUpdateObject.baseUrl}`,
                    '--base_signalr_url',
                    `${createOrUpdateObject.baseSignalrUrl}`
                ],
                () => {
                    console.log('Build Template => Succeeded');

                    // Step 2: Save the current directory
                    const originalDir = process.cwd();

                    // Step 3: Navigate to the acadimiat directory
                    const currentDir = process.cwd();
                    const acadimiatPath = path.resolve(currentDir, 'acadimiat');
                    console.log('Navigating to:', acadimiatPath);
                    process.chdir(acadimiatPath);

                    // Step 4: Flutter pub get
                    this.executeCommand(
                        'flutter',
                        ['pub', 'get'],
                        () => {
                            console.log('(Flutter pub get) => Succeeded');

                            // Step 5: Build App Icon
                            this.executeCommand(
                                'flutter',
                                ['pub', 'run', 'flutter_launcher_icons:main'],
                                () => {
                                    console.log('Build App Icon => Succeeded');

                                    // Step 6: Build Android
                                    this.executeCommand(
                                        'flutter',
                                        ['build', 'apk', '--release'],
                                        () => {
                                            console.log(
                                                'Build Android => Succeeded'
                                            );

                                            // Path to the built APK
                                            // const apkPath = path.resolve(currentDir, "build/app/outputs/flutter-apk/app-release.apk");

                                            // Step 7: Navigate back to the original directory
                                            process.chdir(originalDir);
                                            console.log(
                                                'Back to original directory:',
                                                originalDir
                                            );

                                            // Step 8: Delay for 10 seconds before removing the acadimiat directory
                                            // setTimeout(() => {
                                            //   fs.rmdirSync(acadimiatPath, { recursive: true });
                                            //   console.log("Removed directory:", acadimiatPath);
                                            //
                                            // }, 10000); // 10 seconds delay

                                            // Step 9: Delete the app icon file after processing
                                            fs.unlinkSync(newFilePath);

                                            // Step 10: Respond with success
                                            response.json({
                                                message: 'Build successful'
                                            });
                                        },
                                        (code) => {
                                            console.error(
                                                `Build Android failed with exit code ${code}`
                                            );
                                            next(new ServerException());
                                        }
                                    );
                                },
                                (code) => {
                                    console.error(
                                        `Build App Icon failed with exit code ${code}`
                                    );
                                    next(new ServerException());
                                }
                            );
                        },
                        (code) => {
                            console.error(
                                `(Flutter pub get) failed with exit code ${code}`
                            );
                            next(new ServerException());
                        }
                    );
                },
                (code) => {
                    console.error(
                        `Build Template failed with exit code ${code}`
                    );
                    next(new ServerException());
                }
            );
        } catch (error) {
            console.error('Error in generateNewApp:', error);
            next(new ServerException());
        }
    }
}

export default BannerController;
