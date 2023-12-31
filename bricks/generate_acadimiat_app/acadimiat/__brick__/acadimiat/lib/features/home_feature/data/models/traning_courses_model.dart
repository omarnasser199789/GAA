// To parse this JSON data, do
//
//     final TrainingCoursesModel = TrainingCoursesModelFromJson(jsonString);

import 'dart:convert';
import '../../domain/entities/training_courses_entity.dart';

List<TrainingCoursesModel> TrainingCoursesModelFromJson(String str) => List<TrainingCoursesModel>.from(json.decode(str).map((x) => TrainingCoursesModel.fromJson(x)));

String TrainingCoursesModelToJson(List<TrainingCoursesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrainingCoursesModel extends TrainingCoursesEntity{
  TrainingCoursesModel({
    required  this.id,
    required  this.apiId,
    required  this.image,
    required  this.courseName,
    required  this.trainerName,
    required  this.newPrice,
    required  this.oldPrice,
    required  this.fav,

  }):super(
    id:id,
    apiId:apiId,
    image:image,
    courseName:courseName,
    trainerName:trainerName,
    newPrice:newPrice,
    oldPrice:oldPrice,
    fav:fav,

  );

  int id;
  int apiId;
  String image;
  String courseName;
  String trainerName;
  double newPrice;
  double oldPrice;
  int fav;


  factory TrainingCoursesModel.fromJson(Map<String, dynamic> json) => TrainingCoursesModel(
    id: json["id"],
    apiId: json["apiId"],
    image: json["image"],
    courseName: json["courseName"],
    trainerName: json["trainerName"],
    newPrice: json["newPrice"],
    oldPrice: json["oldPrice"],
    fav: json["fav"],

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

  };
}
