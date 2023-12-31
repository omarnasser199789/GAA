// const ffmpeg = require('fluent-ffmpeg');
// const { s3 } = require('./s3Bucket');
// import { generateHLSVideos } from './generate_hls_video';
// import * as fs from 'fs';
// import * as path from 'path';
// import * as util from 'util';
// const readFileAsync = util.promisify(fs.readFile);

// interface UploadedFile {
//     fieldname: string;
//     originalname: string;
//     encoding: string;
//     mimetype: string;
//     buffer: Buffer;
//     size: number;
// }

// interface ProcessedVideo {
//     quality: number;
//     url: string;
// }

// async function processVideo(file: UploadedFile): Promise<ProcessedVideo[]> {
//     return new Promise<ProcessedVideo[]>((resolve, reject) => {
//         const basename: string = baseName(file.originalname);
//         const tempFilePath = path.join(__dirname, 'temp', `${basename}.mp4`);

//         // Write the buffer to a temporary file
//         fs.writeFile(tempFilePath, file.buffer, async (err) => {
//             if (err) {
//                 reject(err);
//                 return;
//             }

//             const playlistPath = path.join(
//                 path.join(__dirname, 'temp', `${basename}-1080p`),
//                 `playlist-1080p.m3u8`
//             );
//             const segmentPath = path.join(
//                 path.join(__dirname, 'temp', `${basename}-1080p`),
//                 'stream%d.ts'
//             );

//             console.log('vfvvfdkjnvkjdfndjnkd');
//             console.log(tempFilePath);
//             // console.log(segmentPath);

//             try {
//                 generateHLSVideos(tempFilePath, () => {
//                     console.log('HLS videos generated successfully.');
//                     // Do something after generating HLS videos, if needed
//                 });
//             } catch (err) {
//                 console.log(err);
//             }
//         });
//     });
// }

// function baseName(str: string): string {
//     const lastDotIndex = str.lastIndexOf('.');
//     return lastDotIndex !== -1 ? str.substring(0, lastDotIndex) : str;
// }

// async function uploadToS3(filePath: string, mimetype: string): Promise<string> {
//     const fileContent = fs.readFileSync(filePath);
//     const today = new Date();
//     const month = today.toLocaleString('default', { month: 'long' });
//     const year = today.getFullYear();
//     let fileUrl = `https://hi-erbil.s3.amazonaws.com/processVideos/${year}/${month}/${path.basename(
//         filePath
//     )}`;
//     const params = {
//         Key: path.basename(filePath),
//         Body: fileContent,
//         Bucket: `hi-erbil/processVideos/${year}/${month}`,
//         ACL: 'private',
//         CacheControl: 'max-age=31557600',
//         ContentType: 'video/mp4'
//     };

//     try {
//         await s3.upload(params).promise();
//         console.log(`File uploaded successfully to S3: ${fileUrl}`);
//         // Remove the temporary file after successful upload
//         // fs.unlinkSync(filePath);
//         return fileUrl; // Return the file URL after successful upload
//     } catch (error) {
//         console.error('Error uploading file to S3:', error);
//         throw error; // Throw an error in case of upload failure
//     }
// }

// export { processVideo };
