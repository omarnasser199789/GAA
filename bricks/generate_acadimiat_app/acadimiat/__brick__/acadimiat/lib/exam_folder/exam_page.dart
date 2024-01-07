import 'dart:async';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/exam_folder/widgets/exam_page_header.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../Theme/style.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/classes/constants.dart';
import '../core/functions.dart';
import '../features/my_courses_feature/domain/use_cases/activity_quizz_usecase.dart';
import '../features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/pages/lecture_page.dart';
import '../injection_container.dart';
import '../launch_page.dart';
import '../splash_screen.dart';
import 'TrueOrFalsePage.dart';
import 'anser_page.dart';
import '../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import 'blanks_page.dart';
import 'drag_and_drop_page.dart';
import 'multiple_choice_page.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/bloc.dart';

List<AttendanceTable> attendanceTable = [];

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key, this.myQuizizzEntity,required this.cameFrom}) : super(key: key);

  final MyQuizizzEntity? myQuizizzEntity;
  final dynamic cameFrom; // 0 => came from lecture page or if 1 => came from

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  PageController controller = PageController();
  List<Widget> _list = <Widget>[];

  int _curr = 0;

  @override
  void initState() {
    super.initState();
    attendanceTable = [];
    int i = 0;
    for (var item in widget.myQuizizzEntity!.questions) {
      i++;
      if (item.questionType == QuestionType.selectOne) {
        // select one
        _list.add(TrueOrFalsePage(
          question: item,
          questionNumber: i,
        ));
      }
      if (item.questionType == QuestionType.multipleChoice) {
        //multi options
        _list.add(MultipleChoicePage(
          question: item,
          questionNumber: i,
        ));
      }
      if (item.questionType == QuestionType.blanks) {
        //BlanksPage
        _list.add(BlanksPage(
          question: item,
          questionNumber: i,
        ));
      }
      if (item.questionType == QuestionType.trueOrFalse) {
        //true or false
        _list.add(TrueOrFalsePage(
          question: item,
          questionNumber: i,
        )); //
      }

      if (item.questionType == QuestionType.dragAndDrop) {
        //multi options
        _list.add(DragAndDropPage(
          question: item,
          questionNumber: i,
        ));
      }

    }

  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  bool goToAnswerPage = true;
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if (state is SuccessSubmitQuizState || state is SuccessActivityQuizzState) {
            if (goToAnswerPage) goToAnswerPage = false;
            WidgetsBinding.instance.addPostFrameCallback((_) => goTo(
                context,
                (context) => AnswerPage(
                      myQuizizzEntity: widget.myQuizizzEntity!,
                    )));
          }
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floatingActionButton:
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                      Widget>[
                CustomButton(
                    title: "إنهاء الاختبار",
                    color: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).primaryColor,
                    width: 105,
                    onTap: () {
                      showCustomDialog(context, widget.myQuizizzEntity!);
                    }),
                const SizedBox(
                  width: 50,
                ),
                Material(
                  color: Theme.of(context).cardColor,
                  child: CustomButton(
                      title: (_curr < _list.length - 1)
                          ? "التالي"
                          : "إرسال الاختبار",
                      icon: (_curr < _list.length - 1)
                          ? const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          : null,
                      width: 130,
                      onTap: () async {
                        _curr++;
                        if (_curr < _list.length) {
                          controller.animateToPage(
                            _curr,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          await initConnection();





                          ///This Quizz came from lecture page
                          ///I make (widget.myQuizizzEntity!.name) like indicator to let me know if this quizz from
                          ///Lecture page or Exam page
                          if(widget.cameFrom==LecturePage) {
                            BlocProvider.of<MyCoursesBloc>(context)
                                .add(
                                ActivityQuizzEvent(params: ActivityQuizzParams(
                                  connectionId: connection.connectionId!,
                                  quizzParams: QuizzParams(
                                    userId: userId().toString(),
                                    contentId: widget.myQuizizzEntity!
                                        .materialId,

                                    ///ContentId
                                    quizzId: widget.myQuizizzEntity!.id,

                                    ///quizzId
                                    attendedAt: DateTime.now(),
                                    finished: true,
                                    attendanceTable: attendanceTable,),

                                ),

                                ));
                          }else{
                            ///This quizz came from Exam page
                            BlocProvider.of<MyCoursesBloc>(context)
                                .add(SubmitQuizEvent(
                                    submitQuizParams: SubmitQuizParams(
                                        connectionId: connection.connectionId!,
                                        submitQuiz: SubmitQuiz(
                                          userId: userId(),
                                          attendedAt: DateTime.now(),
                                          finished: true,
                                          quizzId: widget.myQuizizzEntity!.id,
                                          attendanceTable: attendanceTable,
                                        ))));
                          }


                        }
                        setState(() {});
                      }),
                ),
              ]),



              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 133),
                    child: PageView(
                      children: _list,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      onPageChanged: (num) {
                        setState(() {
                          _curr = num;
                        });
                      },
                    ),
                  ),


                  ExamPageHeader(
                    myQuizizzEntity: widget.myQuizizzEntity!,
                    percent: ((_curr + 1) / (_list.length) > 1) ? 1 : (_curr + 1) / (_list.length),
                    percentText:  "${_curr + 1}/${_list.length}",
                    quizzName: widget.myQuizizzEntity!.name,
                  ),

                ],
              ),
            ),
          );
        }));
  }
}








void showCustomDialog(BuildContext context, MyQuizizzEntity myQuizizzEntity) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (contextt, __, ___) {
      return Center(
        child: Container(
          height: 220,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(right: 27, left: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 9.7),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/feather-alert-triangle.svg",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "هل أنت متأكد من إنهاء الاختبار؟",
                            style: blackBoldTextStyle(
                                context: context, fontSize: 14),
                          ),
                        ],
                      ), //
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28, bottom: 17),
                      child: Text(
                        "عدد الأسئلة المجاب عليها",
                        style: blackBoldTextStyle(
                          context: context,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "${attendanceTable.length}/${myQuizizzEntity.questions.length}",
                      style: blackBoldTextStyle(context: context, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(contextt);
                              },
                              child: Container(
                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.01),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "تراجع عن الانهاء",
                                    style: blackBoldTextStyle(
                                        context: context,
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            width: 52,
                          ),

                          GestureDetector(
                              onTap: () {
                                Navigator.pop(contextt, 200);
                              },
                              child: Container(
                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.01),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "إنهاء الاختبار",
                                    style: blackBoldTextStyle(
                                        context: context,
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  ).then((value) {

    if (value == 200) {
      Navigator.pop(context);
    }
  });
}


