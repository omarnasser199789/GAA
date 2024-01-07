// To parse this JSON data, do
//
//     final ActivityDecisionModel = ActivityDecisionModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/activity_decision_entity.dart';

ActivityDecisionModel ActivityDecisionModelFromJson(String str) => ActivityDecisionModel.fromJson(json.decode(str));

String ActivityDecisionModelToJson(ActivityDecisionModel data) => json.encode(data.toJson());

class ActivityDecisionModel  extends ActivityDecisionEntity{
  ActivityDecisionModel({
  required  this.id,
  required  this.decisionId,
  required  this.repliedAt,
  required  this.userId,
  required  this.attendanceAt,
  required  this.opinion,
  required  this.comments,
  }):super(
    id:id,
    decisionId:decisionId,
    repliedAt:repliedAt,
    userId:userId,
    attendanceAt:attendanceAt,
    opinion:opinion,
    comments:comments,
  );

 final int id;
 final dynamic decisionId;
 final DateTime repliedAt;
 final int userId;
 final DateTime attendanceAt;
 final String opinion;
 final List<dynamic> comments;

  factory ActivityDecisionModel.fromJson(Map<String, dynamic> json) => ActivityDecisionModel(
    id: json["id"],
    decisionId: json["decisionId"],
    repliedAt: DateTime.parse(json["repliedAt"]),
    userId: json["userId"],
    attendanceAt: DateTime.parse(json["attendanceAt"]),
    opinion: json["opinion"],
    comments: List<dynamic>.from(json["comments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "decisionId": decisionId,
    "repliedAt": repliedAt.toIso8601String(),
    "userId": userId,
    "attendanceAt": attendanceAt.toIso8601String(),
    "opinion": opinion,
    "comments": List<dynamic>.from(comments.map((x) => x)),
  };
}
