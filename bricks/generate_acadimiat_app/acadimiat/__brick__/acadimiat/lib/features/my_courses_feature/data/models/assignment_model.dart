// To parse this JSON data, do
//
//     final AssignmentModel = AssignmentModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/assignment_entity.dart';

AssignmentModel AssignmentModelFromJson(String str) => AssignmentModel.fromJson(json.decode(str));

String AssignmentModelToJson(AssignmentModel data) => json.encode(data.toJson());

class AssignmentModel extends AssignmentEntity{
  AssignmentModel({
 required  this.assignmentId,
 required  this.assignment,
 required  this.body,
 required  this.courseName,
 required  this.courseId,
 required  this.isAccepted,
 required  this.canAttend,
 required  this.allAccepted,
 required  this.allPending,
 required  this.allDeclined,
 required  this.attempts,
  }):super(
    assignmentId:assignmentId,
    assignment:assignment,
    body:body,
    courseName:courseName,
    courseId:courseId,
    isAccepted:isAccepted,
    canAttend:canAttend,
    allAccepted:allAccepted,
    allPending:allPending,
    allDeclined:allDeclined,
    attempts:attempts,
  );

 final int assignmentId;
 final String assignment;
 final String body;
 final dynamic courseName;
 final int courseId;
 final bool isAccepted;
 final bool canAttend;
 final int allAccepted;
 final int allPending;
 final int allDeclined;
 final List<Attempt> attempts;

  factory AssignmentModel.fromJson(Map<String, dynamic> json) => AssignmentModel(
    assignmentId: json["assignmentId"],
    assignment: (json["assignment"]!=null)?json["assignment"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    courseName: (json["courseName"]!=null)?json["courseName"]:"",
    courseId: json["courseId"],
    isAccepted: json["isAccepted"],
    canAttend: json["canAttend"],
    allAccepted: json["allAccepted"],
    allPending: json["allPending"],
    allDeclined: json["allDeclined"],
    attempts: List<Attempt>.from(json["attempts"].map((x) => Attempt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assignmentId": assignmentId,
    "assignment": assignment,
    "body": body,
    "courseName": courseName,
    "courseId": courseId,
    "isAccepted": isAccepted,
    "canAttend": canAttend,
    "allAccepted": allAccepted,
    "allPending": allPending,
    "allDeclined": allDeclined,
    "attempts": List<dynamic>.from(attempts.map((x) => x.toJson())),
  };
}

class Attempt {
  Attempt({
 required  this.attemptId,
 required  this.date,
 required  this.status,
 required  this.file,
    required this.fileBack,
    required this.evaluation,
 required  this.isAccepted,
  });

  int attemptId;
  DateTime date;
  int status;
  String file;
  dynamic  fileBack;
  String  evaluation;
  bool isAccepted;

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
    attemptId: json["attemptId"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    file: (json["file"]!=null)?json["file"]:"",
    fileBack: (json["fileBack"]!=null)?json["fileBack"]:"",
    evaluation:(json["evaluation"]!=null)? json["evaluation"]:"",
    isAccepted: json["isAccepted"],
  );

  Map<String, dynamic> toJson() => {
    "attemptId": attemptId,
    "date": date.toIso8601String(),
    "status": status,
    "file": file,
    "fileBack": fileBack,
    "evaluation": evaluation,
    "isAccepted": isAccepted,
  };
}
