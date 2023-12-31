const { v4: uuidV4 } = require('uuid');
const { s3 } = require('./s3Bucket');
const { processVideo } = require('./processVideo');
const { processImage } = require('./processImage');
const multer = require('multer');
const multerStorage = multer.memoryStorage();
const sharp = require('sharp');
const upload = multer({
    storage: multerStorage
});
const uploadImage = upload.fields([
    { name: 'image', minCount: 1 },
    { name: 'icon' }
]);

const storeImage: Function = (req, res, next) => {
    uploadImage(req, res, (err) => {
        if (err instanceof multer.MulterError) {
            if (err.code === 'LIMIT_UNEXPECTED_FILE') {
                console.log(err);
                res.status(422).send('Image files limitation is not satisfied');
                return;
            }
        } else if (err) {
            res.status(422).send(err);
            return;
        }
        next();
    });
};

const saveFilesToS3: Function = async (files = []) => {
    let filesWithPaths: {
        path: string;
        isVideo: boolean;
        quality?: number;
        width?: number;
        height?: number;
    }[] = [];
    await Promise.all(
        files.map(async (file) => {
            const fileType = file.mimetype;
            let width, height, quality;
            if (fileType === 'video/mp4') {
                const videoUrls = await processVideo(file);
                console.log({ videoUrls });
                filesWithPaths.push({
                    path: videoUrls,
                    isVideo: true,
                    quality,
                    width,
                    height
                });
            } else if (fileType.startsWith('image/')) {
                const { width, height, url } = await processImage(file);
                filesWithPaths.push({
                    path: url,
                    isVideo: false,
                    quality,
                    width,
                    height
                });
            }
        })
    );
    return filesWithPaths;
};

const deleteFileFromS3ByUrl: Function = async (fileUrl) => {
    try {
        const parsedUrl = new URL(fileUrl);
        const bucketName = parsedUrl.hostname.split('.')[0]; // Assumes bucket name is part of the URL
        const fileKey = parsedUrl.pathname.substring(1); // Remove leading slash

        const params = {
            Bucket: bucketName,
            Key: fileKey
        };

        await s3.deleteObject(params).promise();
        console.log(
            `File '${fileKey}' deleted successfully from S3 bucket '${bucketName}'.`
        );
    } catch (error) {
        console.error(
            `Error deleting file from S3 using URL '${fileUrl}':`,
            error
        );
        throw error;
    }
};

module.exports = {
    saveFilesToS3,
    storeImage,
    deleteFileFromS3ByUrl
};
