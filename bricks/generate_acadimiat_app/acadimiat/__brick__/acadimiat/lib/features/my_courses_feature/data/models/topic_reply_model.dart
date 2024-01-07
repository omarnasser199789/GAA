// To parse this JSON data, do
//
//     final topicReplyModel = topicReplyModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/topic_reply_entity.dart';

TopicReplyModel topicReplyModelFromJson(String str) => TopicReplyModel.fromJson(json.decode(str));

String topicReplyModelToJson(TopicReplyModel data) => json.encode(data.toJson());

class TopicReplyModel extends TopicReplyEntity {
  TopicReplyModel({
  required this.id,
  required this.topicId,
  required this.userId,
  required this.reply,
  required this.attachment,
  required this.date,
  required this.user,
  required this.topic,
  }):super(
    id:id,
    topicId:topicId,
    userId:userId,
    reply:reply,
    attachment:attachment,
    date:date,
    user:user,
    topic:topic,
  );

 final int id;
 final int topicId;
 final int userId;
 final String reply;
 final String attachment;
 final DateTime date;
 final dynamic user;
 final dynamic topic;

  factory TopicReplyModel.fromJson(Map<String, dynamic> json) => TopicReplyModel(
    id: json["id"],
    topicId: json["topicId"],
    userId: json["userId"],
    reply: json["reply"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
    user: json["user"],
    topic: json["topic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicId": topicId,
    "userId": userId,
    "reply": reply,
    "attachment": attachment,
    "date": date.toIso8601String(),
    "user": user,
    "topic": topic,
  };
}
