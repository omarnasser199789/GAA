// To parse this JSON data, do
//
//     final consultanciesFromLocalDbModel = consultanciesFromLocalDbModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/consultancies_from_local_db_entity.dart';

List<ConsultanciesFromLocalDbModel> consultanciesFromLocalDbModelFromJson(String str) => List<ConsultanciesFromLocalDbModel>.from(json.decode(str).map((x) => ConsultanciesFromLocalDbModel.fromJson(x)));

String consultanciesFromLocalDbModelToJson(List<ConsultanciesFromLocalDbModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsultanciesFromLocalDbModel extends ConsultanciesFromLocalDbEntity {
  ConsultanciesFromLocalDbModel({
  required  this.apiId,
  required  this.image,
  required  this.name,
  required  this.trainerName,
  }):super(
    apiId:apiId,
    image:image,
    name:name,
    trainerName:trainerName,
  );

 final int apiId;
 final String image;
 final String name;
 final String trainerName;

  factory ConsultanciesFromLocalDbModel.fromJson(Map<String, dynamic> json) => ConsultanciesFromLocalDbModel(
    apiId: json["apiId"],
    image: json["image"],
    name: json["name"],
    trainerName: json["trainerName"],
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "name": name,
    "trainerName": trainerName,
  };
}
