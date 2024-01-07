import 'dart:convert';

import '../../domain/entities/search_entity.dart';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel extends SearchEntity {
  SearchModel({
  required  this.id,
  required  this.header,
  required  this.authorized,
  required  this.discount,
  required  this.image,
  required  this.squareImage,
  required  this.courseLink,
  required  this.trainer,
  required  this.numberOfCourses,
  required  this.featured,
  required  this.fromDate,
  required  this.toDate,
  required  this.categoryId,
  required  this.price,
  required  this.isCourse,
  required  this.newPrice,
  required  this.discountPercentage,
  required  this.category,
  required  this.duration,
  required  this.courseDate,
  }):super(
    id:id,
    header:header,
    authorized:authorized,
    discount:discount,
    image:image,
    squareImage:squareImage,
    courseLink:courseLink,
    trainer:trainer,
    numberOfCourses:numberOfCourses,
    featured:featured,
    fromDate:fromDate,
    toDate:toDate,
    categoryId:categoryId,
    price:price,
    isCourse:isCourse,
    newPrice:newPrice,
    discountPercentage:discountPercentage,
    category:category,
    duration:duration,
    courseDate:courseDate,
  );

 final int id;
 final String header;
 final bool authorized;
 final bool discount;
 final String image;
 final String squareImage;
 final String courseLink;
 final String trainer;
 final int numberOfCourses;
 final dynamic featured;
 final dynamic fromDate;
 final dynamic toDate;
 final int categoryId;
 final double price;
 final dynamic isCourse;
 final double newPrice;
 final int discountPercentage;
 final String category;
 final dynamic duration;
 final dynamic courseDate;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    id: (json["id"]!=null)?json["id"]:-1,
    header: (json["header"]!=null)?json["header"]:"",
    authorized:( json["authorized"]!=null)? json["authorized"]:false,
    discount: (json["discount"]!=null)?json["discount"]:false,
    image: (json["image"]!=null)?json["image"]:"",
    squareImage: (json["squareImage"]!=null)?json["squareImage"]:"",
    courseLink: (json["courseLink"]!=null)?json["courseLink"]:"",
    trainer: (json["trainer"]!=null)?json["trainer"]:"",
    numberOfCourses: (json["numberOfCourses"]!=null)?json["numberOfCourses"]:0,
    featured: json["featured"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    categoryId: (json["categoryId"]!=null)? json["categoryId"]:-1,
    price: (json["price"]!=null)?json["price"]:0.0,
    isCourse: json["isCourse"] ,
    newPrice:(json["newPrice"]!=null)?json["newPrice"]:0.0,
    discountPercentage: (json["discountPercentage"]!=null)?json["discountPercentage"]:0,
    category:  (json["category"]!=null)?json["category"]:"",
    duration: json["duration"],
    courseDate: json["courseDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "header": header,
    "authorized": authorized,
    "discount": discount,
    "image": image,
    "squareImage": squareImage,
    "courseLink": courseLink,
    "trainer": trainer,
    "numberOfCourses":  numberOfCourses,
    "featured": featured,
    "fromDate": fromDate,
    "toDate": toDate,
    "categoryId":  categoryId,
    "price": price,
    "isCourse": isCourse == null ? null : isCourse,
    "newPrice":  newPrice,
    "discountPercentage":  discountPercentage,
    "category":  category,
    "duration": duration,
    "courseDate": courseDate,
  };
}
