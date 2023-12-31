const ffmpeg = require("fluent-ffmpeg");
const ffmpegInstaller = require("@ffmpeg-installer/ffmpeg");
ffmpeg.setFfmpegPath(ffmpegInstaller.path);
const fs = require("fs");

function generateHlsVideo(filename: string): Promise<string[]> {
  return new Promise((resolve, reject) => {
    const files = [];
    let completedProcesses = 0;
    const totalProcesses = 6; // Number of processes (360p, 480p, and 720p)

    function checkCompletion() {
      completedProcesses++;
      if (completedProcesses === totalProcesses) {
        callback();
      }
    }
    //1440000
    function callback() {
      // do something when encoding is done
      fs.writeFile(
        __dirname + "/temp/videos/index.m3u8",
        "#EXTM3U\n#EXT-X-VERSION:5\n#EXT-X-STREAM-INF:BANDWIDTH=1440000,RESOLUTION=480x270\n270p.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=1728000,RESOLUTION=640x360\n360p.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=2528000,RESOLUTION=960x540\n540p.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=4928000,RESOLUTION=1280x720\n720p.m3u8\n#EXT-X-STREAM-INF:BANDWIDTH=9728000,RESOLUTION=1920x1080\n1080p.m3u8",
        function (err) {
          if (err) {
            return console.log(err);
          }
          console.log("The file was saved!");
          const playlistPath = __dirname + "/temp/videos/index.m3u8";
          files.push(playlistPath);
          resolve(files);
        }
      );
    }

    // 180p
    ffmpeg(filename)
      .addOptions([
        "-profile:v main",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 300k",
        "-maxrate 500k",
        "-bufsize 750k",
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/180p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      .noAudio()
      .size("320x180")
      .output(__dirname + "/temp/videos/180p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/180p.m3u8");
        files.push(`${__dirname}/temp/videos/180p_000.ts`);
        checkCompletion();
      })
      .run();

    // 270p (480x270 resolution)
    ffmpeg(filename)
      .addOptions([
        "-profile:v main",
        "-c:a aac",
        "-ar 48000",
        "-b:a 96k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 500k", // Adjust the bitrate based on your requirements
        "-maxrate 800k", // Set the maximum bitrate
        "-bufsize 1200k", // Set the buffer size (in kbps)
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/270p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      .size("480x270")
      .output(__dirname + "/temp/videos/270p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/270p.m3u8");
        files.push(`${__dirname}/temp/videos/270p_000.ts`);
        checkCompletion();
      })
      .run();

    // 360p
    ffmpeg(filename)
      .addOptions([
        //360
        "-profile:v main",
        // '-vf scale=w=640:h=360:force_original_aspect_ratio=decrease',
        "-c:a aac",
        "-ar 48000",
        "-b:a 96k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 800k",
        "-maxrate 856k",
        "-bufsize 1200k",
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/360p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      //   .size("640x360")
      .output(__dirname + "/temp/videos/360p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/360p.m3u8");
        files.push(`${__dirname}/temp/videos/360p_000.ts`);
        checkCompletion();
      })
      .run();

    // 360p mp4 for caching
    ffmpeg(filename)
      .addOptions([
        //360
        "-profile:v main",
        // '-vf scale=w=640:h=360:force_original_aspect_ratio=decrease',
        "-c:a aac",
        "-ar 48000",
        "-b:a 96k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 800k",
        "-maxrate 856k",
        "-bufsize 1200k",
      ])
      //   .size("640x360")
      .output(__dirname + "/temp/videos/360p.mp4")
      .on("end", () => {
        // files.push(__dirname + '/temp/videos/360p.m3u8');
        // files.push(`${__dirname}/temp/videos/360p_000.ts`);
        // checkCompletion();
      })
      .run();

    // 540p (960x540 resolution)
    ffmpeg(filename)
      .addOptions([
        "-profile:v main",
        "-c:a aac",
        "-ar 48000",
        "-b:a 128k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 1500k", // Adjust the bitrate based on your requirements
        "-maxrate 2250k", // Set the maximum bitrate
        "-bufsize 2250k", // Set the buffer size (in kbps)
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/540p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      .size("960x540")
      .output(__dirname + "/temp/videos/540p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/540p.m3u8");
        files.push(`${__dirname}/temp/videos/540p_000.ts`);
        checkCompletion();
      })
      .run();

    // 720p
    ffmpeg(filename)
      .addOptions([
        //720
        "-profile:v main",
        // '-vf scale=w=1280:h=720:force_original_aspect_ratio=decrease',
        "-c:a aac",
        "-ar 48000",
        "-b:a 128k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 2800k",
        "-maxrate 2996k",
        "-bufsize 4200k",
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/720p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      .size("1280x720")
      .output(__dirname + "/temp/videos/720p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/720p.m3u8");
        files.push(`${__dirname}/temp/videos/720p_000.ts`);
        checkCompletion();
      })
      .run();

    // 1080p
    ffmpeg(filename)
      .addOptions([
        "-profile:v main",
        "-c:a aac",
        "-ar 48000",
        "-b:a 192k",
        "-c:v h264",
        "-crf 20",
        "-g 48",
        "-keyint_min 48",
        "-sc_threshold 0",
        "-b:v 5000k",
        "-maxrate 5350k",
        "-bufsize 7500k",
        "-hls_time 4",
        "-hls_segment_filename " + __dirname + "/temp/videos/1080p_%03d.ts",
        "-hls_playlist_type vod",
        "-f hls",
      ])
      .size("1920x1080")
      .output(__dirname + "/temp/videos/1080p.m3u8")
      .on("end", () => {
        files.push(__dirname + "/temp/videos/1080p.m3u8");
        files.push(`${__dirname}/temp/videos/1080p_000.ts`);
        checkCompletion();
      })
      .run();
  });
}

export default generateHlsVideo;
