import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../launch_page.dart';
import '../../pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/error_vimeo_widget.dart';
import '../../pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/loading_video_widget.dart';
import '../../pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/video_cover_widget.dart';
import '../../../data/models/my_lecture_model.dart';
import 'package:remedi_vimeo_player/remedi_vimeo_player.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../common.dart';
import 'package:measure_size/measure_size.dart';

class VimeoVideoWidget extends StatefulWidget {
  VimeoVideoWidget(
      {Key? key,
        required this.lectureId,
        required this.contentId,
        required this.courseId,
        required this.lectureLogId,
        required this.courseCover,
        required this.content})
      : super(key: key);
  final NestedContent content;
  final int lectureId;
  final int contentId;
  final int courseId;
  final int lectureLogId;
  final String courseCover;
  @override
  VimeoVideoWidgetState createState() => VimeoVideoWidgetState();
}

class VimeoVideoWidgetState extends State<VimeoVideoWidget> with SingleTickerProviderStateMixin {

  late Future<http.Response> futureGetVideosAPI;
  late BetterPlayerController _betterPlayerController;
  bool notRunBefore = true;
  VimeoVideo? vimeoVideo;
  DateTime tempDate = DateTime.now();
  int comparisonTime = 0;
  Timer? timer;
  bool play_video = false;
  Size betterPlayerSize = Size(double.infinity, 240);

  @override
  void dispose() {
    super.dispose();
    // connection.stop();
    try {
      _betterPlayerController.pause();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.content.file.isVimeo == true) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: (notRunBefore == true)
            ? FutureBuilder<dynamic>(
          future: (notRunBefore)
              ? initVimeo(clipId: widget.content.file.clipId.toString())
              : null,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == 200) {
              // if(notRunBefore=true) {
              //   // _betterPlayerController.play();
              // }
              notRunBefore = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                try {
                  _betterPlayerController.pause();
                  // _betterPlayerController.play();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }

                setState(() {});
              });
            }
            if (!snapshot.hasData) {
              return const LoadingVideoWidget();
            }
            if (snapshot.data is VimeoError) {
              return ErrorVimeoWidget(snapshot:snapshot);
            }
            return Container();
          },
        )
            : Stack(
          children: [
            MeasureSize(
              onChange: (Size newSize) {
                setState(() {
                  betterPlayerSize = newSize;
                });
              },
              child: Container(
                width: size.width,
                constraints: BoxConstraints(
                    maxHeight:size.height,
                    maxWidth: size.width
                ),
                child: VimeoPlayer(
                  vimeoVideo: vimeoVideo!,
                  videoController: _betterPlayerController,
                ),
              ),
            ),
            if (play_video == false)
              VideoCaverWidget(onTap: () {
                _betterPlayerController.play();
                setState(() {
                  play_video = true;
                });
              }, height: betterPlayerSize.height, coverUrl: widget.courseCover,),

          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Future<dynamic> initVimeo({int? startFrom, required String clipId}) async {
    // if (notRunBefore == true){

    print("startFrom:$startFrom clipId:$clipId");
    var res = await Vimeo(
      clipId,
      accessKey: vimeoAccessKey,
    ).video;
    if (res is VimeoError) {
      return res;
    }
    if (res is VimeoVideo) {
      vimeoVideo = res;

      ///Orientation on page started
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      _betterPlayerController = BetterPlayerController(
        configurationBetterPlayer(context: context, startFrom: startFrom),
        betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          vimeoVideo!.videoUrl.toString(),
          liveStream: res.isLive,
        ),
      );

      _betterPlayerController.addEventsListener(statusListener);
      // _betterPlayerController.play();

    }

    // }

    return 200;
  }

  initSignalR(int time, String methodName) async {
    // if (connection.state == HubConnectionState.disconnected) {
    //   //disconnected
    //   await connection.start();
    // }
    // if (kDebugMode) {
    //   print(connection.state);
    // }
    // connection.onclose((error) {
    //   if (kDebugMode) {
    //     print("Connection Closed:$error");
    //   }
    // });
    // print("vfdovndfivnd");
    // if (kDebugMode) {
    //   print(connection.state);
    // }

    Map<String, dynamic> data = {};
    if (methodName == 'AttendMeeting') {
      data = {
        "courseId": "${widget.courseId}",
        "lectureLogId": widget.lectureLogId,
        "contentId": widget.contentId,
        "userId": "${userId()}",
        "content": "",
        "lectureId": widget.lectureId,
        "time": "${time + 1}"
      };
    } else {
      data = {
        "contentId": widget.contentId, //
        "userId": "${userId()}",
        "lectureId": widget.lectureId,
        "connectionId": "${connection.connectionId}",
      };
    }

    print(data);
    await connection.invoke(methodName, args: <Object>[
      jsonEncode(data)
    ]).onError((error, stackTrace) => print("******Error*****:$error"));
  }

  statusListener(BetterPlayerEvent event) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        initSignalR(convertDateTimeToSecond(tempDate), 'FinishedContent');
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        if(event.parameters!["progress"].toString()!="0:00:00.000000") {
          tempDate = DateFormat.Hms().parse("${event.parameters!["progress"]}");
        }

        if (convertDateTimeToSecond(tempDate) >= comparisonTime) {
          comparisonTime = convertDateTimeToSecond(tempDate) + 10;
          initSignalR(convertDateTimeToSecond(tempDate), 'AttendMeeting');
        }
      }
    });
    return null;
  }

  Future<void> stopVideo() async {
    try {
      _betterPlayerController.pause();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> playVideo() async {
    try {
      _betterPlayerController.play();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> geTo({required int second, String? clipId}) async {
    notRunBefore = false;
    _betterPlayerController.pause();

    await initVimeo(
        startFrom: second,
        clipId:
        (clipId != null) ? clipId : widget.content.file.clipId.toString());
    play_video = true;
    // notRunBefore=true;
    setState(() {});
  }

  // void editData({required int courseId, required int lectureLogId, required int contentId, required int lectureId,}) {
  //   widget.contentId = courseId;
  //   widget.courseId = contentId;
  //   widget.lectureLogId = lectureLogId;
  //   widget.lectureId = lectureId;
  // }

}
