
import 'dart:convert';

import '../../domain/entities/latestp_entity.dart';

// List<LatestPModel> latestpModelFromJson(String str) =>
//     List<LatestPModel>.from(json.decode(str).map((x) => LatestPModel.fromJson(x)));

List<LatestPModel> latestpModelFromJson(String str) {
  final parsed = json.decode(str);
  return List<LatestPModel>.from(parsed.map((x) => LatestPModel.fromJson(x)))
      .where((model) =>
  // model.appleId.isNotEmpty &&
      model.price < 700)
      .toList();
}

// String latestpModelToJson(List<LatestPModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class LatestPModel extends LatestPEntity{
  LatestPModel({
    required this.id,
    required this.header,
    required this.authorized,
    required this.discount,
    required this.image,
    required this.squareImage,
    required this.courseLink,
    required this.trainer,
    required this.numberOfCourses,
    required this.categoryId,
    required this.price,
    required this.isCourse,
    required this.newPrice,
    required this.appleId,
    required this.googleId
  }):super(id: id,header: header,authorized: authorized,discount: discount,image: image,squareImage: squareImage,
  courseLink: courseLink,trainer: trainer,numberOfCourses: numberOfCourses,categoryId: categoryId,price: price,
      isCourse: isCourse,newPrice: newPrice,appleId: appleId,googleId: googleId);

  int id;
  String header;
  bool authorized;
  bool discount;
  String image;
  String squareImage;
  String courseLink;
  String trainer;
  int numberOfCourses;
  int categoryId;
  double price;
  bool isCourse;
  double newPrice;
  String appleId;
  String googleId;

  factory LatestPModel.fromJson(Map<String, dynamic> json) => LatestPModel(
    id: (json["id"]!=null)?json["id"]:-1,
    header: json["header"] ?? "",
    authorized: json["authorized"],
    discount: json["discount"],
    image: json["image"] ?? "",
    squareImage: json["squareImage"] ?? "",
    courseLink: json["courseLink"] ?? "",
    trainer: json["trainer"] ?? "",
    numberOfCourses: (json["numberOfCourses"]!=null)?json["numberOfCourses"]:-1,
    categoryId: ( json["categoryId"]!=null)? json["categoryId"]:-1,
    price: (json["price"]!=null)?json["price"]:0.0,
    isCourse: json["isCourse"],
    newPrice: ( json["newPrice"]!=null)? json["newPrice"]:0.0,
    appleId: (json["appleId"]!=null)?json["appleId"]:"",
    googleId: (json["googleId"]!=null)?json["googleId"]:"",
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "header": header,
  //   "authorized": authorized,
  //   "discount": discount,
  //   "image": image,
  //   "squareImage": squareImage,
  //   "courseLink": courseLink,
  //   "trainer": trainer,
  //   "numberOfCourses": numberOfCourses == null ? null : numberOfCourses,
  //   "categoryId": categoryId == null ? null : categoryId,
  //   "price": price,
  //   "isCourse": isCourse,
  //   "newPrice": newPrice == null ? null : newPrice,
  // };
}
