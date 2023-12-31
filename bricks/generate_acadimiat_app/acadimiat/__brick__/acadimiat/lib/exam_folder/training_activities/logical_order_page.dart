import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/functions.dart';
import '../../core/globals.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../core/widgets/right_answer.dart';
import '../../features/my_courses_feature/data/models/my_lecture_model.dart';
import '../../features/my_courses_feature/domain/use_cases/activity_logical_usecase.dart' as o;
import '../../features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import '../../features/profile_feature/presentation/bloc/bloc.dart';
import '../../injection_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class LogicalOrderPage extends StatefulWidget {

  const LogicalOrderPage({Key? key,required this.nestedContent}) : super(key: key);
  final NestedContent nestedContent;

  @override
  State<LogicalOrderPage> createState() => _LogicalOrderPageState();
}

class _LogicalOrderPageState extends State<LogicalOrderPage> {

  List<Widget> widgetList=[];


  bool firstOne=false;


  ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    widgetList=[];
    // widgetList.add(Row(
    //   children: [
    //     Text(widget.nestedContent.activity.logicalOrder!.title,style: blackBoldTextStyle(fontSize: 15, context: context),),
    //   ],
    // ));

    ///User not answer yest.
    if(widget.nestedContent.activity.logicalOrder!.attendanceTable.isEmpty) {
      List<Widget> answerList=[];//widgetList

      for (int index = 0; widget.nestedContent.activity.logicalOrder!.sentences
          .length > index; index++) {
        answerList.add(Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: DragTarget(
              builder: (BuildContext context, List<Object?> candidateData,
                  List<dynamic> rejectedData) {
                return Draggable(
                  data: index,
                  feedback: Material(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.1),
                      child: SizedBox(
                          width: size.width - 34,
                          child: ItemList(sentence: widget.nestedContent.activity
                              .logicalOrder!.sentences[index],color: Colors.grey.withOpacity(0.5),))),


                  child: ItemList(
                      sentence: widget.nestedContent.activity.logicalOrder!
                          .sentences[index],color: Colors.grey.withOpacity(0.5),),
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
                int targetItemIndex = index;
                int? indexMovingItem = data as int?;

                ///save selected item that user want to move it
                Sentence movingItem = widget.nestedContent.activity.logicalOrder!
                    .sentences[indexMovingItem!];

                ///remove movingItem
                widget.nestedContent.activity.logicalOrder!.sentences.removeAt(
                    indexMovingItem);


                ///replace item using target index
                widget.nestedContent.activity.logicalOrder!.sentences
                    .replaceRange(targetItemIndex, targetItemIndex, [movingItem]);


                setState(() {

                });
              }
          ),
        ));
      }

      widgetList.add(Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:18,bottom: 18),
              child: Column(
                children: [



                  Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
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
                        SizedBox(
                          width: size.width-121,
                            child: Text(widget.nestedContent.activity.logicalOrder!.title,style: blackBoldTextStyle(fontSize: 14, context: context),)),
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


                  Container(
                    constraints: BoxConstraints(
                      maxHeight: size.height-290//257
                    ),
                    height: 65 * answerList.length/1,
                    // color: Colors.red,
                    child: DraggableScrollbar.semicircle(
                         alwaysVisibleScrollThumb: (answerList.length > size.height/100)?true:false,
                         // alwaysVisibleScrollThumb: true,
                         controller: myScrollController,
                         child: ListView(
                           controller: myScrollController,
                           children: answerList,
                         )
                     ),
                  ),


                  // Column(
                  //   // controller: myScrollController,
                  //   children: answerList,
                  // ),


                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12,right: 12),
                  //   child: Column(children: answerList,),
                  // ),
                ],
              ),
            )),
      ));

    }





    else{
      // widgetList
      ///User answer, and need to show result
      List<Widget> answerList=[];
      // answerList.add(Padding(
      //   padding: const EdgeInsets.only(left: 12,right: 12),
      //   child: Row(
      //     children: [
      //       Text(widget.nestedContent.activity.logicalOrder!.title,style: blackBoldTextStyle(fontSize: 15, context: context),),
      //     ],
      //   ),
      // ));
      for (int index = 0; widget.nestedContent.activity.logicalOrder!.attendanceTable[0].orders.length > index; index++) {
        if( widget.nestedContent.activity.logicalOrder!.attendanceTable[0].orders[index].order
            ==widget.nestedContent.activity.logicalOrder!.attendanceTable[0].orders[index].correct){
          ///if answer is correct
          answerList.add(
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: ItemList(sentence:
                        getSentencesById(
                            widget.nestedContent.activity.logicalOrder!.sentences,
                            widget.nestedContent.activity.logicalOrder!.attendanceTable[0].orders[index].sentenceId)
                          ,color: percentIndicatorColor,
                          fontColor:percentIndicatorColor ,
                        )
                    ),
                    const RightAnswer(),
                  ],
                ),
              )
          );
        } else{
          /// if answer is not correct
          answerList.add(
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            ItemList(sentence: getSentencesById(widget.nestedContent.activity.logicalOrder!.sentences,
                            widget.nestedContent.activity.logicalOrder!.attendanceTable[0].orders[index].sentenceId)
                            ,color: Colors.red,fontColor: Colors.red,),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top:6),
                      child: Text("الإجابة خاطئة ",style: blackBoldTextStyle(fontSize: 12, context: context,color: Colors.red),),
                    )
                  ],
                ),
              )
          );
        }

      }


      widgetList.add(Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(//
            padding: const EdgeInsets.only(top:18,bottom: 18),
            child: Column(
              children: [


                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
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
                      SizedBox(
                        width: size.width -102,

                          child: Text(widget.nestedContent.activity.logicalOrder!.title,style: blackBoldTextStyle(fontSize: 14, context: context,height: lineSpace),)),
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



                Column(children: answerList,),
              ],
            ),
          )));
    }


    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {


          if(state is SuccessActiveLogicalState){
            if(firstOne) {
              firstOne=false;
              showMessage(message: "تم ارسال الحل",
                  context: context,
                  bgColor: percentIndicatorColor);

              widget.nestedContent.activity.logicalOrder!.attendanceTable = [
                LogicalOrderAttendanceTable(id: state.activeLogicalEntity.id,
                    userId: state.activeLogicalEntity.userId,
                    questionId: state.activeLogicalEntity.questionId,
                    email: state.activeLogicalEntity.email,
                    isCorrect: state.activeLogicalEntity.isCorrect,
                    date: state.activeLogicalEntity.date,
                    orders: state.activeLogicalEntity.orders)
              ];

              Future.delayed(const Duration(milliseconds: 1000), () {
                setState(() {

                });
              });
            }
          }

          return Scaffold(
            appBar:appBarWidget("",context,true,null,null),
            body: Padding(
              padding: const EdgeInsets.only(left: 17,right: 17),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: widgetList,
                      ),
                    ),
                  ),


                  if(widget.nestedContent.activity.logicalOrder!.attendanceTable.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 10),
                    child: SafeArea(
                      child: CustomButton(title: "ارسال الحل",
                          onTap: (){
                            firstOne=true;
                            List<o.Order> orders=[];
                            for(int order=0; widget.nestedContent.activity.logicalOrder!.sentences.length>order;order++){
                              orders.add(o.Order(sentenceId:widget.nestedContent.activity.logicalOrder!.sentences[order].id, order: order));
                            }

                        BlocProvider.of<MyCoursesBloc>(context).add(ActivityLogicalEvent(params:
                        o.ActivityLogicalParams(
                          userId: userId(),
                          questionId: widget.nestedContent.activity.logicalOrder!.id,
                          date: DateTime.now(),
                          orders: orders,

                        )));

                      }),
                    ),
                  )

                ],
              ),
            ),
          );

        }));



  }

  Sentence ? getSentencesById(List<Sentence> sentences,int id) {
    for(var item in sentences){
      if(item.id==id){
        if (kDebugMode) {
          print(item.sentence);
        }
        return item;
      }
    }
    }
  }


























class ItemList extends StatelessWidget {
  const ItemList({Key? key, this.sentence,this.color,this.fontColor}) : super(key: key);

  final Sentence ? sentence;
  final Color  ?color;
  final Color ?fontColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: double.infinity,
          decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:(color==null)?Theme.of(context).cardColor:color!,
                width: 1
              ),
              color:Theme.of(context).cardColor
          ),

          alignment: Alignment.center,

          child: Padding(
            padding: const EdgeInsets.only(top:17,bottom: 17,left: 8,right: 8),
            child: Text(sentence!.sentence,style: blackBoldTextStyle(fontSize: 12, context: context,color: fontColor),),
          )),
    );
  }
}
