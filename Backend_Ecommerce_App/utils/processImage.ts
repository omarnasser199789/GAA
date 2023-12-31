const { s3 } = require("./s3Bucket");
const sharp = require('sharp');
const { v4: uuidV4 } = require("uuid");

interface ProcessedImage {
    width: number;
    height: number;
    url: string;
}

async function processImage(file: any): Promise<ProcessedImage> {
    return new Promise<ProcessedImage>(async (resolve, reject) => {
        let width, height;
        let buffer: any = file.buffer;
        // If the file is an image, use sharp to get its width and height
        const metadata = await sharp(buffer).metadata();
        width = metadata.width;
        height = metadata.height;
        const url = await uploadToS3(buffer);

          const processedImage: ProcessedImage = {
            width: width,
            height: height,
            url: url
        };


        // Resolve with the processed image object
        resolve(processedImage);
    });
}

async function uploadToS3(buffer: any): Promise<string> {
    const key = `${uuidV4()}`;
    const today = new Date();
    const month = today.toLocaleString("default", { month: "long" });
    const year = today.getFullYear();
    let fileUrl = `https://hi-erbil.s3.amazonaws.com/processImages/${year}/${month}/${key}`;
    const params = {
        Key: `${key}`,
        Body: buffer,
        Bucket: `hi-erbil/processImages/${year}/${month}`,
        ACL: "private",
        CacheControl: "max-age=31557600",
    };

    try {
        await s3.upload(params).promise();
        console.log(`File uploaded successfully to S3: ${fileUrl}`);
        return fileUrl; // Return the file URL after successful upload
    } catch (error) {
        console.error("Error uploading file to S3:", error);
        throw error; // Throw an error in case of upload failure
    }
}

export {
    processImage
};
