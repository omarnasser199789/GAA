import 'dart:convert';
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

 final int id;
 final int userId;
 final dynamic email;
 final int questionId;
 final dynamic sentence;
 final dynamic correct;
 final dynamic isCorrect;
 final dynamic reply;
 final dynamic answer;
 final DateTime date;
 final List<WordType4> words;

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
