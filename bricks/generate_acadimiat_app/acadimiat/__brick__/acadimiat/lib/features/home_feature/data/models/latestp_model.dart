import 'dart:convert';
import '../../domain/entities/latestp_entity.dart';

List<LatestPModel> latestpModelFromJson(String str) {
  final parsed = json.decode(str);
  return List<LatestPModel>.from(parsed.map((x) => LatestPModel.fromJson(x)))
      .where((model) => model.price < 700).toList();
}

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

final  int id;
final  String header;
final  bool authorized;
final  bool discount;
final  String image;
final  String squareImage;
final  String courseLink;
final  String trainer;
final  int numberOfCourses;
final  int categoryId;
final  double price;
final  bool isCourse;
final  double newPrice;
final  String appleId;
final  String googleId;

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

}
