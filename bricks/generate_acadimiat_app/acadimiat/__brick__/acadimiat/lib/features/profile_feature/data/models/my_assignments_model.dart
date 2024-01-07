import 'dart:convert';

import '../../domain/entities/my_assignments_entity.dart';


List<MyAssignmentsModel> myAssignmentsFromJson(String str) =>
    List<MyAssignmentsModel>.from(
        json.decode(str).map((x) => MyAssignmentsModel.fromJson(x)));

String myAssignmentsToJson(List<MyAssignmentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyAssignmentsModel extends MyAssignmentsEntity {
  MyAssignmentsModel({
    required this.assignmentId,
    required this.assignment,
    required this.courseName,
    required this.courseId,
    required this.isAccepted,
    required this.allAccepted,
    required this.allDeclined,
    required this.attempts,
  }) : super(
            assignmentId: assignmentId,
            assignment: assignment,
            courseName: courseName,
            courseId: courseId,
            isAccepted: isAccepted,
            allAccepted: allAccepted,
            allDeclined: allDeclined,
            attempts: attempts);

 final int assignmentId;
 final String assignment;
 final String courseName;
 final int courseId;
 final bool isAccepted;
 final int allAccepted;
 final int allDeclined;
 final List<Attempt> attempts;

  factory MyAssignmentsModel.fromJson(Map<String, dynamic> json) => MyAssignmentsModel(
        assignmentId: json["assignmentId"],
        assignment: json["assignment"],
        courseName: json["courseName"],
        courseId: json["courseId"],
        isAccepted: json["isAccepted"],
        allAccepted: json["allAccepted"],
        allDeclined: json["allDeclined"],
        attempts: List<Attempt>.from(
            json["attempts"].map((x) => Attempt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assignmentId": assignmentId,
        "assignment": assignment,
        "courseName": courseName,
        "courseId": courseId,
        "isAccepted": isAccepted,
        "allAccepted": allAccepted,
        "allDeclined": allDeclined,
        "attempts": List<dynamic>.from(attempts.map((x) => x.toJson())),
      };
}

class Attempt {
  Attempt({
    required this.attemptId,
    required this.date,
    required this.file,
    required this.fileBack,
    required this.evaluation,
    required this.isAccepted,
  });

  int attemptId;
  DateTime date;
  String file;
  dynamic fileBack;
  dynamic evaluation;
  bool isAccepted;

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        attemptId: json["attemptId"],
        date: DateTime.parse(json["date"]),
        file: json["file"],
        fileBack: json["fileBack"],
        evaluation: json["evaluation"],
        isAccepted: json["isAccepted"],
      );

  Map<String, dynamic> toJson() => {
        "attemptId": attemptId,
        "date": date.toIso8601String(),
        "file": file,
        "fileBack": fileBack,
        "evaluation": evaluation,
        "isAccepted": isAccepted,
      };
}
