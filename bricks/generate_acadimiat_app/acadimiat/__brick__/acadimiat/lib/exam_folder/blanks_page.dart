import 'package:acadmiat/exam_folder/exam_page.dart';
import 'package:acadmiat/exam_folder/widgets/question_number.dart';
import 'package:flutter/material.dart';
import '../Theme/style.dart';
import '../core/classes/question.dart';
import '../core/classes/word_type2.dart';
import '../features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';

class BlanksPage extends StatefulWidget {
  const BlanksPage(
      {super.key, required this.question, required this.questionNumber});
  final Question question;
  final int questionNumber;
  @override
  State<BlanksPage> createState() => _BlanksPageState();
}

class MyClass {
  Widget widget;
  int? index;
  int? id;
  int? wordIndex;
  MyClass({required this.widget, this.index, this.id, this.wordIndex});
}

class _BlanksPageState extends State<BlanksPage> {
  bool firstOne = true;

  List<MyClass> widgetList = [];
  List<MyClass> wordsList = [];
  List<GivenWord> givenWords = [];
  int numberWordInWordsList=0;

  @override
  Widget build(BuildContext context) {
    List<String> sentencesList = widget.question.question.split("\$\$\$\$");

    if (firstOne) {
      firstOne = false;


      int blankIndex = 0;

      for (int i = 0; sentencesList.length > i; i++) {
        List<String> wordsList = sentencesList[i].split(" ");

        for (var it in wordsList) {
          widgetList.add(MyClass(
              widget: Text(
            "${it.replaceAll("\n", "")} ",
            style: blackBoldTextStyle(fontSize: 14, context: context),
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

      for (int i = 0; widget.question.words.length > i; i++) {
        wordsList.add(MyClass(
            widget: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Theme.of(context).primaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.question.words[i].word,
                    style: blackBoldTextStyle(fontSize: 15, context: context),
                  ),
                )),
            id: widget.question.words[i].wordId));
      }
      numberWordInWordsList =wordsList.length;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                QuestionNumber(
                  text: widget.questionNumber.toString(),
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  "الرجاء تعبئة الفراغات",
                  style: blackBoldTextStyle(fontSize: 14, context: context),
                ),
              ],
            ),
          ),

          ///WORDS LIST
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Wrap(
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

          ///WIDGETS LIST
          Wrap(
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
                            print(id);

                            late Widget _widget;

                            /// Get words from wordsList
                            for (var item in wordsList) {
                              if (item.id == id) {
                                _widget = item.widget;
                              }
                            }

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

                              /// Remove word by id from wordsList
                              for (int i = 0; wordsList.length > i; i++) {
                                if (wordsList[i].id == id) {
                                  wordsList.removeAt(i);
                                }
                              }
                            }

                            ///Declaring a new word to get selected word and but it in
                            ///word : selected word
                            WordType2 word = WordType2(
                                wordId: -1,
                                questionId: -1,
                                word: '',
                                order: "");

                            ///Get selected word
                            for (var item in widget.question.words) {
                              if (item.wordId == id) {
                                word = item;
                              }
                            }

                            /// Make sure this word is not already in givenWords list
                            for (int i = 0; givenWords.length > i; i++) {
                              if (word.wordId == givenWords[i].word) {
                                givenWords.removeAt(i);
                              }
                            }

                            /// Add selected word in List<GivenWord>
                            givenWords.add(GivenWord(
                                questionId: word.questionId,
                                word: word.wordId,
                                order: i.wordIndex));


                            /// Make sure this AttendanceTable is not already in List<AttendanceTable>
                            for (int i = 0; attendanceTable.length > i; i++) {
                              if (attendanceTable[i].questionId ==
                                  widget.question.id) {
                                attendanceTable.removeAt(i);
                              }
                            }

                            /// Add AttendanceTable in List<AttendanceTable>
                            attendanceTable.add(AttendanceTable(
                                questionId: widget.question.id,
                                givenAnswers: [],
                                givenWords: givenWords,
                                pairs: []));

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

          if(wordsList.length<numberWordInWordsList)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                wordsList = [];
                widgetList = [];
                firstOne = true;
                setState(() {});
              },
              child: Container(
                width: 150,
                height: 40,
                // color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  "اعادة ترتيب الكلمات",
                  style: blackBoldTextStyle(
                      fontSize: 15,
                      context: context,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
