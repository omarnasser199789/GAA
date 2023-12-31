import 'dart:convert';

import '../../../../core/classes/category.dart';
import '../../domain/entities/latest_entity.dart';

List<LatestModel> latestModelFromJson(String str) {
  final parsed = json.decode(str);
  return List<LatestModel>.from(parsed.map((x) => LatestModel.fromJson(x)))
      .where((model) =>
  // model.appleId.isNotEmpty &&
      model.price < 700).toList();
}

class LatestModel extends LatestEntity{
  LatestModel({
  required  this.id,
  required  this.header,
  required  this.authorized,
  required  this.discount,
  required  this.image,
  required  this.squareImage,
  required  this.courseLink,
  required  this.trainer,
  required  this.numberOfCourses,
  required  this.categories,
  required  this.price,
  required  this.isCourse,
  required  this.newPrice,
    required this.appleId,
    required this.googleId
  }):super(id: id,header: header,authorized: authorized,discount: discount,image: image,squareImage: squareImage
      ,courseLink: courseLink,trainer: trainer,numberOfCourses: numberOfCourses,categories: categories,price: price,
  isCourse: isCourse,newPrice: newPrice);

  int id;
  String header;
  bool authorized;
  bool discount;
  String image;
  String squareImage;
  String courseLink;
  String trainer;
  dynamic numberOfCourses;
  List<Category> categories;
  double price;
  dynamic isCourse;
  dynamic newPrice;
  String appleId;
  String googleId;

  factory LatestModel.fromJson(Map<String, dynamic> json) => LatestModel(
    id: json["id"] ?? -1,
    header:( json["header"]!=null)? json["header"]:"",
    authorized: json["authorized"],
    discount: json["discount"],
    image: (json["image"]!=null)?json["image"]:"",
    squareImage: (json["squareImage"]!=null)? json["squareImage"]:"",
    courseLink: (json["courseLink"]!=null)?json["courseLink"]:"",
    trainer: (json["trainer"]!=null)?json["trainer"]:"",
    numberOfCourses: json["numberOfCourses"],
    categories:(json["categories"]!=null)? List<Category>.from(json["categories"].map((x) => Category.fromJson(x))):[],
    price: json["price"],
    isCourse: json["isCourse"],
    newPrice: (json["newPrice"]!=null)?json["newPrice"]:0.0,
    appleId: (json["appleId"]!=null)?json["appleId"]:"",
    googleId: (json["googleId"]!=null)?json["googleId"]:"",
  );

}
