import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/activity_quizz_entity.dart';

ActivityQuizzModel activityQuizzModelFromJson(String str) =>
    ActivityQuizzModel.fromJson(json.decode(str));

String activityQuizzModelToJson(ActivityQuizzModel data) =>
    json.encode(data.toJson());

@immutable
class ActivityQuizzModel extends ActivityQuizzEntity {
  final String modelLectureId;
  final String modelUserId;
  final String modelCourseId;

  const ActivityQuizzModel({
    required this.modelLectureId,
    required this.modelUserId,
    required this.modelCourseId,
    required super.lectureId,
    required super.userId,
    required super.courseId,
  });

  factory ActivityQuizzModel.fromJson(Map<String, dynamic> json) =>
      ActivityQuizzModel(
        modelLectureId: json["lectureId"],
        modelUserId: json["userId"],
        modelCourseId: json["courseId"],
        lectureId: json["lectureId"],
        userId: json["userId"],
        courseId: json["courseId"],
      );

  Map<String, dynamic> toJson() => {
    "lectureId": modelLectureId,
    "userId": modelUserId,
    "courseId": modelCourseId,
  };
}
