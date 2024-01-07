import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Theme/style.dart';
import '../../core/functions.dart';
import '../../core/globals.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../core/widgets/right_answer.dart';
import '../../features/my_courses_feature/data/models/my_lecture_model.dart';
import '../../features/my_courses_feature/domain/use_cases/activity_match_usecase.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import '../../features/profile_feature/presentation/bloc/bloc.dart';
import '../../injection_container.dart';

class MatchBetweenInnerTest extends StatefulWidget {
  const MatchBetweenInnerTest({Key? key, required this.nestedContent})
      : super(key: key);

  final NestedContent nestedContent;
  @override
  State<MatchBetweenInnerTest> createState() => _MatchBetweenInnerTestState();
}

class RelationClass {
  int id;
  int? pairId;
  Relation relation;
  Widget widget;
  Widget text;

  RelationClass({
    required this.id,
    required this.relation,
    this.pairId,
    required this.widget,
    required this.text,
  });
}

class _MatchBetweenInnerTestState extends State<MatchBetweenInnerTest> {
  List<RelationClass> sentences = [];
  List<RelationClass> relations = [];
  bool firstOne = true;
  List<Matched> matched = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (firstOne) {
      firstOne = false;
      sentences = [];
      for (int i = 0; widget.nestedContent.activity.matching!.sentences.length > i; i++) {
        sentences.add(RelationClass(
            id: widget.nestedContent.activity.matching!.sentences[i].id,
            relation: widget.nestedContent.activity.matching!.sentences[i],
            widget: Draggable(
                data: i,
                feedback: Material(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.1),
                    child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20000)),
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9000),
                            border: Border.all(color: Colors.grey, width: 1,),
                          ),
                          child: Text(
                            arabicAlphabet(i),
                            style: blackBoldTextStyle(context: context, fontSize: 15),
                          ),
                        ))),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(9000),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    arabicAlphabet(i),
                    style: blackBoldTextStyle(context: context, fontSize: 15),
                  ),
                )),
            text: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: size.width - 100,
                      child: Text(
                        parseHtmlString(widget.nestedContent.activity.matching!.sentences[i].sentence),
                        style: blackBoldTextStyle(context: context, fontSize: 13, height: lineSpace),
                      )),
                ],
              ),
            )));
      }
      relations = [];
      for (var item in widget.nestedContent.activity.matching!.relations) {
        relations.add(RelationClass(
          id: item.id,
          relation: item,
          text: Padding(
            padding: const EdgeInsets.only(top: 19, bottom: 9),
            child: Row(
              children: [
                Container(
                  width: size.width - 90,
                  child: Text(
                    parseHtmlString(item.sentence),
                    style: blackBoldTextStyle(
                        context: context, fontSize: 12, height: lineSpace),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          widget: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: activeColor,
              ),
              borderRadius: BorderRadius.circular(9000),
            ),
          ),
        ));
      }
    }

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          print(state);
          if (state is SuccessActivityMatchingState) {
            widget.nestedContent.activity.matching!.attendanceTable.add(
                MatchingAttendanceTable(
                    id: state.activityMatchEntity.id,
                    userId: state.activityMatchEntity.userId,
                    questionId: state.activityMatchEntity.questionId,
                    email: state.activityMatchEntity.email,
                    isCorrect: state.activityMatchEntity.isCorrect,
                    date: state.activityMatchEntity.date,
                    matched: state.activityMatchEntity.matched));
          }

          ///User was answer, and need to show result
          if (widget.nestedContent.activity.matching!.attendanceTable.isNotEmpty) {
            List<Widget> widgetList = [];
            for (var item in widget
                .nestedContent.activity.matching!.attendanceTable[0].matched) {
              widgetList.add(Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 19),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 12, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///first sentence(TITLE)
                        Text(
                          parseHtmlString(item.first),
                          style: blackBoldTextStyle(
                              fontSize: 14, context: context),
                        ),

                        ///*The answer given by the user is wrong
                        /// if first sentence != second sentence
                        (parseHtmlString(item.second) !=
                                parseHtmlString(item.shouldBe))
                            ?

                            ///show the wrong and correct answer
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///User select this answer, But this answer is not correct
                                  Padding(
                                    padding: const EdgeInsets.only(top: 19),
                                    child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 17,
                                              bottom: 17,
                                              left: 12,
                                              right: 12),
                                          child: Text(
                                            parseHtmlString(item.second),
                                            style: blackBoldTextStyle(
                                                fontSize: 12,
                                                context: context,
                                                color: Colors.red),
                                          ),
                                        )),
                                  ),

                                  ///Let user know the correct answer
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: percentIndicatorColor,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 17,
                                              bottom: 17,
                                              left: 12,
                                              right: 12),
                                          child: Text(
                                            parseHtmlString(item.shouldBe),
                                            style: blackBoldTextStyle(
                                                fontSize: 12,
                                                context: context,
                                                color: percentIndicatorColor),
                                          ),
                                        )),
                                  ),
                                ],
                              )
                            :

                            ///*The answer given by the user is right
                            /// if first answer == second answer show the second selected sentence
                            Padding(
                                padding: const EdgeInsets.only(top: 17),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: percentIndicatorColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 17,
                                        bottom: 17,
                                        left: 12,
                                        right: 12),
                                    child: Text(
                                      parseHtmlString(item.second),
                                      style: blackBoldTextStyle(
                                          fontSize: 12,
                                          context: context,
                                          color: percentIndicatorColor),
                                    ),
                                  ),
                                ),
                              ),

                        const RightAnswer(),
                      ],
                    ),
                  ),
                ),
              ));
            }

            return Scaffold(
              appBar: appBarWidget("", context, true, null, null),
              body: Padding(
                padding: const EdgeInsets.only(top: 10, right: 17, left: 17,bottom: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/svgs/comment  icon.svg",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      (widget.nestedContent.body.isNotEmpty)
                                          ? parseHtmlString(widget.nestedContent.body)
                                          : "صِل العبارات التالية",
                                      style: blackBoldTextStyle(
                                          fontSize: 14, context: context),
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                children: widgetList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          
          ///User not answer yet.
          return Scaffold(
            appBar: appBarWidget("", context, true, null, null),
            body: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Row(
                      children: [
                        Container(
                            width: size.width - 76,
                            child: Text(
                              parseHtmlString(widget.nestedContent.activity.title),
                              style: blackBoldTextStyle(
                                  context: context, fontSize: 14,height: lineSpace),
                            )),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Container(
                      height: size.height * 0.35,
                      child: ListView.builder(
                          itemCount: sentences.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Draggable(
                                      data: index,
                                      feedback: Material(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .withOpacity(0.1),
                                          child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20000)),
                                              child: sentences[index].widget)),
                                      child: sentences[index].widget),
                                  sentences[index].text,
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Theme.of(context).cardColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17, right: 17),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: size.height * 0.35,
                              child: ListView.builder(
                                  itemCount: relations.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          relations[index].text,
                                          DragTarget(
                                              builder: (BuildContext context,
                                                  List<Object?> candidateData,
                                                  List<dynamic> rejectedData) {
                                                return relations[index].widget;
                                              },
                                              onWillAccept: (data) => true,
                                              onAccept: (data) {
                                                int? i = data as int?;
                                                print("kjfnjndjnvfd");
                                                print(relations[i!].id);

                                                for (int j = 0;
                                                    matched.length > j;
                                                    j++) {
                                                  if (matched[j].pairId ==
                                                      sentences[i].id) {
                                                    matched.removeAt(j);
                                                  }
                                                }


                                                for (var item in relations) {
                                                  if (item.pairId ==
                                                      sentences[i].id) {
                                                    item.widget = Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      90000),
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 1,
                                                          )),
                                                    );
                                                  }
                                                }

                                                matched.add(Matched(
                                                    pairId: sentences[i].id,
                                                    questionId: widget
                                                        .nestedContent
                                                        .activity
                                                        .matching!
                                                        .id,
                                                    selectedId:
                                                        relations[index].id));

                                                relations[index].widget = Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      90000),
                                                          border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 1,
                                                          )),
                                                    ),
                                                    sentences[i].widget,
                                                  ],
                                                );
                                                relations[index].pairId =
                                                    sentences[i].id;

                                                setState(() {});
                                              }),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          if (widget.nestedContent.activity.matching!
                              .attendanceTable.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              child: CustomButton(
                                title: "ارسل الحل",
                                onTap: () {
                                  print("fjvnfjknvkjdfnvd");
                                  print(matched.length);
                                  // print( widget.nestedContent.activity.matching!.id);
                                  BlocProvider.of<MyCoursesBloc>(context).add(
                                      ActivityMatchingEvent(
                                          params: ActivityMatchParams(
                                              userId: userId(),
                                              questionId: widget.nestedContent
                                                  .activity.matching!.id,
                                              date: DateTime.now(),
                                              matched: matched)));
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
