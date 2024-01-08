import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../../../../Theme/style.dart';
import '../../../../../../../../core/globals.dart';
import '../../../../../../domain/entities/my_lecture_entity.dart';
import '../../../../../widgets/video_widget/amazon_video.dart';
import '../../../../../widgets/video_widget/vimeo_video.dart';
import '../pages/lecture_page.dart';
import 'package:screen_protector/screen_protector.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.myLectureEntity ,required this.lectureParams}) : super(key: key);
  final MyLectureEntity myLectureEntity;
  final LectureParams lectureParams;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool _isRecording = false;
  Timer? _timer ;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _checkIsRecording();
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkIsRecording() async {
    bool isRecording = await ScreenProtector.isRecording();
    if(_isRecording!=isRecording){
      setState(() {
        _isRecording = isRecording;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIsRecording();
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.start,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          if(!_isRecording)
          AmazonVideoWidget(
            key: amazonVideoWidgetKey,
            videoUrl: widget.myLectureEntity.currentVideo.url,
            content:
            widget.myLectureEntity.contents[0],
            lectureId:widget.lectureParams.lectureId,
            courseId:widget.lectureParams.myCourseEntity.id,
            contentId:
            (widget.lectureParams.myCourseEntity.courseContents[widget.lectureParams.part].contents[widget.lectureParams.index].lectureContents.isNotEmpty)?
            widget.lectureParams.myCourseEntity.courseContents[widget.lectureParams.part].contents[widget.lectureParams.index].lectureContents[0].id:0,
            lectureLogId: widget.lectureParams.myCourseEntity.courseRecord.unitsLog[widget.lectureParams.part].lecturesLog[0].id,
            courseCover:widget.lectureParams.courseCover,
          ),

          if(!_isRecording)
          VimeoVideoWidget(
            courseCover: widget.lectureParams.courseCover,
            key: vimeoVideoWidgetKey,
            content:
            widget.myLectureEntity.contents[0],
            lectureId: widget.lectureParams.lectureId,
            contentId:
            (widget.lectureParams.myCourseEntity.courseContents[widget.lectureParams.part].contents[widget.lectureParams.index].lectureContents.isNotEmpty)?
            widget.lectureParams.myCourseEntity.courseContents[widget.lectureParams.part].contents[widget.lectureParams.index].lectureContents[0].id:0,
            courseId:widget.lectureParams.myCourseEntity.id,
            lectureLogId: widget.lectureParams.myCourseEntity.courseRecord.unitsLog[widget.lectureParams.part].lecturesLog[0].id,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 7),
            child: Text(
              widget.myLectureEntity.contents[0].file.fileName,
              style: blackBoldTextStyle(context: context, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

