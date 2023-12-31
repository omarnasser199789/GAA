// To parse this JSON data, do
//
//     final activityQuizzModel = activityQuizzModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/activity_quizz_entity.dart';

ActivityQuizzModel activityQuizzModelFromJson(String str) => ActivityQuizzModel.fromJson(json.decode(str));

String activityQuizzModelToJson(ActivityQuizzModel data) => json.encode(data.toJson());

class ActivityQuizzModel extends ActivityQuizzEntity{
  ActivityQuizzModel({
  required  this.lectureId,
  required  this.userId,
  required  this.courseId,
  }):super(
    lectureId:lectureId,
    userId:userId,
    courseId:courseId,
  );

  String lectureId;
  String userId;
  String courseId;

  factory ActivityQuizzModel.fromJson(Map<String, dynamic> json) => ActivityQuizzModel(
    lectureId: json["lectureId"],
    userId: json["userId"],
    courseId: json["courseId"],
  );

  Map<String, dynamic> toJson() => {
    "lectureId": lectureId,
    "userId": userId,
    "courseId": courseId,
  };
}
