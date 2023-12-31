import 'package:acadmiat/exam_folder/widgets/question_number.dart';

import '../Theme/style.dart';
import 'package:acadmiat/exam_folder/exam_page.dart';
import 'package:flutter/material.dart';
import '../core/classes/question.dart';
import '../core/functions.dart';
import '../core/globals.dart';

import 'package:flutter/foundation.dart';
import '../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';

class MultipleChoicePage extends StatefulWidget {
  const MultipleChoicePage(
      {Key? key, required this.question, required this.questionNumber})
      : super(key: key);
  final Question question;
  final int questionNumber;

  @override
  State<MultipleChoicePage> createState() => _MultipleChoicePageState();
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  bool firstTime = true;
  var val;
  List<Widget> answerList = [];
  List<bool> selectedAnswerList = [];
  List<GivenAnswer> givenAnswers=[];

  @override
  Widget build(BuildContext context) {
    answerList = [];
    Size size = MediaQuery.of(context).size;
    answerList.add( Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuestionNumber(
          text: widget.questionNumber.toString(),
        ),
        const SizedBox(
          width: 9,
        ),
        SizedBox(
            width: size.width - 76,
            child: Text(
              parseHtmlString(widget.question.question),

              style:
              blackBoldTextStyle(context: context, fontSize: 14),
            )),
      ],
    ),);
    answerList.add( Padding(
      padding: const EdgeInsets.only(top: 15,right: 40,left: 40),
      child: Row(
        children: [
          SizedBox(
            // width: size.width * 0.79,
              child: Text(
                "يمكن اختيار اكثر من خيار",
                style: blackRegularTextStyle(
                    fontSize: 14),
              )),
        ],
      ),
    ),);


      for (int i = 0; widget.question.answer.length > i; i++) {
        selectedAnswerList.add(false);
        answerList.add(
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedAnswerList[i] = !selectedAnswerList[i];
                });

                print(selectedAnswerList[i]);

                if (selectedAnswerList[i] == true) {
                  givenAnswers.add(GivenAnswer(
                      questionId:
                      widget.question.answer[i].questionId,
                      answerId: widget.question.answer[i].answerId));
                } else {
                  for (int j = 0; givenAnswers.length > j; j++) {
                    if (givenAnswers[j].answerId ==
                        widget.question.answer[i].answerId) {
                      givenAnswers.removeAt(j);
                    }
                  }
                }

                for (int g = 0; attendanceTable.length > g; g++) {
                  if (attendanceTable[g].questionId == widget.question.id) {
                    attendanceTable.removeAt(g);
                  }
                }


                attendanceTable.add(AttendanceTable(
                    questionId: widget.question.id,
                    givenAnswers: givenAnswers,
                    givenWords: [],
                    pairs: []));

              },
              child: Container(
                decoration: selectDecoration,
                child: Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: iconsColor,
                      ),
                      child: Checkbox(
                        value: selectedAnswerList[i],
                        autofocus: true,
                        activeColor: Theme
                            .of(context)
                            .primaryColor,
                        checkColor: Colors.white,

                        onChanged: (value) {
                          if (value == true) {
                            givenAnswers.add(GivenAnswer(
                                questionId:
                                widget.question.answer[i].questionId,
                                answerId: widget.question.answer[i].answerId));
                          } else {
                            for (int j = 0; givenAnswers.length > j; j++) {
                              if (givenAnswers[j].answerId ==
                                  widget.question.answer[i].answerId) {
                                givenAnswers.removeAt(j);
                              }
                            }
                          }

                          for (int g = 0; attendanceTable.length > g; g++) {
                            if (attendanceTable[g].questionId ==
                                widget.question.id) {
                              attendanceTable.removeAt(g);
                            }
                          }


                          attendanceTable.add(AttendanceTable(
                              questionId: widget.question.id,
                              givenAnswers: givenAnswers,
                              givenWords: [],
                              pairs: []));


                          setState(() {
                            selectedAnswerList[i] = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: size.width-95,
                      // color: Colors.red,
                      child: Text(
                        parseHtmlString(widget.question.answer[i].answer),
                        style: blackBoldTextStyle(context: context, fontSize: 13,height: lineSpace),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }


    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: size.height * 0.75,

        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: answerList,

          ),
        ),
      ),
    );
  }
}
