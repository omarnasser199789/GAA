import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:open_filex/open_filex.dart';
import 'package:acadmiat/core/globals.dart';
import '../../../../../../../../../../../../../injection_container.dart';
import 'package:acadmiat/Theme/style.dart';
import '../../../../../../../../core/classes/constants.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../../../core/widgets/waiting_widget.dart';
import '../../../../../../../../exam_folder/exam_result_page.dart';
import '../../../../../../../../exam_folder/decision_making_page.dart';
import '../../../../../../../../exam_folder/exam_page.dart';
import '../../../../../../../../exam_folder/training_activities/fill_space_inner.dart';
import '../../../../../../../../exam_folder/training_activities/logical_order_page.dart';
import '../../../../../../../../exam_folder/training_activities/match_between_inner_test.dart';
import '../case_stady_folder/case_study_page.dart';
import '../widgets_for_lossonsTab_sidebarTab/lesson_content.dart';
import '../widgets_for_lossonsTab_sidebarTab/video_cell.dart';
import '../../../../../../data/models/my_lecture_model.dart';
import '../../../../../../domain/entities/files_entity.dart';
import '../../../../../../domain/entities/my_lecture_entity.dart';
import '../../../../../../domain/entities/myquizizz_entity.dart';
import '../../../../../../domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../../../../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../../../../widgets/comment_tab/comment_tab.dart';
import '../../../../../widgets/tabs_widget.dart';
import '../../notes_tab.dart';
import 'package:measure_size/measure_size.dart';
import '../../../../../../domain/entities/my_course_entity.dart';
import '../../../../../../domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import '../../../../../bloc/my_courses_bloc.dart';
import '../../../../../bloc/my_courses_event.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../widgets_for_lossonsTab_sidebarTab/cover_widget.dart';
import '../widgets_for_lossonsTab_sidebarTab/loading_lecture_page.dart';
import '../widgets_for_lossonsTab_sidebarTab/video_widget.dart';
import 'package:acadmiat/features/my_courses_feature/data/models/my_course_model.dart'as cs;

class LectureParams{
  final int lectureId;
  final MyCourseEntity myCourseEntity;
  final int index;
  final int part;
  final String courseCover;
  final EdgeInsets mediaQueryPadding;

  LectureParams({
    required this.lectureId,
    required this.myCourseEntity,
    required this.index,
    required this.part,
    required this.courseCover,
    required this.mediaQueryPadding,
  });
}

class LecturePage extends StatefulWidget with MyCoursesState {
  const LecturePage({super.key, required this.lectureParams});
  final LectureParams lectureParams;

  @override
  State<LecturePage> createState() => LecturePageState();
}

class LecturePageState extends State<LecturePage> {
  double heightWidget = 0;
  bool loading = true;
  double addCommentWidgetHeight = 0;
  late int contentLength;
  List<int> bytes = [];
  MyLectureEntity myLectureEntity = MyLectureEntity(
      materialId: -1,
      materialName: '',
      materialLink: '',
      order: -1,
      materialLength: '',
      isDone: false,
      totalScore: -1,
      completitionDate: null,
      currentVideo: CurrentVideo(url: '', currentTime: null, questions: const[], bookmarks: const[]),
      discussion: Discussion(discussionId: -1, lectureId: -1, timeline: null),
      unitId: -1,
      contents: const []);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int selectedItem = 0;
  bool loadingFile = false;
  List<FilesEntity> filesEntity = [];
  bool getFile = false;
  bool firstOne = true;
  EdgeInsetsGeometry defaultPadding= const EdgeInsets.only(bottom: 10, top: 10, left: 17, right: 17);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (isLight()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    int length=0;
    return Scaffold(
      key: scaffoldKey,
      body: BlocProvider(
          create: (BuildContext context) => sl<MyCoursesBloc>(),
          child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
              builder: (context, state) {
                if (kDebugMode) {
                  print("state:$state");
                }
                if (state is Empty) {
                  BlocProvider.of<MyCoursesBloc>(context).add(GetMyLecture(myLectureParams: MyLectureParams(userId: userId(), lectureId: widget.lectureParams.lectureId)));
                }
                if(state is Error){
                  return Scaffold(
                    appBar:appBarWidget("",context,true,null,null),
                    body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                      text1:"عذرا! حدثت مشكلة غير متوقعة",
                      text3: "حدث الان",
                      onTap: () async {
                        BlocProvider.of<MyCoursesBloc>(context).add(GetMyLecture(
                            myLectureParams: MyLectureParams(
                                userId: userId(), lectureId: widget.lectureParams.lectureId)));
                      },
                    ),
                  );
                }
                if (state is SuccessGetMyLectureEntity && firstOne) {
                  firstOne=false;
                  makeVideoFirstIfExist(state);
                  myLectureEntity = state.myLectureEntity;
                  loading = false;
                }
                if (state is SuccessGetFileEntityState) {
                  if (getFile) {
                    ///The openOrDownloadFile() function does not allow recursion
                    getFile = false;
                    // openOrDownloadFile(state.filesEntity, context);
                  }
                }
                if (loading == false) {
                  if(myLectureEntity.contents.isEmpty){
                    return Container();
                  }

                  ///If the content of the lecture contains a video, three tab must be shown which are: Lesson tab, comment and note.
                  if(myLectureEntity.contents[0].type==Constants.VIDEO){
                    length=3;
                  }else{
                    ///If it does not contain a video, we will show only lesson tab.
                    length=1;
                  }

                  return DefaultTabController(
                    length:length,
                    child: SingleChildScrollView(
                      physics: (MediaQuery.of(scaffoldKey.currentContext!).viewInsets.bottom > 0) ? null : const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          MeasureSize(
                            onChange: (Size newSize) {
                              setState(() {
                                heightWidget = newSize.height;
                              });
                            },
                            child: Column(
                              children: [
                                ///If this course contain video show video widget else show course cover
                                doesThisCourseContainAnyVideo(contents:myLectureEntity.contents)?
                                VideoWidget(myLectureEntity: myLectureEntity,
                                  lectureParams: widget.lectureParams,)
                                    :
                                CoverWidget(coverUrl: widget.lectureParams.courseCover,),

                                if (myLectureEntity.contents[0].type != Constants.VIDEO)
                                  const SafeArea(child: SizedBox(height: 20,)),

                                TabWidget(myLectureEntity: myLectureEntity,),
                              ],
                            ),
                          ),

                          Container(
                            height: size.height- heightWidget-widget.lectureParams.mediaQueryPadding.top,
                            child: TabBarView(
                              children: [

                                LessonContent(myLectureEntity: myLectureEntity, courseId: widget.lectureParams.myCourseEntity.id,),

                                CommentTabWidget(myLectureEntity: myLectureEntity, lectureId: widget.lectureParams.lectureId, mediaQueryPadding: widget.lectureParams.mediaQueryPadding,),

                                if (myLectureEntity.contents[0].type == Constants.VIDEO)
                                  NotesTab(
                                    isVimeo: (myLectureEntity.contents[0].file.isVimeo != null)
                                        ? myLectureEntity.contents[0].file.isVimeo
                                        : false,
                                    videoId: myLectureEntity.contents[0].file.id,
                                    key: bookMarksWidgetKey,
                                  ),
                              ],
                            ),
                          ),
                        ], //
                      ),
                    ),
                  );
                } else {
                  return const LoadingLecturePage();
                }
          })),
    );
  }

  /// Checks if the course contains any video content.
  bool doesThisCourseContainAnyVideo({required List<NestedContent> contents}) {
    return contents.any((item) => item.type == Constants.VIDEO);
  }

  /// Retrieves the first video content from the list of contents.
  NestedContent? getVideoFromContents(List<NestedContent> contents) {
    for(var item in contents){
      if(item.type==Constants.VIDEO){return item;}
    }
    return null;
  }

  /// Moves the first video content to the beginning of the list if it exists.
  void makeVideoFirstIfExist(state) {
    final video = getVideoFromContents(state.myLectureEntity.contents);
    if (video != null) {
      state.myLectureEntity.contents.remove(video);
      state.myLectureEntity.contents.insert(0, video);
    }
  }
}