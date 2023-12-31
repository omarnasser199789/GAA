import 'dart:convert';

import '../../domain/entities/my_quizzes_entity.dart';


List<MyQuizzesModel> myQuizzesListModelFromJson(String str) => List<MyQuizzesModel>.from(json.decode(str).map((x) => MyQuizzesModel.fromJson(x)));

String myQuizzesListModelToJson(List<MyQuizzesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyQuizzesModel extends MyQuizzesEntity{
  MyQuizzesModel({
  required this.quizzId,
  required this.quizzName,
  required this.courseName,
  required this.courseId,
  required this.progress,
  required this.mark,
  required this.isPassed,
  required this.date,
  }):super(quizzId: quizzId,courseId: courseId,quizzName: quizzName,courseName:courseName,
  progress: progress,mark: mark,isPassed: isPassed,date: date);

  int quizzId;
  String quizzName;
  String courseName;
  int courseId;
  double progress;
  double mark;
  bool isPassed;
  DateTime date;

  factory MyQuizzesModel.fromJson(Map<String, dynamic> json) => MyQuizzesModel(
    quizzId: json["quizzId"],
    quizzName: json["quizzName"],
    courseName: json["courseName"],
    courseId: json["courseId"],
    progress: json["progress"],
    mark: json["mark"],
    isPassed: json["isPassed"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "quizzId": quizzId,
    "quizzName": quizzName,
    "courseName": courseName,
    "courseId": courseId,
    "progress": progress,
    "mark": mark,
    "isPassed": isPassed,
    "date": date.toIso8601String(),
  };
}
