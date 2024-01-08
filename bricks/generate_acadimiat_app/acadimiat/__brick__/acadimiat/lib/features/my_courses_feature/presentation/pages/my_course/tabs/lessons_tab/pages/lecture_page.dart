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

  LectureParams({
    required this.lectureId,
    required this.myCourseEntity,
    required this.index,
    required this.part,
    required this.courseCover,
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
  double _progress = 0;
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
                  makeVideoFirstIfExit(state);
                  myLectureEntity = state.myLectureEntity;
                  loading = false;
                }
                if (state is SuccessGetFileEntityState) {
                  if (getFile) {
                    ///The openOrDownloadFile() function does not allow recursion
                    getFile = false;
                    openOrDownloadFile(state.filesEntity, context);
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

                          SizedBox(
                            height: (size.height - heightWidget<0)?0:size.height - heightWidget,
                            child: TabBarView(
                              children: [

                                Stack(
                                  children: [
                                    ListView.builder(
                                        itemCount: myLectureEntity.contents.length,
                                        itemBuilder: (context, index) {
                                          if (
                                          myLectureEntity.contents[index].type == Constants.FILE||
                                              myLectureEntity.contents[index].type == Constants.IMAGE||
                                              myLectureEntity.contents[index].type == Constants.ATTACHMENT
                                          ) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {

                                                  ///allow to openOrDownloadFile() function to work.
                                                  getFile = true;

                                                  ///Test the file had been downloaded before or not using file url
                                                  ///because when the file is downloaded, the file URl and PATH are stored in Locale DB
                                                  ///The result is returned in  SuccessGetFileEntityState

                                                  BlocProvider.of<MyCoursesBloc>(context).add(GetFileByUrlEvent(params: GetFileParams(url:  myLectureEntity.contents[index].file.fileName, index: index)));

                                                  ///To show waiting indicator to user.
                                                  selectedItem = index;
                                                  setState(() {
                                                    loadingFile = true;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                                                  child: Padding(
                                                    padding: defaultPadding,
                                                    child: Row(
                                                      children: [
                                                        getIcon(fileName: myLectureEntity.contents[index].file.fileName),
                                                        const SizedBox(width: 8),
                                                        SizedBox(
                                                          width: size.width - 120,
                                                          child: Text(
                                                            myLectureEntity.contents[index].file.fileName,
                                                            maxLines: 1,
                                                            style: blackBoldTextStyle(context: context, fontSize: 11),
                                                          ),
                                                        ),
                                                        ValueListenableBuilder(
                                                            valueListenable: counterNotifier,
                                                            builder: (context, value, _) {
                                                              if (index == selectedItem && _progress != 0) {
                                                                return Stack(
                                                                  alignment: Alignment.center,
                                                                  children: [
                                                                    Center(
                                                                      child: SizedBox(
                                                                        width: 30,
                                                                        height: 30,
                                                                        child: CircularProgressIndicator(strokeWidth: 3, value: _progress,),
                                                                      ),
                                                                    ),
                                                                    Text((_progress * 100).toString().split(".")[0],
                                                                      style: const TextStyle(fontSize: 12),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else if (loadingFile && index == selectedItem) {
                                                                return SizedBox(
                                                                  width: 30,
                                                                  height: 30,
                                                                  child: CircularProgressIndicator(backgroundColor: Colors.grey,
                                                                    color: Theme.of(context).primaryColor,
                                                                  ),
                                                                );
                                                              } else {
                                                                return Container();
                                                              }
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          if (myLectureEntity.contents[index].type == Constants.VIDEO) {
                                            return VideoCell(fileName: myLectureEntity.contents[index].file.fileName);
                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.TEXT) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor: Colors.transparent,
                                                      isScrollControlled: true,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding: const EdgeInsets.only(top:87),
                                                          child: Material(
                                                            color: Theme.of(context).scaffoldBackgroundColor,
                                                            borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                topRight: Radius.circular(10)),
                                                            child: StatefulBuilder(
                                                                builder: (BuildContext context, StateSetter mystate) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(left: 17, right: 17),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                  width: 50,
                                                                                  height: 3,
                                                                                  color: Theme.of(context).canvasColor)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          constraints:BoxConstraints(
                                                                              maxHeight: size.height-120
                                                                          ),
                                                                          child: SingleChildScrollView(
                                                                            child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [


                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top:20,bottom: 40),
                                                                                  child:  HtmlWidget(
                                                                                    "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; font-family:${"taleeq-bold"} !important; font-size:${0.8}em !important' color:${Theme.of(context).canvasColor} !important'>${myLectureEntity.contents[index].body.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
                                                                                    customWidgetBuilder: (element) {
                                                                                      if (element.attributes['background-color'] == 'bar') {
                                                                                        return Container(
                                                                                          width: 20,
                                                                                          height: 30,
                                                                                          color: Colors.red,
                                                                                        );
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),

                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        );
                                                      }).whenComplete(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                                                  child: Padding(
                                                    padding: defaultPadding,
                                                    child: Row(
                                                      children: [
                                                        getIcon(fileName:"txt"),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        SizedBox(
                                                          width: size.width - 120,
                                                          child: Text(
                                                            parseHtmlString(myLectureEntity.contents[index].body),maxLines: 1,
                                                            style:
                                                            blackBoldTextStyle(context: context, fontSize: 11),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.CASE_STUDIES) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {

                                                  goTo(context, (context) => CaseStudyPage(
                                                    fromLectureContents: true,
                                                    caseStudy:
                                                    cs.CaseStudy(
                                                        casestudyId:myLectureEntity.contents[index].activity.decision!.id,
                                                        open:true,
                                                        header:parseHtmlString(myLectureEntity.contents[index].activity.decision!.body),
                                                        body:"BODY",
                                                        solution:cs.Solution(solutionId: -1, answers: []),
                                                        attendanceTable:null
                                                    ),
                                                    attendanceTable: myLectureEntity.contents[index].activity.decision!.attendanceTable,
                                                    courseId: widget.lectureParams.myCourseEntity.id,));

                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .cardColor,
                                                          width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 13, top: 13, left: 17, right: 17),
                                                    child: Row(
                                                      children: [
                                                        getIcon( fileName: "q&A",),

                                                        const SizedBox(width: 8),

                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width - 150,
                                                              child: Text(
                                                                myLectureEntity.contents[index].activity.title.toString(),
                                                                maxLines: 1,
                                                                style:
                                                                blackBoldTextStyle(context: context, fontSize: 11),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:5),
                                                              child: Text("حالة دراسية",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.DECISION_MAKING) {
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  goTo(context, (context) =>DecisionMakingPage(nestedContent:myLectureEntity.contents[index]));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 13, top: 13, left: 17, right: 17),
                                                    child: Row(
                                                      children: [
                                                        getIcon( fileName: "q&A",),

                                                        const SizedBox(width: 8),

                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width - 150,
                                                              child: Text(
                                                                parseHtmlString(myLectureEntity.contents[index].activity.caseStudy.caseHeader),
                                                                maxLines: 1,
                                                                style: blackBoldTextStyle(context: context, fontSize: 11),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                          }

                                          ///نشاط تدريبي(true or false)
                                          else if (myLectureEntity.contents[index].type == Constants.QUIZZ) {
                                            if( myLectureEntity.contents[index].activity.quizz!.attendanceTable.isEmpty){
                                              ///The student has not yet taken the test
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5, top: 10),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    goTo(context, (context) =>
                                                        ExamPage(
                                                            cameFrom: LecturePage,
                                                            myQuizizzEntity:
                                                            MyQuizizzEntity(id: myLectureEntity.contents[index].activity.quizz!.id,///QuizzId
                                                                materialId: myLectureEntity.contents[index].id,///ContentId
                                                                courseId: -1,
                                                                name: myLectureEntity.contents[index].activity.quizz!.name,
                                                                beforeStart: false,
                                                                optional: false,
                                                                timeLimit: 0,
                                                                shuffle: false,
                                                                repetition: 0,
                                                                myAttempts: 0,
                                                                ifPassed: 0,
                                                                ifFailed: 0,
                                                                minScore: 0,
                                                                attendance: null,
                                                                questions: myLectureEntity.contents[index].activity.quizz!.questions
                                                            ))
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                            color: Theme.of(context)
                                                                .cardColor,
                                                            width: 1)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 13, top: 13, left: 17, right: 17),
                                                      child: Row(
                                                        children: [
                                                          getIcon( fileName: "q&A",),

                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: size.width - 150,
                                                                child: Text(
                                                                  myLectureEntity.contents[index].activity.title.toString(),
                                                                  maxLines: 1,
                                                                  style:
                                                                  blackBoldTextStyle(context: context, fontSize: 11),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top:5),
                                                                child: Text("${myLectureEntity.contents[index].activity.quizz!.questions.length} سؤال",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }else{
                                              ///The student submitted the test and now we want to show the result
                                              ///The answers or result are inside Attendance Table
                                              //ExamInfoPage
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5, top: 10),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    goTo(context, (context) =>
                                                        ExamResultPage(nestedContent: myLectureEntity.contents[index],)
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                            color: Theme.of(context).cardColor,
                                                            width: 1)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 13, top: 13, left: 17, right: 17),
                                                      child: Row(
                                                        children: [
                                                          getIcon( fileName: "q&A",),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: size.width - 150,
                                                                child: Text(
                                                                  myLectureEntity.contents[index].activity.title.toString(),
                                                                  maxLines: 1,
                                                                  style:
                                                                  blackBoldTextStyle(context: context, fontSize: 11),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top:5),
                                                                child: Text("${myLectureEntity.contents[index].activity.quizz!.questions.length} سؤال",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.MATCH_BETWEEN) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  // DragAndDropPage
                                                  goTo(context, (context) =>MatchBetweenInnerTest(nestedContent:myLectureEntity.contents[index]));



                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .cardColor,
                                                          width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 13,
                                                        top: 13,
                                                        left: 17,
                                                        right: 17),
                                                    child: Row(
                                                      //
                                                      children: [
                                                        getIcon( fileName: "q&A",),


                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width - 150,
                                                              child: Text(
                                                                myLectureEntity.contents[index].activity.title.toString(),
                                                                maxLines: 1,
                                                                style:
                                                                blackBoldTextStyle(
                                                                    context:
                                                                    context,
                                                                    fontSize: 11),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:5),
                                                              child: Text("توصيل جمل",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.LOGICAL_ORDER) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  goTo(context, (context) =>LogicalOrderPage(nestedContent:myLectureEntity.contents[index]));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .cardColor,
                                                          width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 13,
                                                        top: 13,
                                                        left: 17,
                                                        right: 17),
                                                    child: Row(
                                                      //
                                                      children: [
                                                        getIcon( fileName: "q&A",),


                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width - 150,
                                                              child: Text(
                                                                myLectureEntity.contents[index].activity.title.toString(),
                                                                maxLines: 1,
                                                                style:
                                                                blackBoldTextStyle(
                                                                    context:
                                                                    context,
                                                                    fontSize: 11),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:5),
                                                              child: Text("ترتيب جمل",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.FILL_SPACE) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  goTo(context, (context) =>FillSpaceInner(nestedContent:myLectureEntity.contents[index]));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .cardColor,
                                                          width: 1)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 13,
                                                        top: 13,
                                                        left: 17,
                                                        right: 17),
                                                    child: Row(
                                                      //
                                                      children: [
                                                        getIcon( fileName: "q&A",),


                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: size.width - 150,
                                                              child: Text(
                                                                myLectureEntity.contents[index].activity.title.toString(),
                                                                maxLines: 1,
                                                                style:
                                                                blackBoldTextStyle(
                                                                    context:
                                                                    context,
                                                                    fontSize: 11),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:5),
                                                              child: Text("املاء الفراغ",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.LINK){
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (kDebugMode) {
                                                    print(parseHtmlString(myLectureEntity.contents[index].body));
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                                                  child: Padding(
                                                    padding: defaultPadding,
                                                    child: Row(
                                                      children: [
                                                        getLinkIcon(
                                                            fileName:parseHtmlString(myLectureEntity.contents[index].body)),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        SizedBox(
                                                          width: size.width - 120,
                                                          child: Text(
                                                            parseHtmlString(myLectureEntity.contents[index].body),
                                                            maxLines: 1,
                                                            style:
                                                            blackBoldTextStyle(context: context, fontSize: 11),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          else if (myLectureEntity.contents[index].type == Constants.LIVE_STREAMING){
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5, top: 10),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Uri url =  Uri.parse(myLectureEntity.contents[index].meetingLink);
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 1)),
                                                  child: Padding(
                                                    padding: defaultPadding,
                                                    child: Row(
                                                      children: [
                                                        getIcon(
                                                            fileName:"live-line"),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        SizedBox(
                                                          width: size.width - 120,
                                                          child: Text(
                                                            parseHtmlString(myLectureEntity.contents[index].body),
                                                            maxLines: 1,
                                                            style: blackBoldTextStyle(context: context, fontSize: 11),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          if (myLectureEntity.contents[index].type != 1) {
                                            return Text(myLectureEntity.contents[index].type.toString());
                                          }
                                          return Container();
                                        }),
                                    if (loading) const WaitingWidget(),
                                  ],
                                ),

                                CommentTabWidget(myLectureEntity: myLectureEntity, lectureId: widget.lectureParams.lectureId,),

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

  Future<void> openOrDownloadFile(FilesEntity filesEntity, BuildContext context) async {
    ///If the file has already been set in Locale DB, the filesEntity.items list will not be empty.
    if (kDebugMode) {
      print("If the file has already been set in Locale DB, the filesEntity.items list will not be empty? ${filesEntity.items.isEmpty}");
    }
    if (filesEntity.items.isNotEmpty){
      ///Open file
      if (kDebugMode) {
        print("Open File:${filesEntity.items.last.path}");
      }

      /// Checks whether the file system entity with this path exists.
      bool fileExists = await File(filesEntity.items.last.path).exists();
      // print("Checks whether the file system entity with this path exists=$fileExists");

      ///If file exists
      if (fileExists) {
        ///Open file
        if (kDebugMode) {
          print("file exists");
        }
        try {
          OpenFilex.open(filesEntity.items.last.path);
        } catch (e) {
          if (kDebugMode) {
            print("ERROR");
            print(e);
          }
        }
        setState(() {
          loadingFile = false;
        });
      }

      ///If file (NOT) exists
      else {
        if (kDebugMode) {
          print("file (NOT) exists");
        }
        deleteFromDB();
        if(!mounted) return;
        downloadAndOpenFile(filesEntity, context);
      }
    }

    ///The file was not previously downloaded because it does not have an URL in Locale DB
    else {
      ///The file is being downloaded for the first time.
      downloadAndOpenFile(filesEntity, context);
    }
  }

  void downloadAndOpenFile(FilesEntity filesEntity, BuildContext context) {
    downloadFile(
      myLectureEntity.contents[filesEntity.index].fileUrl,
      myLectureEntity.contents[filesEntity.index].file.fileName,
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        _progress = downloadedLength / contentLength;
        // setState(() {});
        counterNotifier.value = "$_progress%";
      },
    );
  }

  Future<dynamic> downloadFile(String url, String fileName, Function(List<int> newBytes) listenFunction) async {
    bytes = [];
    final request = Request('GET', Uri.parse(url));
    final StreamedResponse response = await Client().send(request);
    if(response.contentLength!=null){
      contentLength = response.contentLength!;
    }else{
      contentLength=0;
    }

    response.stream.listen(
      listenFunction,
      onDone: () async {
        _progress = 0;
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File('$dir/$fileName');
        await file.writeAsBytes(bytes);

        ///After the file has been downloaded and taken into the device files,
        /// the file path is now stored in the database by URL
        if (kDebugMode) {
          print("the file path is now stored in the database by URL");
        }

        if(!mounted) return;
        BlocProvider.of<MyCoursesBloc>(context).add(AddFileEvent(
            params: AddFileParams(name: fileName, path: file.path, url: url)));

        try {
          OpenFilex.open(file.path);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
        setState(() {
          loadingFile = false;
        });
      },
      onError: (e) {
        if (kDebugMode) {
          print(e);
        }
      },
      cancelOnError: true,
    );

    return "";
  }

  void deleteFromDB() {}

  doesThisCourseContainAnyVideo({required List<NestedContent> contents}) {
    for(var item in contents){
      if(item.type==Constants.VIDEO){return true;}
    }
    return false;
  }

  NestedContent? getVideoFromContents(List<NestedContent> contents) {
    for(var item in contents){
      if(item.type==Constants.VIDEO){return item;}
    }
    return null;
  }

  void makeVideoFirstIfExit(state) {
    NestedContent ? video = getVideoFromContents(state.myLectureEntity.contents);
    if(video!=null){
      for(int i=0;state.myLectureEntity.contents.length>i;i++){
        if(state.myLectureEntity.contents[i].type==Constants.VIDEO){
          state.myLectureEntity.contents.removeAt(i);
        }
      }
      state.myLectureEntity.contents.insert(0, video);
    }
  }
}