// To parse this JSON data, do
//
//     final articleDetailsModel = articleDetailsModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/article_details_entity.dart';

ArticleDetailsModel articleDetailsModelFromJson(String str) => ArticleDetailsModel.fromJson(json.decode(str));

String articleDetailsModelToJson(ArticleDetailsModel data) => json.encode(data.toJson());

class ArticleDetailsModel extends ArticleDetailsEntity {
  ArticleDetailsModel({
  required this.id,
  required this.articleId,
  required this.userId,
  required this.header,
  required this.body,
  required this.date,
  required this.isPublished,
  required this.user,
  required this.article,
  }):super(
    id:id,
    articleId:articleId,
    userId:userId,
    header:header,
    body:body,
    date:date,
    isPublished:isPublished,
    user:user,
    article:article,
  );

  int id;
  int articleId;
  int userId;
  String header;
  String body;
  DateTime date;
  bool isPublished;
  dynamic user;
  dynamic article;

  factory ArticleDetailsModel.fromJson(Map<String, dynamic> json) => ArticleDetailsModel(
    id: json["id"],
    articleId: json["articleId"],
    userId: json["userId"],
    header: json["header"],
    body: json["body"],
    date: DateTime.parse(json["date"]),
    isPublished: json["isPublished"],
    user: json["user"],
    article: json["article"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "articleId": articleId,
    "userId": userId,
    "header": header,
    "body": body,
    "date": date.toIso8601String(),
    "isPublished": isPublished,
    "user": user,
    "article": article,
  };
}
