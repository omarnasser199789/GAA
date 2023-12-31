import 'package:acadmiat/exam_folder/exam_page.dart';
import 'package:acadmiat/exam_folder/widgets/options_widget.dart';
import 'package:acadmiat/exam_folder/widgets/question_number.dart';
import 'package:flutter/material.dart';
import '../Theme/style.dart';
import '../core/classes/question.dart';
import '../core/functions.dart';
import '../core/globals.dart';
// import '../features/my_courses_feature/data/models/myqizz_model.dart'as q;
import '../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({Key? key,required this.question,required this.questionNumber}) : super(key: key);
  final Question question;
  final int questionNumber;
  @override
  State<DragAndDropPage> createState() => _DragAndDropPageState();
}
class MyClass {
  MyClass({required this.text,required this.widget,required this.questionId,required this.answerId});
  Widget text;
  Widget widget;
  int questionId;
  int answerId;
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  List<MyClass> pairsList=[];
  List<MyClass> pairsSelection=[];
  List<Pair> pairs=[];



 bool firstOne=true;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if(firstOne) {
      firstOne=false;
      pairsList = [];
      for (var item in widget.question.pairs) {
        pairsList.add(
            MyClass(
              questionId:item.questionId ,
                answerId: item.id,
                widget: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9000),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),

                  ),
                  child: Text(item.id.toString(),
                    style: blackBoldTextStyle(context: context, fontSize: 15),
                  ),
                ),
                text: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: OptionsWidget(body: parseHtmlString(item.sentence),),
                ))

        );
      }

      pairsSelection = [];
      for (var item in widget.question.pairsSelection) {
        pairsSelection.add(

            MyClass(
              questionId:item.questionId ,
              answerId: item.id,
              text:
            Padding(
              padding: const EdgeInsets.only(top: 19, bottom: 9),
              child: Row(
                children: [

                  Container(
                    width: size.width-100,
                    // color: Colors.green,
                    child: Text(parseHtmlString(item.sentence),
                      style: blackBoldTextStyle(context: context, fontSize: 12,height: lineSpace),),
                  ),

                  SizedBox(
                    width: 10,
                  ),


                ],
              ),
            ),
              widget: Container(width: 42, height: 42,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: activeColor,
                  ),
                  borderRadius: BorderRadius.circular(9000),
                ),),

            )
        );
      }
    }


    return Column(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17,right: 17,top: 10),
          child: Row(
            children: [
              QuestionNumber(text: widget.questionNumber.toString(),),
              const SizedBox(width: 9,),
              SizedBox(
                  width: size.width-76,
                  child: Text(parseHtmlString(widget.question.question),style: blackBoldTextStyle(context: context,fontSize: 14),)),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(left: 17,right: 17,top: 10),
          child: SizedBox(
            height: size.height * 0.6 - 203 ,
            child: ListView.builder(
                itemCount: pairsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Draggable(
                            data: index,
                            feedback: Material(
                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20000)
                                    ),
                                    child: pairsList[index].widget)),
                            child: pairsList[index].widget
                        ),

                        pairsList[index].text,
                      ],
                    ),
                  );
                }),
          ),
        ),



        Padding(
          padding: const EdgeInsets.only(top:10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                color: Theme.of(context).cardColor
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 17,right: 17,top: 10,bottom: 65),
              child: SizedBox(
                height: size.height * 0.4 -65,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                    itemCount: pairsSelection.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            pairsSelection[index].text,

                            DragTarget(
                                builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {

                                  return pairsSelection[index].widget;

                                },
                                onWillAccept:(data) => true,
                                onAccept:(data){
                                  int? i=data as int?;
                                  // print(pairsList[i!].id);
                                  pairsSelection[index].widget=
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(90000),
                                                border: Border.all(
                                                  color: Theme.of(context).primaryColor,
                                                  width: 1,

                                                )
                                            ),
                                          ),
                                          pairsList[i!].widget,

                                        ],
                                      );


                                  // for(int j=0;givenAnswers.length>j;j++){
                                  //   if(givenAnswers[j].questionId==pairsList[i].questionId){
                                  //     givenAnswers.removeAt(j);
                                  //   }
                                  // }
                                  //
                                  // givenAnswers.add(GivenAnswer(
                                  //     questionId: pairsList[i].questionId,
                                  //     answerId: pairsList[i].answerId));
                                  // setState(() {
                                  //
                                  // });


                                  print("fknjkvndfkvndfkjvnfnvkdfn");
                                  print(i);




                                  for(int j=0;pairs.length>j;j++){
                                    if(pairs[j].selectedId==pairsSelection[index].answerId){
                                      pairs.removeAt(j);
                                    }
                                  }


                                  pairs.add(Pair(questionId: pairsList[i].questionId, pairId: widget.question.pairs[i].id, selectedId: pairsSelection[index].answerId));

                                  print(pairs.length);

                                  // pairs=[];


                                  for(int i=0;attendanceTable.length>i;i++){
                                    if(attendanceTable[i].questionId==widget.question.id){
                                      attendanceTable.removeAt(i);
                                    }
                                  }

                                  attendanceTable.add(AttendanceTable(
                                      questionId: widget.question.id,
                                      givenAnswers: [],
                                      givenWords: [],
                                      pairs:pairs
                                  ));

                                  // print("fdnvkfnvkndfvjkdfn");
                                  // print(attendanceTable.length);




                                }
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        )








      ],
    );
  }
}

