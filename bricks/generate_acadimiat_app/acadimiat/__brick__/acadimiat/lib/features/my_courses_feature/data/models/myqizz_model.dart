// To parse this JSON data, do
//
//     final MyQuizizzModel = MyQuizizzModelFromJson(jsonString);

import 'dart:convert';

import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';

import '../../../../core/classes/question.dart';



MyQuizizzModel MyQuizizzModelFromJson(String str) => MyQuizizzModel.fromJson(json.decode(str));

String MyQuizizzModelToJson(MyQuizizzModel data) => json.encode(data.toJson());

class MyQuizizzModel  extends  MyQuizizzEntity{
  MyQuizizzModel({
  required  this.id,
  required  this.materialId,
  required  this.courseId,
    this.unitId,
  required  this.name,
  required  this.beforeStart,
  required  this.optional,
  required  this.timeLimit,
  required  this.shuffle,
  required  this.repetition,
  required  this.myAttempts,
  required  this.ifPassed,
  required  this.ifFailed,
  required  this.minScore,
  required  this.attendance,
  required  this.questions,
  }):super(
    id:id,
    materialId:materialId,
    courseId:courseId,
    unitId:unitId,
    name:name,
    beforeStart:beforeStart,
    optional:optional,
    timeLimit:timeLimit,
    shuffle:shuffle,
    repetition:repetition,
    myAttempts:myAttempts,
    ifPassed:ifPassed,
    ifFailed:ifFailed,
    minScore:minScore,
    attendance:attendance,
    questions:questions,
  );

 final int id;
 final dynamic materialId;
 final int courseId;
 final int  ? unitId;
 final String name;
 final bool beforeStart;
 final bool optional;
 final int timeLimit;
 final bool shuffle;
 final int repetition;
 final int myAttempts;
 final int ifPassed;
 final int ifFailed;
 final double minScore;
 final dynamic attendance;
 final List<Question> questions;

  factory MyQuizizzModel.fromJson(Map<String, dynamic> json) => MyQuizizzModel(
    id: json["id"],
    materialId: json["materialId"],
    courseId: json["courseId"],
    unitId: json["unitId"],
    name: json["name"],
    beforeStart: json["beforeStart"],
    optional: json["optional"],
    timeLimit: json["timeLimit"],
    shuffle: json["shuffle"],
    repetition: json["repetition"],
    myAttempts: json["myAttempts"],
    ifPassed: json["ifPassed"],
    ifFailed: json["ifFailed"],
    minScore: json["minScore"],
    attendance: json["attendance"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialId": materialId,
    "courseId": courseId,
    "unitId": unitId,
    "name": name,
    "beforeStart": beforeStart,
    "optional": optional,
    "timeLimit": timeLimit,
    "shuffle": shuffle,
    "repetition": repetition,
    "myAttempts": myAttempts,
    "ifPassed": ifPassed,
    "ifFailed": ifFailed,
    "minScore": minScore,
    "attendance": attendance,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}
///
// class Question {
//   Question({
//  required this.id,
//  required this.quizzId,
//  required this.questionType,
//  required this.score,
//  required this.optional,
//  required this.question,
//  required this.title,
//  required this.stripped,
//  required this.words,
//  required this.answer,
//  required this.pairs,
//  required this.pairsSelection,
//   });
//
//   int id;
//   int quizzId;
//   int questionType;
//   int score;
//   bool optional;
//   String question;
//   dynamic title;
//   dynamic stripped;
//   List<Word> words;
//   List<Answer> answer;
//   List<Pair> pairs;
//   List<Pair> pairsSelection;
//
//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//     id: json["id"],
//     quizzId: json["quizzId"],
//     questionType: json["questionType"],
//     score: json["score"],
//     optional: json["optional"],
//     question: json["question"],
//     title: json["title"],
//     stripped: json["stripped"],
//     words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
//     answer: List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
//     pairs: List<Pair>.from(json["pairs"].map((x) => Pair.fromJson(x))),
//       pairsSelection: List<Pair>.from(json["pairsSelection"].map((x) => Pair.fromJson(x)))
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "quizzId": quizzId,
//     "questionType": questionType,
//     "score": score,
//     "optional": optional,
//     "question": question,
//     "title": title,
//     "stripped": stripped,
//     "words": List<dynamic>.from(words.map((x) => x.toJson())),
//     "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
//     "pairs": List<dynamic>.from(pairs.map((x) => x.toJson())),
//     "pairsSelection": List<dynamic>.from(pairsSelection.map((x) => x.toJson())),
//   };
// }






