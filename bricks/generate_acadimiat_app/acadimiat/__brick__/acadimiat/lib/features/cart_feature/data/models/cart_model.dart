// To parse this JSON data, do
//
//     final CartModel = CartModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/files_entity.dart';

CartModel CartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String CartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel  extends CartEntity{
  CartModel({
   required this.carts,
  }):super(
      carts:carts
  );

  List<Cart> carts;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carts": List<dynamic>.from(carts.map((x) => x.toJson())),
  };
}

class Cart {
  Cart({
  required  this.id,

  required  this.apiId,
  required  this.productType,
  required  this.name,
  required  this.image,
  required  this.trainer,
  required  this.newPrice,
  required  this.oldPrice,
  required  this.fav,
  });

  int id;

  int apiId;
  int productType;
  String name;
  String image;
  String trainer;
  double newPrice;
  double oldPrice;
  int fav;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(

    id: json["id"],
    productType: json["productType"],
    apiId: json["apiID"],
    name: json["name"],
    image: (json["image"]!=null)?json["image"]:"",
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
