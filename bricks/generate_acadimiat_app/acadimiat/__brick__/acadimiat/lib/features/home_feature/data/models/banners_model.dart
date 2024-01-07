// To parse this JSON data, do
//
//     final bannersModel = bannersModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/banners_entity.dart';

List<BannersModel> bannersModelFromJson(String str) => List<BannersModel>.from(json.decode(str).map((x) => BannersModel.fromJson(x)));

String bannersModelToJson(List<BannersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannersModel extends BannersEntity{
  BannersModel({
    required this.id,
    this.courseId,
    this.packageId,
    this.consultancyId,
    this.articleId,
    required this.linkUrl,
    required this.type,
    required this.order,
    required this.header,
    required this.imageUrl,
    required this.videoUrl,
    required this.body,
    required this.subtitle,
  }):super(
    id:id,
    courseId:courseId,
    packageId:packageId,
    consultancyId:consultancyId,
    articleId:articleId,
    linkUrl:linkUrl,
    type:type,
    order:order,
    header:header,
    imageUrl:imageUrl,
    videoUrl:videoUrl,
    body:body,
    subtitle:subtitle,
  );

 final int id;
 final int? courseId;
 final dynamic packageId;
 final dynamic consultancyId;
 final dynamic articleId;
 final String linkUrl;
 final int type;
 final int order;
 final String header;
 final String imageUrl;
 final String videoUrl;
 final String body;
 final String subtitle;

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
    id: json["id"]??-1,
    courseId: json["courseId"]??-1,
    packageId: json["packageId"]??-1,
    consultancyId: json["consultancyId"]??-1,
    articleId: json["articleId"]??-1,
    linkUrl: json["linkUrl"]?? "",
    type: json["type"] ?? -1,
    order: json["order"] ?? -1,
    header: json["header"]??'',
    imageUrl: json["imageUrl"]??'',
    videoUrl: json["videoUrl"]??'',
    body: json["body"]??'',
    subtitle: json["subtitle"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseId": courseId,
    "packageId": packageId,
    "consultancyId": consultancyId,
    "articleId": articleId,
    "linkUrl": linkUrl,
    "type": type,
    "order": order,
    "header": header,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
    "body": body,
    "subtitle": subtitle,
  };
}
