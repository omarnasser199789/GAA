// To parse this JSON data, do
//
//     final categoriesFromLocalDbModel = categoriesFromLocalDbModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/Categories_from_local_db_entity.dart';

List<CategoriesFromLocalDbModel> categoriesFromLocalDbModelFromJson(String str) => List<CategoriesFromLocalDbModel>.from(json.decode(str).map((x) => CategoriesFromLocalDbModel.fromJson(x)));

String categoriesFromLocalDbModelToJson(List<CategoriesFromLocalDbModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesFromLocalDbModel  extends CategoriesFromLocalDBEntity{
  CategoriesFromLocalDbModel({
  required  this.categoryId,
  required  this.image,
  required  this.name,
  required  this.numberOfCourses,
  }):super(
    categoryId:categoryId,
    image:image,
    name:name,
    numberOfCourses:numberOfCourses,
  );

 final int categoryId;
 final String image;
 final String name;
 final int numberOfCourses;

  factory CategoriesFromLocalDbModel.fromJson(Map<String, dynamic> json) => CategoriesFromLocalDbModel(
    categoryId: json["categoryId"],
    image: json["image"],
    name: json["name"],
    numberOfCourses: json["numberOfCourses"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "image": image,
    "name": name,
    "numberOfCourses": numberOfCourses,
  };
}
