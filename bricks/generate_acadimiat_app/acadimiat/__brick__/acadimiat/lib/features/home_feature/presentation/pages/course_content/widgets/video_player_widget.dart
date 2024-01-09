import 'package:flutter/material.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.courseVideo,
    required this.courseCover,
  }) : super(key: key);

  final String courseVideo;
  final String courseCover;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool playVideo = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetWorkImage(
        borderRadius: BorderRadius.circular(0),
        boxFit: BoxFit.fill,
        url: widget.courseCover,
      ),
    );
  }
}
