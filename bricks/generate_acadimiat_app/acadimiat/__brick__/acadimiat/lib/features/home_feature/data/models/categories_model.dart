// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/categories_entity.dart';

List<CategoriesModel> categoriesModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel  extends CategoriesEntity  {
  CategoriesModel({
  required  this.categoryId,
  required  this.categoryName,
  required  this.categoryCourses,
  }):super(
    categoryId:categoryId,
    categoryName:categoryName,
    categoryCourses:categoryCourses,
  );

 final int categoryId;
 final String categoryName;
 final int categoryCourses;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    categoryCourses: json["categoryCourses"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "categoryCourses": categoryCourses,
  };
}
