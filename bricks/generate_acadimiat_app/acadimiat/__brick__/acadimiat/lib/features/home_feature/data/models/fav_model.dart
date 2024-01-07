// To parse this JSON data, do
//
//     final favModel = favModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/fav_entity.dart';

List<FavModel> favModelFromJson(String str) => List<FavModel>.from(json.decode(str).map((x) => FavModel.fromJson(x)));

String favModelToJson(List<FavModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavModel extends FavEntity  {
  FavModel({
    required this.id,
  required  this.apiId,
  required  this.productType,
  required  this.name,
  required  this.image,
  required  this.trainer,
  required  this.newPrice,
  required  this.oldPrice,
  required  this.fav,
  }):super(
    id:id,
    apiId:apiId,
    productType:productType,
    name:name,
    image:image,
    trainer:trainer,
    newPrice:newPrice,
    oldPrice:oldPrice,
    fav:fav,
  );

 final int  id;
 final int apiId;
 final int productType;
 final String name;
 final String image;
 final String trainer;
 final double newPrice;
 final double oldPrice;
 final int fav;

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
    id: json["id"],
    apiId: json["apiID"],
    productType: json["productType"],
    name: json["name"],
    image: json["image"],
    trainer: json["trainer"],
    newPrice: json["newPrice"],
    oldPrice: json["oldPrice"],
    fav: json["fav"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "apiID": apiId,
    "productType": productType,
    "name": name,
    "image": image,
    "trainer": trainer,
    "newPrice": newPrice,
    "oldPrice": oldPrice,
    "fav": fav,
  };
}
