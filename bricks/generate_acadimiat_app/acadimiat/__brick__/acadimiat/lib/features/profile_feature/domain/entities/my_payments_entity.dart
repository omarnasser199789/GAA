import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MyPaymentEntity extends Equatable {
  final int orderId;
  final DateTime orderDate;
  final String courseName;
  final String packageName;
  final double price;
  final dynamic orignalPrice;

  const MyPaymentEntity({
    required this.orderDate,
    required this.orderId,
    required this.courseName,
    required this.packageName,
    required this.price,
    required this.orignalPrice,
  });

  @override
  List<Object> get props =>
      [orderDate, orderId, courseName, packageName, price, orignalPrice];
}
