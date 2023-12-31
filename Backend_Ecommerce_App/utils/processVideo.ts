const { s3 } = require("./s3Bucket");
import * as fs from "fs";
import * as path from "path";
import * as util from "util";
import generateHlsVideo from "./generate_hls_video";
const mime = require("mime-types");

interface UploadedFile {
  fieldname: string;
  originalname: string;
  encoding: string;
  mimetype: string;
  buffer: Buffer;
  size: number;
}

async function processVideo(file: UploadedFile): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    const basename: string = baseName(file.originalname);
    const tempFilePath = path.join(__dirname, "temp", `${basename}.mp4`);

    // Write the buffer to a temporary file
    fs.writeFile(tempFilePath, file.buffer, async (err) => {
      if (err) {
        reject(err);
        return;
      }

      try {
        generateHlsVideo(tempFilePath)
          .then(async (files) => {
            const folderName = generateFolderName(); // Generate a random folder name
            const today = new Date();
            const month = today.toLocaleString("default", {
              month: "long",
            });
            const year = today.getFullYear();
            const indexFileUrl = `https://hi-erbil.s3.amazonaws.com/processVideos/${year}/${month}/${folderName}/index.m3u8`;

            const directoryPath = __dirname + "/temp/videos";
            const extensionsToFilter = [".m3u8", ".ts", ".mp4"];
            const filteredFiles = getFilesWithExtensions(
              directoryPath,
              extensionsToFilter
            );
            for (const filePath of filteredFiles) {
              try {
                const contentType = mime.lookup(filePath); // Get the content type of the file

                uploadToS3(
                  directoryPath + "/" + filePath,
                  folderName,
                  year,
                  month,
                  contentType
                );
                // console.log('File uploaded to S3:', filePath);
                // Do something with the uploaded file if needed
              } catch (error) {
                console.error("Error uploading file to S3:", error);
                // Handle the upload error
              }
            }
            console.log("Video processing completed.");
            // Remove the temporary file after successful upload
            fs.unlinkSync(tempFilePath);
            resolve(indexFileUrl);
          })
          .catch((error) => {
            console.error("Error generating HLS videos:", error);
            // Handle the generation error
          });
      } catch (error) {
        console.error("Error generating or uploading HLS videos:", error);
        // Handle the generation or upload error
      }
    });
  });
}

function baseName(str: string): string {
  const lastDotIndex = str.lastIndexOf(".");
  return lastDotIndex !== -1 ? str.substring(0, lastDotIndex) : str;
}

async function uploadToS3(
  filePath: string,
  folderName: string,
  year,
  month,
  fileType: string
): Promise<void> {
  const fileContent = fs.readFileSync(filePath);

  const params = {
    Key: path.basename(filePath),
    Body: fileContent,
    Bucket: `hi-erbil/processVideos/${year}/${month}/${folderName}`,
    ACL: "private",
    CacheControl: "max-age=31557600",
    ContentType: fileType,
  };

  try {
    await s3.upload(params).promise();
    // Remove the temporary file after successful upload
    fs.unlinkSync(filePath);
  } catch (error) {
    console.error("Error uploading file to S3:", error);
    throw error; // Throw an error in case of upload failure
  }
}

function generateFolderName(): string {
  const timestamp = Date.now();
  const randomString = generateRandomString(10); // You can adjust the length of the random string
  return `${timestamp}_${randomString}`;
}

function generateRandomString(length: number): string {
  const characters =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let randomString = "";
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    randomString += characters[randomIndex];
  }
  return randomString;
}

function getFilesWithExtensions(directoryPath, extensions) {
  try {
    const files = fs.readdirSync(directoryPath);
    const filteredFiles = files.filter((file) => {
      const ext = path.extname(file).toLowerCase();
      return extensions.includes(ext);
    });
    return filteredFiles;
  } catch (error) {
    console.error("Error reading directory:", error);
    return [];
  }
}

export { processVideo };
