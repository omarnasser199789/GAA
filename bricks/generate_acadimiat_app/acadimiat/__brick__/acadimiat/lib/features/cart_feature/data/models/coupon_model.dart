
import 'dart:convert';

List<CouponModel> couponModelFromJson(String str) => List<CouponModel>.from(json.decode(str).map((x) => CouponModel.fromJson(x)));

String couponModelToJson(List<CouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CouponModel {
  CouponModel({
  required  this.type,
  required  this.productId,
  });

  int type;
  int productId;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    type: json["type"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "productId": productId,
  };
}
