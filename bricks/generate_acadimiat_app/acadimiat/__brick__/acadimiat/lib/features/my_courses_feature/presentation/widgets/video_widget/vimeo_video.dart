import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/my_lecture_model.dart';
import 'dart:async';


class VimeoVideoWidget extends StatefulWidget {
  VimeoVideoWidget(
      {super.key,
      required this.lectureId,
      required this.contentId,
      required this.courseId,
      required this.lectureLogId,
      required this.courseCover,
      required this.content});
  final NestedContent content;
  int lectureId;
  int contentId;
  int courseId;
  int lectureLogId;
  String courseCover;
  @override
  VimeoVideoWidgetState createState() => VimeoVideoWidgetState();
}

class VimeoVideoWidgetState extends State<VimeoVideoWidget>
    with SingleTickerProviderStateMixin {

  void editData({
    required int courseId,
    required int lectureLogId,
    required int contentId,
    required int lectureId,
  }) {
    widget.contentId = courseId;
    widget.courseId = contentId;
    widget.lectureLogId = lectureLogId;
    widget.lectureId = lectureId;
  }

  Timer? timer;
  bool play_video = false;
  Size betterPlayerSize = Size(double.infinity, 240);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
