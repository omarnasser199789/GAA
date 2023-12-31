
import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Theme/style.dart';
import 'package:flutter/material.dart';
import '../core/functions.dart';
import '../core/widgets/app_bar_widget.dart';
import '../core/widgets/right_answer.dart';
import '../features/my_courses_feature/data/models/my_lecture_model.dart';
import '../features/my_courses_feature/domain/use_cases/activity_case_usecase.dart';
import '../features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../features/my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import '../features/profile_feature/presentation/bloc/bloc.dart';
import '../injection_container.dart';

class DecisionMakingPage extends StatefulWidget {
  const DecisionMakingPage({super.key,required this.nestedContent});
  final NestedContent nestedContent;

  @override
  State<DecisionMakingPage> createState() => _DecisionMakingPageState();
}

class _DecisionMakingPageState extends State<DecisionMakingPage> {
  var val ;
  List<Widget> widgetList=[];
  bool firstOne=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widgetList=[];
    widgetList.add(Padding(
      padding: const EdgeInsets.only(bottom: 20,top: 20),
      child: Container(
          width:double.infinity,
          // alignment: Alignment.center,

          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10)
          ),

          child: Padding(
            padding: const EdgeInsets.only(top:18,bottom: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 11,right: 11),
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
                        //
                        child: SvgPicture.asset(
                          "assets/svgs/question.svg",
                        ),
                      ),
                      const SizedBox(width: 11,),
                      Text("اتخاذ قرار",style: blackBoldTextStyle(fontSize: 14, context: context),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:18,bottom: 18),
                  child: Container(
                    width: double.infinity,
                    height: 0.3,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11,right: 11),
                  child: Text(
                    parseHtmlString(widget.nestedContent.activity.caseStudy.caseBody),style: blackBoldTextStyle(context: context,fontSize: 12,height: lineSpace),),
                ),
              ],
            ),
          )),
    ),);

    ///user dose not answer yet
    if(widget.nestedContent.activity.caseStudy.attendanceTable.isEmpty) {
      List<Widget> answersList=[];
      for (var item in widget.nestedContent.activity.caseStudy.solution
          .answers) {
        answersList.add(
          Padding(
            padding: const EdgeInsets.only(
                top: 10
            ),
            child: GestureDetector(
              onTap: () {
                // addToAttendanceTableList(item);
                setState(() {
                  val = item.id;
                });
              },
              child: Container(
                decoration: selectDecoration,
                child: Row(
                  children: [

                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: iconsColor,
                      ),
                      child: Radio(

                        value: item.id,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                          });
                        },
                        activeColor: Theme
                            .of(context)
                            .primaryColor,
                      ),
                    ),

                    SizedBox(
                      width: size.width-120,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(parseHtmlString(item.answer),
                          style: blackBoldTextStyle(
                              context: context, fontSize: 13),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
      widgetList.add(
          Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 18),
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
                      //
                      child: SvgPicture.asset(
                        "assets/svgs/comment  icon.svg",
                      ),
                    ),
                    const SizedBox(width: 11,),
                    Text("الخيارات",style: blackBoldTextStyle(fontSize: 14, context: context),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:18),
                child: Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Colors.grey,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,bottom: 18,top: 8),
                child: SingleChildScrollView(child: Column(children: answersList,)),
              ),
            ],
          )));
    }
    ///User was answered before
    else{
      List<Widget> answer=[];
      for (var item in widget.nestedContent.activity.caseStudy.solution.answers) {
        /// answer selected by user
        if(widget.nestedContent.activity.caseStudy.attendanceTable[0].answerId==item.id){
          if(widget.nestedContent.activity.caseStudy.attendanceTable[0].isCorrect){
            ///Answer selected by user is true
            answer.add(
              Padding(
                padding: const EdgeInsets.only(
                    top: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.01),
                        border: Border.all(width: 1,color:percentIndicatorColor ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                            child: SizedBox(
                              width: size.width-80,
                              child: Text(parseHtmlString(item.answer),
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 13,color: percentIndicatorColor),),
                            ),
                          )
                        ],
                      ),
                    ),
                    const RightAnswer(),
                  ],
                ),
              ),
            );
          }else {
            ///Answer selected by user is false
            answer.add(
              Padding(
                padding: const EdgeInsets.only(
                    top: 10
                ),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.01),
                        border: Border.all(
                            width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 10, right: 10),
                            child: Container(
                              width: size.width-80,
                              child: Text(parseHtmlString(item.answer),
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 13,color: Colors.red,height: lineSpace),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:7),
                      child: Text("الإجابة خاطئة ",style: blackBoldTextStyle(fontSize: 12, context: context,color: Colors.red),),
                    )
                  ],
                ),
              ),
            );
          }
        }else{
          ///Other answer include the right answer
          ///right answer if user select the wrong one, let user know the right answer
          if(widget.nestedContent.activity.caseStudy.attendanceTable[0].correctAnswerId==item.id){
            answer.add(
              Padding(
                padding: const EdgeInsets.only(
                    top: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.01),
                        border: Border.all(width: 1,color:percentIndicatorColor ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                            child: Container(
                              width: size.width-80,
                              // color: Colors.red,
                              child: Text(parseHtmlString(item.answer),
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 13,color: percentIndicatorColor,height: lineSpace),),
                            ),
                          )
                        ],
                      ),
                    ),
                    const RightAnswer()

                  ],
                ),
              ),
            );
          }
          else{
            ///Other answer (normal) user not select
            answer.add(
              Padding(
                padding: const EdgeInsets.only(
                    top: 10
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.01),
                    border: Border.all(width: 1,color:Colors.grey.withOpacity(0.5) ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                        child: SizedBox(
                          width: size.width-80,
                          child: Text(parseHtmlString(item.answer),
                            style: blackBoldTextStyle(
                                context: context, fontSize: 13,height: lineSpace),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

        }

      }
      widgetList.add(Container(
         decoration: BoxDecoration(
           color: Theme.of(context).cardColor,
           borderRadius: BorderRadius.circular(10)
         ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 18),
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
                      //
                      child: SvgPicture.asset(
                        "assets/svgs/comment  icon.svg",
                      ),
                    ),
                    SizedBox(width: 11,),
                    Text("الخيارات",style: blackBoldTextStyle(fontSize: 14, context: context),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:18),
                child: Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 18),
                child: Column(children: answer,),
              ),
            ],
          )));

    }

    widgetList.add(Container(height: 100,));
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {
          print(state);
          if(state is SuccessActivityCaseState){

            if(firstOne) {
              firstOne=false;
              showMessage(message: "تم ارسال الحل",
                  context: context,
                  bgColor: percentIndicatorColor);


              widget.nestedContent.activity.caseStudy.attendanceTable=[
                AttendanceTable2(id: state.activityCaseEntity.id,
                  userId: state.activityCaseEntity.userId,
                    answerId: state.activityCaseEntity.answerId,
                    caseId: state.activityCaseEntity.caseId,
                    correctAnswerId: state.activityCaseEntity.correctAnswerId,
                    email: state.activityCaseEntity.email,
                    solution: state.activityCaseEntity.solution,
                    correctAnswer: state.activityCaseEntity.correctAnswer,
                    explanation: state.activityCaseEntity.explanation,
                    isCorrect: state.activityCaseEntity.isCorrect,
                    answer: state.activityCaseEntity.answer,
                    reply: state.activityCaseEntity.reply, explanation2: state.activityCaseEntity.explanation2,
                    date: state.activityCaseEntity.date)];


              Future.delayed(Duration(milliseconds: 1000), () {
                setState(() {


                });
              });
            }
          }



            return Scaffold(
              appBar: appBarWidget("", context, true, null, null),
              body: Padding(
                padding: const EdgeInsets.only(left: 17,right: 17),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widgetList
                      ),
                    ),

                    if(widget.nestedContent.activity.caseStudy.attendanceTable.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SafeArea(child: CustomButton(title: "ارسل الجواب",onTap: (){
                          print(val);
                          firstOne=true;
                          BlocProvider.of<MyCoursesBloc>(context).add(ActivityCaseEvent(params:

                          ActivityCaseParams(
                              answerId: val,
                              caseId: widget.nestedContent.activity.caseStudy.id,
                              date: DateTime.now(),
                              email: '',
                              userId: userId())));

                        },)),
                      ),


                  ],
                ),
              ),
            );

        }));


  }
}
