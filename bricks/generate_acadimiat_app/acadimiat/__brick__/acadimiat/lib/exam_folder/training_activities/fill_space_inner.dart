import 'package:acadmiat/exam_folder/exam_page.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Theme/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../core/classes/question.dart';
import '../../core/classes/word_type3.dart';
import '../../core/functions.dart';
import '../../core/globals.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../core/widgets/custom_botton.dart';
import '../../features/my_courses_feature/data/models/my_lecture_model.dart' as p;
import '../../features/my_courses_feature/data/models/my_lecture_model.dart';
import '../../features/my_courses_feature/domain/use_cases/activity_filling_usecase.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../../features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import '../blanks_page.dart';

class FillSpaceInner extends StatefulWidget {
  const FillSpaceInner({Key? key,required this.nestedContent}) : super(key: key);
  final p.NestedContent nestedContent;


  @override
  State<FillSpaceInner> createState() => _FillSpaceInnerState();
}

class _FillSpaceInnerState extends State<FillSpaceInner> {
  bool firstOne = true;
  bool firstTime = true;

  List<MyClass> widgetList = [];
  List<MyClass> wordsList = [];
  List<WordType3> givenWords = [];
  int numberWordInWordsList=0;


  @override
  Widget build(BuildContext context) {
    List<String> sentencesList = widget.nestedContent.activity.filling!.stripped.split("(X)");
Size size = MediaQuery.of(context).size;

    if (firstOne) {
      firstOne = false;


      int blankIndex = 0;

      for (int i = 0; sentencesList.length > i; i++) {
        List<String> wordsList = sentencesList[i].split(" ");

        for (var it in wordsList) {
          widgetList.add(MyClass(
              widget: Text(
                it.replaceAll("\n", "") + " ",
                style: blackBoldTextStyle(fontSize: 12, context: context),
              )));
        }

        blankIndex += wordsList.length - 1;

        if (i != sentencesList.length - 1) {
          // blankIndex++;
          widgetList.add(MyClass(
              widget: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).canvasColor.withOpacity(0.2),
                        )),
                    width: 80,
                    height: 40),
              ),
              wordIndex: blankIndex,
              index: widgetList.length));
        }
      }

      wordsList = [];

      for (int i = 0; widget.nestedContent.activity.filling!.words.length > i; i++) {
        wordsList.add(MyClass(
            widget: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.nestedContent.activity.filling!.words[i].word,
                    style: blackBoldTextStyle(fontSize: 12, context: context),
                  ),
                )),
            id: widget.nestedContent.activity.filling!.words[i].id));
      }
      numberWordInWordsList =wordsList.length;
    }


    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {


          if(state is SuccessActivityFillingState){
            showMessage(message: "تم ارسال الحل", context: context,bgColor: percentIndicatorColor);

            if(firstTime) {
              firstTime=false;
              widget.nestedContent.activity.filling!.attendanceTable =
              [AttendanceTable(words: state.activityFillingEntity.words)];
              widgetList = [];
              wordsList = [];
              givenWords = [];
              numberWordInWordsList = 0;
              firstOne = true;
              Future.delayed(Duration(milliseconds: 1000), () {
                setState(() {

                });
              });

            }
          }

          if(widget.nestedContent.activity.filling!.attendanceTable.isEmpty){
            return Scaffold(
              appBar:appBarWidget("",context,true,null,null),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60,left: 17,right: 17),
                    child: Container(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          ///Fill part, let user select from here
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            "assets/svgs/question.svg",
                                          ),
                                        ),
                                        SizedBox(width: 11,),
                                        Text(
                                          widget.nestedContent.activity.filling!.title,
                                          style: blackBoldTextStyle(fontSize: 14, context: context),
                                        ),
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
                                  ///WORDS LIST
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 12),
                                    child: Container(
                                      width: double.infinity,
                                      // color: Colors.red,
                                      constraints: BoxConstraints(
                                        maxHeight: size.height*0.15,
                                        maxWidth: MediaQuery.of(context).size.width,

                                      ),
                                      child: SingleChildScrollView(

                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceBetween,
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            direction: Axis.horizontal,
                                            children: wordsList
                                                .map((e) => Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Draggable(
                                                data: e.id,
                                                feedback: Material(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withOpacity(0.1),
                                                    child: e.widget),
                                                child: e.widget,
                                              ),
                                            ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ///Rest button
                                  if(wordsList.length<numberWordInWordsList)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18,left: 12,right: 12,bottom: 18),
                                      child: CustomButton(title: "إعادة ترتيب الكلمات",
                                        height: 33,
                                        fontSize: 14,
                                        width: 159,
                                        onTap: (){
                                          wordsList = [];
                                          widgetList = [];
                                          firstOne = true;
                                          setState(() {});
                                        },),
                                      // child: GestureDetector(
                                      //   onTap: () {
                                      //     wordsList = [];
                                      //     widgetList = [];
                                      //     firstOne = true;
                                      //     setState(() {});
                                      //   },
                                      //   child: Container(
                                      //     width: 150,
                                      //     height: 40,
                                      //     // color: Colors.blue,
                                      //     alignment: Alignment.center,
                                      //     child: Text(
                                      //       "اعادة ترتيب الكلمات",
                                      //       style: blackBoldTextStyle(
                                      //           fontSize: 15,
                                      //           context: context,
                                      //           color: Theme.of(context).primaryColor),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                ],
                              ),
                            ),
                          ),





                          ///WIDGETS LIST, Let user put selected fill here.
                          Padding(
                            padding: const EdgeInsets.only(top:15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),

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
                                          Text("العبارات",style: blackBoldTextStyle(fontSize: 14, context: context),),
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
                                      padding: const EdgeInsets.only(left: 12,right: 12),
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxHeight: size.height*0.32,
                                          maxWidth: MediaQuery.of(context).size.width,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            direction: Axis.horizontal,
                                            children: widgetList
                                                .map(
                                                  (i) => (i.index != null)
                                                  ? DragTarget(
                                                  builder: (BuildContext context,
                                                      List<Object?> candidateData,
                                                      List<dynamic> rejectedData) {
                                                    return i.widget;
                                                  },
                                                  onWillAccept: (data) => true,
                                                  onAccept: (data) {
                                                    int? id = data as int?;
                                                    // print(id);

                                                    late Widget _widget;

                                                    /// Get words from wordsList
                                                    for (var item in wordsList) {
                                                      if (item.id == id) {
                                                        _widget = item.widget;
                                                      }
                                                    }

                                                    // print("fdkjvndfknvjkdfnjkvdfnbvkjbfd");
                                                    // print(widgetList[i.index!].index);
                                                    // print(widgetList[i.index!].wordIndex);
                                                    // print(widgetList[i.index!].widget);

                                                    ///If blank was empty or not ( because we don't wont to let user but word in blank containing word )
                                                    if (widgetList[i.index!].wordIndex != null) {
                                                      /// Replacing blank with word using blank index
                                                      widgetList[i.index!] = MyClass(
                                                        widget: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(
                                                                  width: 1,
                                                                  color: Theme.of(context)
                                                                      .canvasColor
                                                                      .withOpacity(0.2),
                                                                )),
                                                            child: Padding(
                                                                padding: const EdgeInsets.all(5),
                                                                child: _widget
                                                            ),
                                                          ),
                                                        ),
                                                        index: i.index,
                                                      );

                                                      /// Remove word by id from wordsList(word display list)
                                                      for (int i = 0; wordsList.length > i; i++) {
                                                        if (wordsList[i].id == id) {
                                                          wordsList.removeAt(i);
                                                        }
                                                      }
                                                    }

                                                    ///Declaring a new word to get selected word and but it in
                                                    ///word : selected word
                                                    WordType3 word = WordType3(questionId: -1, word: -1, order: '');

                                                    // print("wordID:${id}");

                                                    ///Get selected word
                                                    for (var item in widget.nestedContent.activity.filling!.words) {
                                                      if (item.id == id) {

                                                        word =WordType3(
                                                          questionId:widget.nestedContent.activity.filling!.id,
                                                          word: item.id,
                                                          order:i.wordIndex.toString(),
                                                        );

                                                      }
                                                    }

                                                    /// Make sure this word is not already in givenWords list
                                                    for (int i = 0; givenWords.length > i; i++) {
                                                      if (word.word == givenWords[i].word) {
                                                        givenWords.removeAt(i);
                                                      }
                                                    }

                                                    /// Add selected word in List<GivenWord>
                                                    givenWords.add(word);


                                                    /// Make sure this AttendanceTable is not already in List<AttendanceTable>
                                                    // for (int i = 0; attendanceTable.length > i; i++) {
                                                    //   if (attendanceTable[i].questionId ==
                                                    //       widget.question.id) {
                                                    //     attendanceTable.removeAt(i);
                                                    //   }
                                                    // }
                                                    //
                                                    // /// Add AttendanceTable in List<AttendanceTable>
                                                    // attendanceTable.add(AttendanceTable(
                                                    //     questionId: widget.question.id,
                                                    //     givenAnswers: [],
                                                    //     givenWords: givenWords,
                                                    //     pairs: []));

                                                    // print("fvbjhdfnkvjndfkvsdbk");
                                                    // print(id);
                                                    // print("QuestionId:${widget.question.id}");
                                                    // print(attendanceTable.length);

                                                    setState(() {}); //
                                                  })
                                                  : i.widget,
                                            )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),





















                        ],
                      ),
                    ),
                  ),

                  if(widget.nestedContent.activity.filling!.attendanceTable.isEmpty)
                    SafeArea(child: Padding(
                      padding: const EdgeInsets.only(bottom: 10,top:10),
                      child: CustomButton(title: "ارسل الحل",
                        onTap: (){

                          BlocProvider.of<MyCoursesBloc>(context).add(ActivityFillingEvent(params:
                          ActivityFillingParams(
                            userId: userId(),
                            questionId:  widget.nestedContent.activity.filling!.id,
                            date: DateTime.now(),
                            words: givenWords,
                          )));

                        },
                      ),
                    ))
                ],
              ),
            );
          }else{
            ///User answer, show result in this part
            return Scaffold(
              appBar:appBarWidget("",context,true,null,null),
              body:  Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
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
                                    Text(widget.nestedContent.activity.filling!.title,style: blackBoldTextStyle(fontSize: 14, context: context),),
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


                              ///WIDGETS LIST


                              Padding(
                                padding: const EdgeInsets.only(left: 12,right: 12,top: 18),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.horizontal,
                                  children: widgetList
                                      .map(
                                        (i) => (i.index != null)
                                        ?

                                        correctWord(index:i.wordIndex!,list:widget.nestedContent.activity.filling!.attendanceTable)

                                        : i.widget,
                                  )
                                      .toList(),
                                ),
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



        }));


  }
  Widget correctWord({required int index ,required List<AttendanceTable> list}){
    for(var item in  list[0].words){
      if(item.order==index){
        if(item.order==item.correctOrder) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color:percentIndicatorColor,
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(item.correctWord,style: blackBoldTextStyle(fontSize: 14, context: context,color: percentIndicatorColor),)
              ),
            ),
          );


        }
        else{
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1,
                    color: Colors.red,
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(item.correctWord,style: blackBoldTextStyle(fontSize: 14, context: context,color: Colors.red),)
              ),
            ),
          );
        }
      }
    }

    return const Text('');
  }
}
