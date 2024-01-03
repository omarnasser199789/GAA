import 'dart:async';
import 'package:flutter/services.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../injection_container.dart';
import '../../../../../launch_page.dart';
import '../../../data/models/my_lecture_model.dart';
import '../../bloc/my_courses_event.dart';
import '../../bloc/my_courses_state.dart';
import '../../pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/loading_video_widget.dart';
import '../../pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/video_cover_widget.dart';
import '../common.dart';
import 'package:measure_size/measure_size.dart';

class AmazonVideoWidget extends StatefulWidget {
  late String videoUrl;
  final NestedContent content;
  int lectureId;
  int contentId;
  int courseId;
  int lectureLogId;
  String  courseCover;

  AmazonVideoWidget(
      {super.key,
        required this.lectureId,
        required this.contentId,
        required this.courseId,
        required this.lectureLogId,
        required this.courseCover,
        required this.content,
        required this.videoUrl});

  @override
  AmazonVideoWidgetState createState() => AmazonVideoWidgetState();
}

class AmazonVideoWidgetState extends State<AmazonVideoWidget> {
  late BetterPlayerController _betterPlayerController;
  Timer? timer;
  DateTime tempDate = DateTime.now();
  int comparisonTime = 0;
  bool theFirstOne=true;

  void geTo({required int second, String? url}) {
    _betterPlayerController.pause();

    if (url != null) {
      widget.videoUrl = url;
    }

    initVideo(
      url: widget.videoUrl,
      startFrom: second,
    );
    play_video = true;
    setState(() {});
  }
  Future<void> stopVideo() async {
    try {
      _betterPlayerController.pause();
    } catch(e) {

      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future<void> playVideo() async {

    try {
      _betterPlayerController.play();
    } catch(e) {

      if (kDebugMode) {
        print(e);
      }
    }

  }

  void editData({
    required int courseId,
    required int lectureLogId,
    required int contentId,
    required int lectureId,
  }) {
    print("Old Data");
    print("courseId:${widget.courseId}");
    print("lectureId:${widget.lectureId}");
    print("contentId:${widget.contentId}");
    print("lectureLogId:${widget.lectureLogId}");
    widget.contentId = courseId;
    widget.courseId = contentId;
    widget.lectureLogId = lectureLogId;
    widget.lectureId = lectureId;
    if (kDebugMode) {
      print("Data edited successfully");
      print("courseId:${widget.courseId}");
      print("lectureId:${widget.lectureId}");
      print("contentId:${widget.contentId}");
      print("lectureLogId:${widget.lectureLogId}");

    }

  }


  @override
  void initState() {
    // bookmarks = widget.content.bookmarks;
    super.initState();
  } // @override

  // HubConnection connection = HubConnectionBuilder()
  //     .withUrl(
  //         baseSignalRUrl,
  //         HttpConnectionOptions(
  //           accessTokenFactory: () async =>
  //               globalSH.getString(CACHED_JWT_TOKEN)!,
  //           transport: HttpTransportType.webSockets,
  //           client: IOClient(
  //               HttpClient()..badCertificateCallback = (x, y, z) => true),
  //           logging: (level, message) => print('$level: $message'),
  //         ))
  //     .withAutomaticReconnect()
  //     .build();

  @override
  void dispose() {
    super.dispose();
    // connection.stop();

    try {
      _betterPlayerController.pause();
    } catch(e) {

      if (kDebugMode) {
        print(e);
      }
    }
  }


  bool startGetSignCookie=false;
  bool play_video = false;
  bool fullScreen = false;
  Size betterPlayerSize=Size(double.infinity,240);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    if (widget.content.file.isVimeo == false ||
        widget.content.file.isVimeo == null) {
      return AspectRatio(
        aspectRatio: 16/9,
        child: BlocProvider(
            create: (BuildContext context) => sl<MyCoursesBloc>(),
            child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print("State:$state");
                  }

                  if (state is Empty) {
                    if(startGetSignCookie==false) {
                      startGetSignCookie=true;
                      BlocProvider.of<MyCoursesBloc>(context).add(GetSignCookie());
                    }
                  }

                  if (state is SuccessGetSignCookieEntity)  {
                    if(theFirstOne) {
                      theFirstOne=false;
                      Future.delayed(const Duration(milliseconds: 1500),() {
                        initVideo(
                          url: widget.videoUrl,
                        );
                        BlocProvider.of<MyCoursesBloc>(context).add(InitVideo());
                      });
                    }
                  }

                  if (state is SuccessInitVideo) {


                    return Stack(
                      children: [
                        MeasureSize(
                          onChange: (Size newSize) {
                            setState(() {
                              betterPlayerSize=newSize;
                            });
                          },

                          child: Container(
                            width: size.width,
                            constraints: BoxConstraints(
                                maxHeight:size.height,
                                maxWidth: size.width
                            ),
                            child: BetterPlayer(
                              controller: _betterPlayerController,
                            ),
                          ),
                        ),
                        if(play_video==false)
                          VideoCaverWidget(onTap: () {
                            _betterPlayerController.play();
                            setState(() {
                              play_video=true;
                            });
                          }, height:  betterPlayerSize.height, coverUrl: widget.courseCover,),



                      ],
                    );
                  }

                  return const LoadingVideoWidget();

                })),
      );
    } else {
      return Container();
    }
  }




  Future<dynamic> initVideo({required String url, int? startFrom}) async {

    _betterPlayerController = BetterPlayerController(
      configurationBetterPlayer(context: context, startFrom: startFrom),
      betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, url,
          useAsmsSubtitles: true, headers: headers),
    );
    _betterPlayerController.addEventsListener(statusListener);
    return 200;
  }







  initSignalR(int time,String methodName) async {

    if (kDebugMode) {
      print(connection.state);
    }
    Map<String, dynamic> data = {};
    if(methodName=='AttendMeeting') {
      data = {
        "courseId": "${widget.courseId}",
        "lectureLogId": widget.lectureLogId,
        "contentId": widget.contentId,
        "userId": "${userId()}",
        "content": "",
        "lectureId": widget.lectureId,
        "time": "${time + 1}"
      };

    }else {
      data = {
        "contentId": widget.contentId,
        "userId": "${userId()}",
        "lectureId": widget.lectureId,
        "connectionId": "${connection.connectionId}",
      };
    }

    print(data);
    await connection.invoke(methodName
        , args: <Object>[
          jsonEncode(data)
        ]).onError((error, stackTrace) => print("******Error*****:$error"));

  }

  statusListener(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      initSignalR(convertDateTimeToSecond(tempDate),'FinishedContent');
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      if(convertDateTimeToSecond(tempDate)>=comparisonTime){
        comparisonTime=convertDateTimeToSecond(tempDate)+10;
        initSignalR(convertDateTimeToSecond(tempDate),'AttendMeeting');
      }

    }
  }
}
