import * as express from 'express';
import BaseController from '../BaseController';
import CreateUpdateDTO from './GenerateApp.dto';
import ServerException from '../../exceptions/ServerException';
import * as path from 'path';
import { spawn } from 'child_process';
import HttpException from '../../exceptions/HttpExceptions';
import validationMiddleware from '../../middleware/validation.middleware';
import * as fs from 'fs';

const { storeImage } = require('../../utils/fileUploadHandler');

class GenerateAppController extends BaseController {
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
        this.router.post(
            this.generateIOSVersion,
            storeImage,
            validationMiddleware(CreateUpdateDTO),
            this.generateIOSApp.bind(this)
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

    private async generateAndroidApp(
        request: express.Request,
        response: express.Response,
        next: express.NextFunction
    ) {
        try {
            const createOrUpdateObject: CreateUpdateDTO = request.body;
            const { icon } = request.files;

            if (!icon || icon.length === 0) {
                next(new HttpException(422, 'App icon is missing'));
                return;
            }

            const newFilePath = await this.saveIconToFile(icon[0].buffer);

            await this.buildTemplate(createOrUpdateObject);

            await this.buildAndroidApp(newFilePath);

            this.cleanupAndRespond(response, newFilePath);
        } catch (error) {
            console.error('Error in generate Android App:', error);
            next(new ServerException());
        }
    }

    private async generateIOSApp(
        request: express.Request,
        response: express.Response,
        next: express.NextFunction
    ) {
        try {
            const createOrUpdateObject: CreateUpdateDTO = request.body;
            const { icon } = request.files;

            if (!icon || icon.length === 0) {
                next(new HttpException(422, 'App icon is missing'));
                return;
            }

            const newFilePath = await this.saveIconToFile(icon[0].buffer);

            await this.buildTemplate(createOrUpdateObject);

            await this.buildIOSApp(newFilePath);

            this.cleanupAndRespond(response, newFilePath);
        } catch (error) {
            console.error('Error in generate IOS App:', error);
            next(new ServerException());
        }
    }

    private async saveIconToFile(buffer: Buffer): Promise<string> {
        const newFileName = 'logo.png';
        const targetDirectory = '/Users/omernasser/Documents/GitHub/GAA/bricks/generate_acadimiat_app/acadimiat/__brick__/acadimiat/assets';
        const newFilePath = path.join(targetDirectory, newFileName);
        fs.writeFileSync(newFilePath, buffer);
        return newFilePath;
    }

    private async buildTemplate(createOrUpdateObject: CreateUpdateDTO): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            this.executeCommand(
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
                resolve,
                (code) => {
                    console.error(`Build Template failed with exit code ${code}`);
                    reject(new ServerException());
                }
            );
        });
    }

    private async buildIOSApp(newFilePath: string): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            const originalDir = process.cwd();
            const currentDir = process.cwd();
            const acadimiatPath = path.resolve(currentDir, 'acadimiat');
            console.log('Navigating to:', acadimiatPath);
            process.chdir(acadimiatPath);

            this.flutterPubGet()
                .then(() => this.flutterRunLauncherIcons())
                .then(() => this.flutterBuildIOS())
                .then(() => {
                    process.chdir(originalDir);
                    console.log('Back to original directory:', originalDir);
                    fs.unlinkSync(newFilePath);
                    resolve();
                })
                .catch((error) => {
                    console.error('Error building Android app:', error);
                    reject(new ServerException());
                });
        });
    }
    private async buildAndroidApp(newFilePath: string): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            const originalDir = process.cwd();
            const currentDir = process.cwd();
            const acadimiatPath = path.resolve(currentDir, 'acadimiat');
            console.log('Navigating to:', acadimiatPath);
            process.chdir(acadimiatPath);

            this.flutterPubGet()
                .then(() => this.flutterRunLauncherIcons())
                .then(() => this.flutterBuildApk())
                .then(() => {
                    process.chdir(originalDir);
                    console.log('Back to original directory:', originalDir);
                    fs.unlinkSync(newFilePath);
                    resolve();
                })
                .catch((error) => {
                    console.error('Error building Android app:', error);
                    reject(new ServerException());
                });
        });
    }

    private async flutterPubGet(): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            this.executeCommand(
                'flutter',
                ['pub', 'get'],
                () => {
                    console.log('(Flutter pub get) => Succeeded');
                    resolve();
                },
                (code) => {
                    console.error(`(Flutter pub get) failed with exit code ${code}`);
                    reject(new ServerException());
                }
            );
        });
    }

    private async flutterRunLauncherIcons(): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            this.executeCommand(
                'flutter',
                ['pub', 'run', 'flutter_launcher_icons:main'],
                () => {
                    console.log('Run Flutter Launcher Icons => Succeeded');
                    resolve();
                },
                (code) => {
                    console.error(`Run Flutter Launcher Icons failed with exit code ${code}`);
                    reject(new ServerException());
                }
            );
        });
    }

    private async flutterBuildIOS(): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            this.executeCommand(
                'flutter',
                ['build', 'ios', '--release'],
                () => {
                    console.log('Build IOS => Succeeded');
                    resolve();
                },
                (code) => {
                    console.error(`Build IOS failed with exit code ${code}`);
                    reject(new ServerException());
                }
            );
        });
    }

    private async flutterBuildApk(): Promise<void> {
        return new Promise<void>((resolve, reject) => {
            this.executeCommand(
                'flutter',
                ['build', 'apk', '--release'],
                () => {
                    console.log('Build Android APK => Succeeded');
                    resolve();
                },
                (code) => {
                    console.error(`Build Android APK failed with exit code ${code}`);
                    reject(new ServerException());
                }
            );
        });
    }

    private cleanupAndRespond(response: express.Response, newFilePath: string): void {
        const acadimiatPath = path.resolve(process.cwd(), 'acadimiat');
        setTimeout(() => {
            fs.rmdirSync(acadimiatPath, { recursive: true });
            console.log("Removed directory:", acadimiatPath);
        }, 10000); // 10 seconds delay

        response.json({
            message: 'Build successful'
        });
    }
}

export default GenerateAppController;
