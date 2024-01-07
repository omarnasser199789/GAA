// To parse this JSON data, do
//
//     final myPlansModel = myPlansModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_plans_entity.dart';

List<MyPlansModel> myPlansModelFromJson(String str) => List<MyPlansModel>.from(json.decode(str).map((x) => MyPlansModel.fromJson(x)));

String myPlansModelToJson(List<MyPlansModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyPlansModel extends MyPlansEntity{
  MyPlansModel({
  required  this.planId,
  required  this.fromDate,
  required  this.toDate,
  required  this.progress,
  required  this.daysLeft,
  }):super(
    planId:planId,
    fromDate:fromDate,
    toDate:toDate,
    progress:progress,
    daysLeft:daysLeft,
  );

 final int planId;
 final DateTime fromDate;
 final DateTime toDate;
 final int progress;
 final int daysLeft;

  factory MyPlansModel.fromJson(Map<String, dynamic> json) => MyPlansModel(
    planId: json["planId"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    progress: json["progress"],
    daysLeft: json["daysLeft"],
  );

  Map<String, dynamic> toJson() => {
    "planId": planId,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "progress": progress,
    "daysLeft": daysLeft,
  };
}
