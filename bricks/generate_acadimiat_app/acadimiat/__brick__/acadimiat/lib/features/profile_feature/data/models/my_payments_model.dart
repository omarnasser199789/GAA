// To parse this JSON data, do
//
//     final myPaymentsModel = myPaymentsModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_payments_entity.dart';


List<MyPaymentsModel> myPaymentsModelFromJson(String str) =>
    List<MyPaymentsModel>.from(
        json.decode(str).map((x) => MyPaymentsModel.fromJson(x)));

String myPaymentsModelToJson(List<MyPaymentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyPaymentsModel extends MyPaymentEntity {
  MyPaymentsModel({
    required this.orderId,
    required this.orderDate,
    required this.courseName,
    required this.packageName,
    required this.price,
    required this.orignalPrice,
  }) : super(
            orderDate: orderDate,
            orderId: orderId,
            courseName: courseName,
            packageName: packageName,
            price: price,
            orignalPrice: orignalPrice);

  int orderId;
  DateTime orderDate;
  String courseName;
  String packageName;
  double price;
  dynamic orignalPrice;

  factory MyPaymentsModel.fromJson(Map<String, dynamic> json) =>
      MyPaymentsModel(
        orderId: json["orderId"],
        orderDate: DateTime.parse(json["orderDate"]),
        courseName: json["courseName"],
        packageName: json["packageName"],
        price: json["price"],
        orignalPrice: json["orignalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDate": orderDate.toIso8601String(),
        "courseName": courseName,
        "packageName": packageName,
        "price": price,
        "orignalPrice": orignalPrice,
      };
}
