// To parse this JSON data, do
//
//     final activityLogicalModel = activityLogicalModelFromJson(jsonString);

import 'dart:convert';

import '../../../../core/classes/order.dart';
import '../../domain/entities/activity_logical_entity.dart';

ActivityLogicalModel activityLogicalModelFromJson(String str) => ActivityLogicalModel.fromJson(json.decode(str));

String activityLogicalModelToJson(ActivityLogicalModel data) => json.encode(data.toJson());

class ActivityLogicalModel extends ActiveLogicalEntity{
  ActivityLogicalModel({
  required  this.id,
  required  this.userId,
  required  this.email,
  required  this.questionId,
  required  this.isCorrect,
  required  this.reply,
  required  this.answer,
  required  this.date,
  required  this.orders,
  }):super(
    id:id,
    userId:userId,
    email:email,
    questionId:questionId,
    isCorrect:isCorrect,
    reply:reply,
    answer:answer,
    date:date,
    orders:orders,
  );

 final int id;
 final int userId;
 final dynamic email;
 final int questionId;
 final dynamic isCorrect;
 final dynamic reply;
 final dynamic answer;
 final DateTime date;
 final List<Order> orders;

  factory ActivityLogicalModel.fromJson(Map<String, dynamic> json) => ActivityLogicalModel(
    id: (json["id"]!=null)?json["id"]:-1,
    userId:( json["userId"]!=null)? json["userId"]:-1,
    email: json["email"],
    questionId: (json["questionId"]!=null)?json["questionId"]:-1,
    isCorrect: json["isCorrect"],
    reply: json["reply"],
    answer: json["answer"],
    date: DateTime.parse(json["date"]),
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "email": email,
    "questionId": questionId,
    "isCorrect": isCorrect,
    "reply": reply,
    "answer": answer,
    "date": date.toIso8601String(),
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

// class Order {
//   Order({
//   required  this.id,
//   required  this.sentenceId,
//   required  this.order,
//   required  this.correct,
//   });
//
//   int id;
//   int sentenceId;
//   int order;
//   int correct;
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//     id: json["id"],
//     sentenceId: json["sentenceId"],
//     order: (json["order"]!=null)?json["order"]:-1,
//     correct: (json["correct"]!=null)?json["correct"]:-1,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sentenceId": sentenceId,
//     "order": order,
//     "correct": correct,
//   };
// }
