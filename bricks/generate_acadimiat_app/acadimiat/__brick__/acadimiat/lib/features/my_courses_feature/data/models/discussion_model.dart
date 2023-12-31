// To parse this JSON data, do
//
//     final discussionModel = discussionModelFromJson(jsonString);

import 'dart:convert';

import 'package:acadmiat/features/my_courses_feature/domain/entities/discussion_entity.dart';

DiscussionModel discussionModelFromJson(String str) => DiscussionModel.fromJson(json.decode(str));

String discussionModelToJson(DiscussionModel data) => json.encode(data.toJson());

class DiscussionModel extends DiscussionEntity {
  DiscussionModel({
  required  this.discussionId,
  required  this.lectureId,
  required  this.timeline,
  }):super(
    discussionId: discussionId,
    lectureId: lectureId,
    timeline: timeline,
  );

  int discussionId;
  int lectureId;
  List<Timeline> timeline;

  factory DiscussionModel.fromJson(Map<String, dynamic> json) => DiscussionModel(
    discussionId: (json["discussionId"]!=null)?json["discussionId"]:-1,
    lectureId: (json["lectureId"]!=null)?json["lectureId"]:-1,
    timeline: List<Timeline>.from(json["timeline"].map((x) => Timeline.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "discussionId": discussionId,
    "lectureId": lectureId,
    "timeline": List<dynamic>.from(timeline.map((x) => x.toJson())),
  };
}

class Timeline {
  Timeline({
  required  this.id,
  required  this.discussionId,
  required  this.userId,
  required  this.username,
  required  this.useravatar,
  required  this.message,
  required  this.addedAt,
  required  this.isReply,
  required  this.orginialId,
    this.original,
    this.replies,
  });

  int id;
  int discussionId;
  int userId;
  String username;
  String useravatar;
  String message;
  DateTime addedAt;
  bool isReply;
  int orginialId;
  Timeline ? original;
  List<Timeline> ? replies;

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    id: (json["id"]!=null)?json["id"]:-1,
    discussionId: json["discussionId"] == null ? -1 : json["discussionId"],
    userId: json["userId"] == null ? -1 : json["userId"],
    username: json["username"] == null ? "" : json["username"],
    useravatar: json["useravatar"] == null ? "" : json["useravatar"],
    message: json["message"] == null ? "" : json["message"],
    addedAt: json["addedAt"] == null ? DateTime.now() : DateTime.parse(json["addedAt"]),
    isReply: json["isReply"],
    orginialId: json["orginialId"] == null ? -1 : json["orginialId"],
    original: json["original"] == null ? null : Timeline.fromJson(json["original"]),
    replies: json["replies"] == null ? null : List<Timeline>.from(json["replies"].map((x) => Timeline.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "discussionId": discussionId == null ? -1 : discussionId,
    "userId": userId == null ? -1 : userId,
    "username": username == null ? "" : username,
    "useravatar": useravatar == null ? "" : useravatar,
    "message": message == null ? "" : message,
    // "addedAt": addedAt == null ? null : DateTime.parse(json["addedAt"]),
    "isReply": isReply,
    "orginialId": orginialId == null ? -1 : orginialId,
    "original": original == null ? null : original!.toJson(),
    "replies": replies == null ? null : List<dynamic>.from(replies!.map((x) => x.toJson())),
  };
}
