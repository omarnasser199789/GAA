// To parse this JSON data, do
//
//     final activityCaseModel = activityCaseModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/activity_case_entity.dart';

ActivityCaseModel activityCaseModelFromJson(String str) => ActivityCaseModel.fromJson(json.decode(str));

String activityCaseModelToJson(ActivityCaseModel data) => json.encode(data.toJson());

class ActivityCaseModel extends ActivityCaseEntity {
  ActivityCaseModel({
  required  this.id,
  required  this.userId,
  required  this.answerId,
  required  this.caseId,
  required  this.correctAnswerId,
  required  this.correctAnswer,
  required  this.email,
  required  this.solution,
  required  this.explanation,
  required  this.explanation2,
  required  this.isCorrect,
  required  this.reply,
  required  this.answer,
  required  this.date,
  }):super(
    id:id,
    userId:userId,
    answerId:answerId,
    caseId:caseId,
    correctAnswerId:correctAnswerId,
    correctAnswer:correctAnswer,
    email:email,
    solution:solution,
    explanation:explanation,
    explanation2:explanation2,
    isCorrect:isCorrect,
    reply:reply,
    answer:answer,
    date:date,
  );

  int id;
  int userId;
  int answerId;
  int caseId;
  int correctAnswerId;
  String correctAnswer;
  dynamic email;
  dynamic solution;
  String explanation;
  String explanation2;
  bool isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime date;

  factory ActivityCaseModel.fromJson(Map<String, dynamic> json) => ActivityCaseModel(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    answerId: (json["answerId"]!=null)?json["answerId"]:-1,
    caseId:( json["caseId"]!=null)? json["caseId"]:-1,
    correctAnswerId: (json["correctAnswerId"]!=null)?json["correctAnswerId"]:-1,
    correctAnswer: (json["correctAnswer"]!=null)?json["correctAnswer"]:"",
    email: (json["email"]!=null)?json["email"]:"",
    solution: json["solution"],
    explanation: (json["explanation"]!=null)?json["explanation"]:"",
    explanation2: (json["explanation2"]!=null)?json["explanation2"]:"",
    isCorrect: (json["isCorrect"]!=null)?json["isCorrect"]:false,
    reply: json["reply"],
    answer: json["answer"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "answerId": answerId,
    "caseId": caseId,
    "correctAnswerId": correctAnswerId,
    "correctAnswer": correctAnswer,
    "email": email,
    "solution": solution,
    "explanation": explanation,
    "explanation2": explanation2,
    "isCorrect": isCorrect,
    "reply": reply,
    "answer": answer,
    "date": date.toIso8601String(),
  };
}
