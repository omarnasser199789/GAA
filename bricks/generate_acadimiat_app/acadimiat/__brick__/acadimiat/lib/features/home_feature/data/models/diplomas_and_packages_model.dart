// To parse this JSON data, do
//
//     final diplomasAndPackagesModel = diplomasAndPackagesModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/diplomas_and_packages_entity.dart';

List<DiplomasAndPackagesModel> diplomasAndPackagesModelFromJson(String str) => List<DiplomasAndPackagesModel>.from(json.decode(str).map((x) => DiplomasAndPackagesModel.fromJson(x)));

String diplomasAndPackagesModelToJson(List<DiplomasAndPackagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiplomasAndPackagesModel extends DiplomasAndPackagesEntity{
  DiplomasAndPackagesModel({
  required  this.id,
  required  this.apiId,
  required  this.image,
  required  this.courseName,
  required  this.trainerName,
  required  this.newPrice,
  required  this.oldPrice,
  required  this.fav,
  required this.numberOfCourses,
  required this.isCourse
  }):super(
    id:id,
    apiId:apiId,
    image:image,
    courseName:courseName,
    trainerName:trainerName,
    newPrice:newPrice,
    oldPrice:oldPrice,
    fav:fav,
    numberOfCourses:numberOfCourses,
    isCourse:isCourse,
  );

 final int id;
 final int apiId;
 final String image;
 final String courseName;
 final String trainerName;
 final double newPrice;
 final double oldPrice;
 final int fav;
 final int isCourse;
 final int numberOfCourses;

  factory DiplomasAndPackagesModel.fromJson(Map<String, dynamic> json) => DiplomasAndPackagesModel(
    id: json["id"],
    apiId: json["apiId"],
    image: json["image"],
    courseName: json["courseName"],
    trainerName: json["trainerName"],
    newPrice: json["newPrice"],
    oldPrice: json["oldPrice"],
    fav: json["fav"],
    isCourse: json["isCourse"],
    numberOfCourses: json["numberOfCourses"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "apiId": apiId,
    "image": image,
    "courseName": courseName,
    "trainerName": trainerName,
    "newPrice": newPrice,
    "oldPrice": oldPrice,
    "fav": fav,
    "isCourse": isCourse,
    "numberOfCourses": numberOfCourses,
  };
}
