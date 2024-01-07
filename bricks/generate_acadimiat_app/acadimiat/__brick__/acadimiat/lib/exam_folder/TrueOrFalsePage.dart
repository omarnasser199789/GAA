import 'package:acadmiat/exam_folder/widgets/question_number.dart';
import 'package:flutter/material.dart';
import '../Theme/style.dart';
import '../core/classes/question.dart';
import '../core/functions.dart';
import '../core/globals.dart';
import 'exam_page.dart';
import '../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';

  class TrueOrFalsePage extends StatefulWidget {
  const TrueOrFalsePage({Key? key,required this.question,required this.questionNumber}) : super(key: key);

  final Question question;
  final int questionNumber;
  @override
  State<TrueOrFalsePage> createState() => _TrueOrFalsePageState();
}

class _TrueOrFalsePageState extends State<TrueOrFalsePage> {
  var val ;
  List<Widget> answerList=[];

  void addToAttendanceTableList(Answer item) {
    for(int i=0;attendanceTable.length>i;i++){
      if(attendanceTable[i].questionId==item.questionId){
        attendanceTable.removeAt(i);
      }
    }

    attendanceTable.add(AttendanceTable(
        questionId: item.questionId,
        givenAnswers: [GivenAnswer(questionId: item.questionId, answerId: item.answerId)],
        givenWords: [], pairs: []));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    answerList=[];
    answerList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionNumber(text: widget.questionNumber.toString(),),
        const SizedBox(width: 9,),
        SizedBox(
            width: size.width-76,
            child: Text(
              parseHtmlString( widget.question.question),style: blackBoldTextStyle(context: context,fontSize: 14,height:lineSpace),)),
      ],
    ));
      for (var item in widget.question.answer) {
        answerList.add(
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                addToAttendanceTableList(item);
                setState(() {
                  val = item.id;
                });
              },
              child: Container(
                decoration: selectDecoration,
                child: Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(unselectedWidgetColor: iconsColor),
                      child: Radio(
                        value: item.id,
                        groupValue: val,
                        onChanged: (value) {
                          addToAttendanceTableList(item);
                          setState(() {
                            val = value;
                          });
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width-100,
                        child: Text(parseHtmlString(item.answer),
                          style: blackBoldTextStyle(context: context, fontSize: 13,height:lineSpace),),
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
      padding: const EdgeInsets.only(top: 20,left: 17,right: 17),
      child: SingleChildScrollView(
        child: Column(children: answerList),
      ),
    );
  }
}
