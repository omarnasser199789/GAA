// To parse this JSON data, do
//
//     final activityFillingModel = activityFillingModelFromJson(jsonString);

import 'dart:convert';

import '../../../../core/classes/word_type3.dart';
import '../../../../core/classes/word_type4.dart';
import '../../domain/entities/activity_filling_entity.dart';

ActivityFillingModel activityFillingModelFromJson(String str) => ActivityFillingModel.fromJson(json.decode(str));

String activityFillingModelToJson(ActivityFillingModel data) => json.encode(data.toJson());

class ActivityFillingModel  extends ActivityFillingEntity{
  ActivityFillingModel({
  required  this.id,
  required  this.userId,
  required  this.email,
  required  this.questionId,
  required  this.sentence,
  required  this.correct,
  required  this.isCorrect,
  required  this.reply,
  required  this.answer,
  required  this.date,
  required  this.words,
  }):super(
    id:id,
    userId:userId,
    email:email,
    questionId:questionId,
    sentence:sentence,
    correct:correct,
    isCorrect:isCorrect,
    reply:reply,
    answer:answer,
    date:date,
    words:words,
  );

  int id;
  int userId;
  dynamic email;
  int questionId;
  dynamic sentence;
  dynamic correct;
  dynamic isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime date;
  List<WordType4> words;

  factory ActivityFillingModel.fromJson(Map<String, dynamic> json) => ActivityFillingModel(
    id: json["id"],
    userId: json["userId"],
    email: json["email"],
    questionId: json["questionId"],
    sentence: json["sentence"],
    correct: json["correct"],
    isCorrect: json["isCorrect"],
    reply: json["reply"],
    answer: json["answer"],
    date: DateTime.parse(json["date"]),
    words: List<WordType4>.from(json["words"].map((x) => WordType4.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "email": email,
    "questionId": questionId,
    "sentence": sentence,
    "correct": correct,
    "isCorrect": isCorrect,
    "reply": reply,
    "answer": answer,
    "date": date.toIso8601String(),
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}

// class Word {
//   Word({
//   required  this.id,
//   required  this.attendanceId,
//   required  this.word,
//   required  this.order,
//   required  this.correctOrder,
//   required  this.correctWord,
//   });
//
//   int id;
//   int attendanceId;
//   int word;
//   int order;
//   int correctOrder;
//   String correctWord;
//
//   factory Word.fromJson(Map<String, dynamic> json) => Word(
//     id: json["id"],
//     attendanceId: json["attendanceId"],
//     word: json["word"],
//     order: json["order"],
//     correctOrder: json["correctOrder"],
//     correctWord: json["correctWord"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "attendanceId": attendanceId,
//     "word": word,
//     "order": order,
//     "correctOrder": correctOrder,
//     "correctWord": correctWord,
//   };
// }
