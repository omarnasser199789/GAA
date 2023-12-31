// To parse this JSON data, do
//
//     final applyCouponModel = applyCouponModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/apply_coupon_entity.dart';

List<ApplyCouponModel> applyCouponModelFromJson(String str) => List<ApplyCouponModel>.from(json.decode(str).map((x) => ApplyCouponModel.fromJson(x)));

String applyCouponModelToJson(List<ApplyCouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApplyCouponModel extends ApplyCouponEntity{

  ApplyCouponModel({
  required  this.courseId,
  required  this.type,
  required  this.couponId,
  required  this.code,
  required  this.isActive,
  required  this.amount,
  required  this.status,
  }) : super(
    courseId:courseId,
    type:type,
    couponId:couponId,
    code:code,
    isActive:isActive,
    amount:amount,
    status:status,
  );

  int courseId;
  int type;
  int couponId;
  String code;
  bool isActive;
  double amount;
  String status;

  factory ApplyCouponModel.fromJson(Map<String, dynamic> json) => ApplyCouponModel(
    courseId: (json["courseId"]!=null)?json["courseId"]:-1,
    type: (json["type"]!=null)?json["type"]:-1,
    couponId: (json["couponId"]!=null)?json["couponId"]:-1,
    code: (json["code"]!=null)?json["code"]:"",
    isActive: (json["isActive"]!=null)?json["isActive"]:false,
    amount: (json["amount"]!=null)?json["amount"]:0.0,
    status: (json["status"]!=null)?json["status"]:"",
  );

  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "type": type,
    "couponId": couponId,
    "code": code,
    "isActive": isActive,
    "amount": amount,
    "status": status,
  };
}
