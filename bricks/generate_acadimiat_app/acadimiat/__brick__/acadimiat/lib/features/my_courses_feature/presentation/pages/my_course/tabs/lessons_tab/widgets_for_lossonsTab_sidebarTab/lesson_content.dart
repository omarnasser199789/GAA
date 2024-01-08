import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/Theme/style.dart';
import '../../../../../../../../core/classes/constants.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../exam_folder/exam_result_page.dart';
import '../../../../../../../../exam_folder/decision_making_page.dart';
import '../../../../../../../../exam_folder/exam_page.dart';
import '../../../../../../../../exam_folder/training_activities/fill_space_inner.dart';
import '../../../../../../../../exam_folder/training_activities/logical_order_page.dart';
import '../../../../../../../../exam_folder/training_activities/match_between_inner_test.dart';
import '../case_stady_folder/case_study_page.dart';
import '../pages/lecture_page.dart';
import '../widgets_for_lossonsTab_sidebarTab/video_cell.dart';
import '../../../../../../domain/entities/myquizizz_entity.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:acadmiat/features/my_courses_feature/data/models/my_course_model.dart'as cs;
import '../../../../../../domain/entities/my_lecture_entity.dart';


class LessonContent extends StatefulWidget {
  const LessonContent({super.key, required this.myLectureEntity, required this.courseId});
  final MyLectureEntity myLectureEntity;
  final int courseId;

  @override
  State<LessonContent> createState() => _LessonContentState();
}

class _LessonContentState extends State<LessonContent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: widget.myLectureEntity.contents.length,
        itemBuilder: (context, index) {
          if (
          widget.myLectureEntity.contents[index].type == Constants.FILE||
              widget.myLectureEntity.contents[index].type == Constants.IMAGE||
              widget.myLectureEntity.contents[index].type == Constants.ATTACHMENT
          ) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {

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
                        getIcon(fileName: widget.myLectureEntity.contents[index].file.fileName),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: size.width - 120,
                          child: Text(
                            widget.myLectureEntity.contents[index].file.fileName,
                            maxLines: 1,
                            style: blackBoldTextStyle(context: context, fontSize: 11),
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: counterNotifier,
                            builder: (context, value, _) {
                              return Container();
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          if (widget.myLectureEntity.contents[index].type == Constants.VIDEO) {
            return VideoCell(fileName: widget.myLectureEntity.contents[index].file.fileName);
          }

          else if (widget.myLectureEntity.contents[index].type == Constants.TEXT) {
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
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            child: StatefulBuilder(
                                builder: (BuildContext context, StateSetter _) {
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
                                                    "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; font-family:${"taleeq-bold"} !important; font-size:${0.8}em !important' color:${Theme.of(context).canvasColor} !important'>${widget.myLectureEntity.contents[index].body.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
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
                            parseHtmlString(widget.myLectureEntity.contents[index].body),maxLines: 1,
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

          else if (widget.myLectureEntity.contents[index].type == Constants.CASE_STUDIES) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {

                  goTo(context, (context) => CaseStudyPage(
                    fromLectureContents: true,
                    caseStudy:
                    cs.CaseStudy(
                        casestudyId:widget.myLectureEntity.contents[index].activity.decision!.id,
                        open:true,
                        header:parseHtmlString(widget.myLectureEntity.contents[index].activity.decision!.body),
                        body:"BODY",
                        solution:cs.Solution(solutionId: -1, answers: []),
                        attendanceTable:null
                    ),
                    attendanceTable: widget.myLectureEntity.contents[index].activity.decision!.attendanceTable,
                    courseId: widget.courseId,));

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
                                widget.myLectureEntity.contents[index].activity.title.toString(),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.DECISION_MAKING) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  goTo(context, (context) =>DecisionMakingPage(nestedContent:widget.myLectureEntity.contents[index]));
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
                                parseHtmlString(widget.myLectureEntity.contents[index].activity.caseStudy.caseHeader),
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
          else if (widget.myLectureEntity.contents[index].type == Constants.QUIZZ) {
            if( widget.myLectureEntity.contents[index].activity.quizz!.attendanceTable.isEmpty){
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
                            MyQuizizzEntity(id: widget.myLectureEntity.contents[index].activity.quizz!.id,///QuizzId
                                materialId: widget.myLectureEntity.contents[index].id,///ContentId
                                courseId: -1,
                                name: widget.myLectureEntity.contents[index].activity.quizz!.name,
                                beforeStart: false,
                                optional: false, timeLimit: 0, shuffle: false, repetition: 0, myAttempts: 0, ifPassed: 0, ifFailed: 0, minScore: 0, attendance: null,
                                questions: widget.myLectureEntity.contents[index].activity.quizz!.questions
                            ))
                    );
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
                                  widget.myLectureEntity.contents[index].activity.title.toString(),
                                  maxLines: 1,
                                  style: blackBoldTextStyle(context: context, fontSize: 11),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Text("${widget.myLectureEntity.contents[index].activity.quizz!.questions.length} سؤال",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
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
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: GestureDetector(
                  onTap: () async {
                    goTo(context, (context) => ExamResultPage(nestedContent: widget.myLectureEntity.contents[index],));
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
                                  widget.myLectureEntity.contents[index].activity.title.toString(),
                                  maxLines: 1,
                                  style:
                                  blackBoldTextStyle(context: context, fontSize: 11),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Text("${widget.myLectureEntity.contents[index].activity.quizz!.questions.length} سؤال",style: blackBoldTextStyle(fontSize: 11, context: context,color: iconsColor),),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.MATCH_BETWEEN) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  // DragAndDropPage
                  goTo(context, (context) =>MatchBetweenInnerTest(nestedContent:widget.myLectureEntity.contents[index]));
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
                                widget.myLectureEntity.contents[index].activity.title.toString(),
                                maxLines: 1,
                                style: blackBoldTextStyle(context: context, fontSize: 11),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.LOGICAL_ORDER) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  goTo(context, (context) =>LogicalOrderPage(nestedContent:widget.myLectureEntity.contents[index]));
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
                                widget.myLectureEntity.contents[index].activity.title.toString(),
                                maxLines: 1,
                                style:
                                blackBoldTextStyle(context: context, fontSize: 11),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.FILL_SPACE) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  goTo(context, (context) =>FillSpaceInner(nestedContent:widget.myLectureEntity.contents[index]));
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
                                widget.myLectureEntity.contents[index].activity.title.toString(),
                                maxLines: 1,
                                style: blackBoldTextStyle(context: context, fontSize: 11),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.LINK){
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  if (kDebugMode) {
                    print(parseHtmlString(widget.myLectureEntity.contents[index].body));
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
                        getLinkIcon(fileName:parseHtmlString(widget.myLectureEntity.contents[index].body)),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: size.width - 120,
                          child: Text(
                            parseHtmlString(widget.myLectureEntity.contents[index].body),
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

          else if (widget.myLectureEntity.contents[index].type == Constants.LIVE_STREAMING){
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: GestureDetector(
                onTap: () async {
                  Uri url =  Uri.parse(widget.myLectureEntity.contents[index].meetingLink);
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
                        getIcon(fileName:"live-line"),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: size.width - 120,
                          child: Text(
                            parseHtmlString(widget.myLectureEntity.contents[index].body),
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

          if (widget.myLectureEntity.contents[index].type != 1) {
            return Text(widget.myLectureEntity.contents[index].type.toString());
          }
          return Container();
        });
  }
}
