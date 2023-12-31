// To parse this JSON data, do
//
//     final courseCaseStudyModel = courseCaseStudyModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/course_case_study_entity.dart';

CourseCaseStudyModel courseCaseStudyModelFromJson(String str) => CourseCaseStudyModel.fromJson(json.decode(str));

String courseCaseStudyModelToJson(CourseCaseStudyModel data) => json.encode(data.toJson());

class CourseCaseStudyModel extends CourseCaseStudyEntity {
  CourseCaseStudyModel({
  required  this.casestudyId,
  required  this.open,
  required  this.header,
  required  this.body,
    this.solution,
    this.attendanceTable,
  }):super(
    casestudyId:casestudyId,
    open:open,
    header:header,
    body:body,
    solution:solution,
    attendanceTable:attendanceTable,
  );

  int casestudyId;
  bool open;
  String header;
  String body;
  Solution  ? solution;
  AttendanceTable ? attendanceTable;

  factory CourseCaseStudyModel.fromJson(Map<String, dynamic> json) => CourseCaseStudyModel(
    casestudyId: json["casestudyId"]??-1,
    open: json["open"]??false,
    header: (json["header"]!=null)?json["header"].toString():"",
    body: (json["body"]!=null)?json["body"].toString():"",
    solution:(json["solution"]!=null)? Solution.fromJson(json["solution"]):Solution(solutionId: -1, answers: []),
    attendanceTable:(json["attendanceTable"]!=null)?AttendanceTable.fromJson(json["attendanceTable"]):null

  );

  Map<String, dynamic> toJson() => {
    "casestudyId": casestudyId,
    "open": open,
    "header": header,
    "body": body,
    "solution": solution!.toJson(),
    "attendanceTable": attendanceTable!.toJson(),
  };
}

class AttendanceTable {
  AttendanceTable({
  required  this.attendanceId,
  required  this.userId,
  required  this.traineeName,
    this.caseStudyId,
    this.date,
    this.answer,
  });

  dynamic attendanceId;
  dynamic userId;
  dynamic traineeName;
  int ? caseStudyId;
  DateTime ? date;
  AttendanceTableAnswer ? answer;

  factory AttendanceTable.fromJson(Map<String, dynamic> json) => AttendanceTable(
    attendanceId: (json["attendanceId"]!=null)?json["attendanceId"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    traineeName: (json["traineeName"]!=null)?json["traineeName"]:"",
    caseStudyId: json["caseStudyId"]??-1,
    date: (json["date"]!=null)?DateTime.parse(json["date"]):DateTime.now(),
    answer:(json["answer"]!=null)? AttendanceTableAnswer.fromJson(json["answer"]):AttendanceTableAnswer(
        answerId: -1, answer: null, correctId: -1, explanation: '', isCorrect: false, reply: null),

  );

  Map<String, dynamic> toJson() => {
    "attendanceId": attendanceId,
    "userId": userId,
    "traineeName": traineeName,
    "caseStudyId": caseStudyId,
    "date": date!.toIso8601String(),
    "answer": answer!.toJson(),
  };
}

class AttendanceTableAnswer {
  AttendanceTableAnswer({
  required  this.answerId,
  required  this.answer,
  required  this.correctId,
  required  this.explanation,
  required  this.isCorrect,
  required  this.reply,
  });

  int answerId;
  dynamic answer;
  int correctId;
  String explanation;
  bool isCorrect;
  dynamic reply;

  factory AttendanceTableAnswer.fromJson(Map<String, dynamic> json) => AttendanceTableAnswer(
    answerId: json["answerId"]??-1,
    answer: (json["answer"]!=null)?json["answer"].toString():"",
    correctId: json["correctId"]??-1,
    explanation:(json["explanation"]!=null)?json["explanation"]:"",
    isCorrect: json["isCorrect"]??false,
    reply: json["reply"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "answerId": answerId,
    "answer": answer,
    "correctId": correctId,
    "explanation": explanation,
    "isCorrect": isCorrect,
    "reply": reply,
  };
}

class Solution {
  Solution({
  required this.solutionId,
  required this.answers,
  });

  int solutionId;
  List<AnswerElement> answers;

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
    solutionId: json["solutionId"]??-1,
    answers:(json["answers"])!=null? List<AnswerElement>.from(json["answers"].map((x) => AnswerElement.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "solutionId": solutionId,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class AnswerElement {
  AnswerElement({
  required  this.answerId,
  required  this.answer,
  required  this.explain,
  });

  int answerId;
  String answer;
  String explain;

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
    answerId: json["answerId"]??-1,
    answer:(json["answer"]!=null)?json["answer"]:"",
    explain:(json["explain"]!=null)?json["explain"]:"",
  );

  Map<String, dynamic> toJson() => {
    "answerId": answerId,
    "answer": answer,
    "explain": explain,
  };
}
