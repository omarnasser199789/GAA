import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/my_courses_feature/data/models/my_course_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../core/globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../../../injection_container.dart';
import '../../../../../../data/models/my_lecture_model.dart' as MyLecture;
import '../../../../../../domain/entities/activity_decision_entity.dart';
import '../../../../../../domain/entities/course_case_study_entity.dart';
import '../../../../../../domain/use_cases/case_study/activity_decision_usecase.dart';
import '../../../../../../domain/use_cases/case_study/attendcase_usecase.dart';
import '../../../../../../domain/use_cases/case_study/course_case_study_usecase.dart';
import '../../../../../bloc/my_courses_bloc.dart';
import '../../../../../bloc/my_courses_event.dart';
import '../../../../../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class CaseStudyPage extends StatefulWidget {
  const CaseStudyPage({Key? key,required this.caseStudy,required this.courseId,this.fromLectureContents,this.attendanceTable}) : super(key: key);
  final CaseStudy caseStudy;
  final int courseId;
  /// Just for the internal usecase
  final bool ? fromLectureContents;
  /// Just for the internal usecase
  final List<MyLecture.AttendanceTable> ? attendanceTable;
  @override
  State<CaseStudyPage> createState() => _CaseStudyPageState();
}

class _CaseStudyPageState extends State<CaseStudyPage> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();


bool msgShow=false;
  var val ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");
    List<Widget> answersList=[];

    /// case study form lecture contents
    if(widget.fromLectureContents == true){
      List<Widget> widgetList=[];
      return BlocProvider(
          create: (BuildContext context) => sl<MyCoursesBloc>(),
          child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
              builder: (context, state) {
                if (kDebugMode) {
                  print("State:$state");
                }

                widgetList=[];
                if(state is Error){
                  return Scaffold(
                    appBar:appBarWidget("",context,true,null,null),
                    body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                      text1:"عذرا! حدثت مشكلة غير متوقعة",
                      text3: "حدث الان",
                      onTap: () async {
                        BlocProvider.of<MyCoursesBloc>(context).add(CourseCaseStudyEvent(params:
                        CourseCaseStudyParams(
                            userId: userId(),
                            courseId: widget.courseId,
                            forumId: widget.caseStudy.casestudyId
                        )));
                      },
                    ),
                  );
                }
                /// Add the question for the case study <<Header>>
                widgetList.add(
                    CaseStudyQuestion(
                      header: widget.caseStudy.header,
                      body: widget.caseStudy.body,
                    )
                );

                for(var item in widget.attendanceTable!){
                  widgetList.add(ItemOpenCaseStudy(answer:item.opinion!,));
                }
                if(state is SuccessActivityDecisionEntityState){

                  ActivityDecisionEntity activityDecisionEntity=state.activityDecisionEntity;
                  widgetList.add(ItemOpenCaseStudy(answer:activityDecisionEntity.opinion,));
                }




                return Scaffold(
                  appBar:appBarWidget("",context,true,null,null),
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17,right: 17,bottom: 60),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widgetList,),
                        ),
                      ),
                    ),
                    ///If case study is open, we must show a field so that the user can type.
                    if(
                    state is! SuccessActivityDecisionEntityState/// تم الاجابة على الحالة الدراسية فيجب اخفاء حقل الجواب
                    &&(widget.attendanceTable!.isEmpty)/// اذا لم يكن هنالك اي جواء
                    )
                    SendAnswerWidget( flutterMentionsKey: key,onTap: () {
                      msgShow=true;
                      if(key.currentState!.controller!.markupText!=""){


                        BlocProvider.of<MyCoursesBloc>(context).add(
                            ActivityDecisionEvent(params:
                            ActivityDecisionParams(
                              decisionId:  widget.caseStudy.casestudyId,
                              opinion: key.currentState!.controller!.markupText,
                              email: "nour@smartstep.com.tr",
                              userId: userId().toString(),
                              attendanceAt: DateTime.now(),
                              repliedAt:  DateTime.now(),)
                            ));


                      }else{
                        showMessage(message: "الرجاء اضافة تعليق", context: context);
                        setState(() {
                        });
                      }
                    },),

                  ],
                )

                  ,);





              }));
    }






    ///  Global case study on the all course
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if(state is Empty  ){//&& widget.caseStudy.casestudyId!=-1
            BlocProvider.of<MyCoursesBloc>(context).add(CourseCaseStudyEvent(params:
            CourseCaseStudyParams(
                userId: userId(),
                courseId: widget.courseId,
                forumId: widget.caseStudy.casestudyId
            )));

          }
          if(state is SuccessAttendCaseState){
            BlocProvider.of<MyCoursesBloc>(context).add(CourseCaseStudyEvent(params:
            CourseCaseStudyParams(
                userId: userId(),
                courseId: widget.courseId,
                forumId: widget.caseStudy.casestudyId
            )));

          }
          if(state is Error){
            return Scaffold(
              appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {
                  BlocProvider.of<MyCoursesBloc>(context).add(CourseCaseStudyEvent(params:
                  CourseCaseStudyParams(
                      userId: userId(),
                      courseId: widget.courseId,
                      forumId: widget.caseStudy.casestudyId
                  )));
                },
              ),
            );
          }




          if(state is SuccessCourseCaseStudyState){
            ///The question has not been answered yet
            if(state.courseCaseStudyEntity.attendanceTable!=null){
              ///If the answer answered by the user exists
              if(state.courseCaseStudyEntity.attendanceTable!.answer!=null) {
                ///Choose the answer to display to the user
                val=state.courseCaseStudyEntity.attendanceTable!.answer!.answerId;
              }
            }
            
            ///This list contains answers from which the user can choose
            answersList=[];
            ///Add the available option to the closed case study
            ///Answers that the user can choose from
            for(var item in widget.caseStudy.solution.answers){
              answersList.add(
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          val = item.answerId;
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

                                value: item.answerId,
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

                            Container(
                              width: size.width-108,
                              child: Text(parseHtmlString(item.answer),
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 13,height: lineSpace),),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              );
            }

            List<Widget> widgetList=[];

            /// Add the question for the case study <<Header>>
            widgetList.add(
                CaseStudyQuestion(
                  header: widget.caseStudy.header,
                  body: widget.caseStudy.body,
                )
            );

            ///Solution for close CaseStudy
            ///Closed case study is always a single choice
            if(widget.caseStudy.solution.answers.isNotEmpty && widget.caseStudy.open==false) {
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
                            padding: const EdgeInsets.only(left: 12,right: 12,bottom: 18,top: 8),
                            child: Column(children: answersList,),
                          ),
                        ],
                      )));

            }

            ///Solution for open CaseStudy
            if(widget.caseStudy.solution.answers.isNotEmpty && widget.caseStudy.open==true && state.courseCaseStudyEntity.attendanceTable!=null) {
              widgetList.add(ItemOpenCaseStudy(answer: state.courseCaseStudyEntity.attendanceTable!.answer!.answer,));

            }

            ///Open Case
            ///The answer was given by the student, but the solution has not been evaluated yet
            if(
            // ///The answers come only if the answer is given by the student and the solution is evaluated by the teacher
            // widget.caseStudy.solution.answers.isEmpty &&
            ///Is open case study
            widget.caseStudy.open==true &&
            ///The question has not been answered at all if  attendanceTable = null
            state.courseCaseStudyEntity.attendanceTable!=null
            ){
              ///Show a message to the user that the solution is waiting for evaluation.
              widgetList.add( ItemOpenCaseStudy(answer: state.courseCaseStudyEntity.attendanceTable!.answer!.answer,));
            }





              return Scaffold(
              appBar:appBarWidget("",context,true,null,null),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17,right: 17,bottom: 60),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widgetList,),
                      ),
                    ),
                  ),



                  ///If case study is OPEN, we must show a field so that the user can type.
                  if((state.courseCaseStudyEntity.attendanceTable==null ||state.courseCaseStudyEntity.attendanceTable==null)
                      && widget.caseStudy.open==true)
                    SendAnswerWidget( flutterMentionsKey: key,onTap: () {
                      msgShow=true;
                      if(key.currentState!.controller!.markupText!=""){



                        BlocProvider.of<MyCoursesBloc>(context).add(
                            AttendCaseEvent(params:AttendCaseParams(
                                caseId: widget.caseStudy.casestudyId,
                                userId: userId(),
                                date: DateTime.now(),
                                answer: key.currentState!.controller!.markupText)
                            ));

                      }else{
                        showMessage(message: "الرجاء اضافة تعليق", context: context);
                        setState(() {
                        });
                      }

                    },),


                  ///If case study was CLOSED, we must show a button so that the user can send the chosen answer.
                  if(
                  (state.courseCaseStudyEntity.attendanceTable==null) &&
                      widget.caseStudy.open==false
                  )
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 17,right: 17),
                    child: SafeArea(child: CustomButton(title: "ارسل الجواب",onTap: (){
                      msgShow=true;
                      //answerId

                      BlocProvider.of<MyCoursesBloc>(context).add(
                          AttendCaseEvent(params:AttendCaseParams(
                            answerId: val.toString(),
                              caseId: widget.caseStudy.casestudyId,
                              userId: userId(), date: DateTime.now(),
                              /// <answer> this variable must be empty if one option is send because the case is closed
                              answer: null
                          )
                          ));

                    },)),
                  ),
                ],
              ),
            );
          }

          return const WaitingWidget();

        }));







  }

  String getAnswerById(CourseCaseStudyEntity  courseCaseStudyEntity,int answerId) {
    if(courseCaseStudyEntity.solution!=null) {
      for (var item in courseCaseStudyEntity.solution!.answers) {
        if (item.answerId == answerId) {
          return parseHtmlString(item.answer);
        }
      }
    }

    return "";
  }
}

class ItemOpenCaseStudy extends StatelessWidget {
  const ItemOpenCaseStudy({Key? key, required this.answer}) : super(key: key);
  final String answer;

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(
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
                  Text("الجواب",style: blackBoldTextStyle(fontSize: 14, context: context),),
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
              child: Row(
                children: [

                  SizedBox(
                      width: size.width-58,
                      child: Text(
                        parseHtmlString(answer),style: blackBoldTextStyle(fontSize: 12, context: context),)),
                ],
              ),
            ),
          ],
        ));
  }
}

/// the question of the case study will showing using this widget.
class CaseStudyQuestion extends StatelessWidget {
  const CaseStudyQuestion({Key? key,required this.header,this.body}) : super(key: key);
  final String header;
  final String ? body;

  @override
  Widget build(BuildContext context) {
    return   Padding(
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
                      SizedBox(width: 11,),
                      Text("حالة دراسية",style: blackBoldTextStyle(fontSize: 14, context: context),),
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
                    parseHtmlString(header),style: blackBoldTextStyle(context: context,fontSize: 12,height: lineSpace),),
                ),
                if(body!=null)
                Padding(
                  padding: const EdgeInsets.only(left: 11,right: 11),
                  child: Text(
                    parseHtmlString(body!),style: blackBoldTextStyle(context: context,fontSize: 12,height: lineSpace),),
                ),
              ],
            ),
          )),
    );
  }
}

class SendAnswerWidget extends StatelessWidget {
  const SendAnswerWidget({Key? key,required this.onTap,required this.flutterMentionsKey}) : super(key: key);
  final Function () onTap;
  final Key flutterMentionsKey;

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top:5),
        child: Row(
          //
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: size.width*0.84,
              // height: 50,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: FlutterMentions(
                // scrollPadding:  const EdgeInsets.only(right: 10,bottom: 5,left: 10),
                key: flutterMentionsKey,
                suggestionListDecoration: BoxDecoration(
                  color:    Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: Theme.of(context).primaryColor,
                  //   width: 1
                  // )
                ),
                suggestionPosition: SuggestionPosition.Top,
                maxLines: 5,
                minLines: 1,
                // keyboardType: TextInputType.multiline,
                keyboardType:TextInputType.text ,


                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "اكتب الحل هنا ...",
                  hintStyle: blackBoldTextStyle(context: context,fontSize: 12,color: hintTextColor),
                  filled: true,
                  fillColor: textFormFieldFillColor,
                  contentPadding: const EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                mentions: [
                  Mention(
                      trigger: '@',
                      style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),

                      data:[],

                      matchAll: false,

                      suggestionBuilder: (data) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6,top: 10,left: 6),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: const EdgeInsets.only(right: 10,bottom: 10,left: 10,top: 10),
                            child: Row(
                              children: <Widget>[

                                CircleAvatar(
                                  radius:15,
                                  backgroundImage: NetworkImage(
                                    data['photo'],
                                  ),

                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(data['full_name'],style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).canvasColor),),
                                    // Text('@${data['display']}',style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).canvasColor),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),

                ],
              ),

            ),
            GestureDetector(
                onTap:onTap,

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.send,color: iconsColor,size: 30,),
                )),

          ],
        ),
      ),
    );
  }
}




