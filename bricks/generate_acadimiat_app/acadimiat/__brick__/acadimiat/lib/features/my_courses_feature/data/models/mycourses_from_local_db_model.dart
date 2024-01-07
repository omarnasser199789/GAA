// To parse this JSON data, do
//
//     final myCoursesFromLocalDbModel = myCoursesFromLocalDbModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_courses_from_local_db_entity.dart';

List<MyCoursesFromLocalDbModel> myCoursesFromLocalDbModelFromJson(String str) => List<MyCoursesFromLocalDbModel>.from(json.decode(str).map((x) => MyCoursesFromLocalDbModel.fromJson(x)));

String myCoursesFromLocalDbModelToJson(List<MyCoursesFromLocalDbModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyCoursesFromLocalDbModel  extends MyCoursesFromLocalDbEntity{
  MyCoursesFromLocalDbModel({
  required  this.apiId,
  required  this.image,
  required  this.name,
  required  this.percent,
  }):super(
    apiId:apiId,
    image:image,
    name:name,
    percent:percent,
  );

 final int apiId;
 final String image;
 final String name;
 final int percent;

  factory MyCoursesFromLocalDbModel.fromJson(Map<String, dynamic> json) => MyCoursesFromLocalDbModel(
    apiId: json["apiId"],
    image: json["image"],
    name: json["name"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "name": name,
    "percent": percent,
  };
}
