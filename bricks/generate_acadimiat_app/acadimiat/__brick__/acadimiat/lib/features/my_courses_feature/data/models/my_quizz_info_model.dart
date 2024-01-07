// To parse this JSON data, do
//
//     final myQuizzInfoModel = myQuizzInfoModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_quizz_info_entity.dart';

MyQuizzInfoModel myQuizzInfoModelFromJson(String str) => MyQuizzInfoModel.fromJson(json.decode(str));

String myQuizzInfoModelToJson(MyQuizzInfoModel data) => json.encode(data.toJson());

class MyQuizzInfoModel extends MyQuizzInfoEntity {
  MyQuizzInfoModel({
  required  this.quizzId,
  required  this.quizzName,
  required  this.totalAttempts,
  required  this.totalTime,
  required  this.hasPassword,
  required  this.minScore,
  required  this.beforeStart,
  required  this.optional,
  required  this.myAttempts,
  }) : super(
    quizzId:quizzId,
    quizzName:quizzName,
    totalAttempts:totalAttempts,
    totalTime:totalTime,
    hasPassword:hasPassword,
    minScore:minScore,
    beforeStart:beforeStart,
    optional:optional,
    myAttempts:myAttempts,
  );

 final  int quizzId;
 final  String quizzName;
 final  int totalAttempts;
 final  int totalTime;
 final  bool hasPassword;
 final  double minScore;
 final  bool beforeStart;
 final  bool optional;
 final  List<MyAttempt> myAttempts;

  factory MyQuizzInfoModel.fromJson(Map<String, dynamic> json) => MyQuizzInfoModel(
    quizzId: (json["quizzId"]!=null)?json["quizzId"]:-1,
    quizzName: (json["quizzName"]!=null)?json["quizzName"]:"",
    totalAttempts: (json["totalAttempts"]!=null)?json["totalAttempts"]:0,
    totalTime: (json["totalTime"]!=null)?json["totalTime"]:0,
    hasPassword: (json["hasPassword"]!=null)?json["hasPassword"]:false,
    minScore: (json["minScore"]!=null)?json["minScore"]:0.0,
    beforeStart: (json["beforeStart"]!=null)?json["beforeStart"]:false,
    optional: (json["optional"]!=null)?json["optional"]:false,
    myAttempts:(json["myAttempts"]!=null)? List<MyAttempt>.from(json["myAttempts"].map((x) => MyAttempt.fromJson(x))):[],

  );

  Map<String, dynamic> toJson() => {
    "quizzId": quizzId,
    "quizzName": quizzName,
    "totalAttempts": totalAttempts,
    "totalTime": totalTime,
    "hasPassword": hasPassword,
    "minScore": minScore,
    "beforeStart": beforeStart,
    "optional": optional,
    "myAttempts": List<dynamic>.from(myAttempts.map((x) => x.toJson())),
  };
}

class MyAttempt {
  MyAttempt({
  required this.quizzId,
  required this.date,
  required this.isDone,
  required this.didPass,
  required this.numberOfAnsweredQuestions,
  required this.totalDegree,
  required this.myAnswers,
  });

  int quizzId;
  DateTime date;
  bool isDone;
  bool didPass;
  int numberOfAnsweredQuestions;
  double totalDegree;
  List<dynamic> myAnswers;

  factory MyAttempt.fromJson(Map<String, dynamic> json) => MyAttempt(
    quizzId: (json["quizzId"]!=null)?json["quizzId"]:-1,
    date: DateTime.parse(json["date"]),
    isDone: (json["isDone"]!=null)?json["isDone"]:false,
    didPass: (json["didPass"]!=null)?json["didPass"]:false,
    numberOfAnsweredQuestions: (json["numberOfAnsweredQuestions"]!=null)?json["numberOfAnsweredQuestions"]:0,
    totalDegree: (json["totalDegree"]!=null)?json["totalDegree"]:0.0,
    myAnswers: List<dynamic>.from(json["myAnswers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "quizzId": quizzId,
    "date": date.toIso8601String(),
    "isDone": isDone,
    "didPass": didPass,
    "numberOfAnsweredQuestions": numberOfAnsweredQuestions,
    "totalDegree": totalDegree,
    "myAnswers": List<dynamic>.from(myAnswers.map((x) => x)),
  };
}
