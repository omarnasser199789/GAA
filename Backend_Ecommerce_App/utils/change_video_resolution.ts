
(function(){
    var ffmpeg = require('fluent-ffmpeg')

    var args = process.argv.slice(2)


    function baseName(str){
        var base = new String(str).substring(str.lastIndexOf('/')+1)
        if(base.lastIndexOf(".") != -1){
            base = base.substring(0, base.lastIndexOf("."))
        }
        return base;
    }

    args.forEach(function(val, index, array){
        var filename = val
        console.log(val)

        var basename = baseName(filename)

        console.log(basename)

        ffmpeg(filename)
        //generate 720p version
        .output(basename + "-1280x720.mp4")
        .videoCodec('libx264')
        // .noAudio()
        .size('1280x720')

        //generate 1080p version
        .output(basename + "-1920x1080.mp4")
        .videoCodec('libx264')
        // .noAudio()
        .size('1920x1080')

        //generate 144p version
        .output(basename + "-256x144.mp4")
        .videoCodec('libx264')
        .noAudio()
        .size('256x144')

        .on('error', function(err){
            console.log(err)
        })
        .on('progress', function(progress){
            console.log('... frames ' + progress.frames)
        })
        .on('end', function(){
            console.log('Finished processing')
        })
        .run()
    })
})()