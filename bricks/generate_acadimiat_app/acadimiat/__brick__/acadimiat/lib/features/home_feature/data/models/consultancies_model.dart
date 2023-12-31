// To parse this JSON data, do
//
//     final consultanciesModel = consultanciesModelFromJson(jsonString);

import 'dart:convert';

import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';

List<ConsultanciesModel> consultanciesModelFromJson(String str) => List<ConsultanciesModel>.from(json.decode(str).map((x) => ConsultanciesModel.fromJson(x)));

String consultanciesModelToJson(List<ConsultanciesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsultanciesModel extends ConsultanciesEntity {
  ConsultanciesModel({
  required this.consultancyId,
  required this.name,
  required this.body,
  required this.image,
  required this.consultantName,
  required this.numberOfSessions,
  required this.subscriptionLimit,
  required this.typeOfSession,
  required this.squareImage,
  required this.consultantImage,
  required this.consultantInfo,
  required this.consultantId,
  required this.consultancyPrice,
  required this.timeLimit,
  required this.info,
  }):super(consultancyId:consultancyId,name: name,body: body,
  image: image,consultantName: consultantName,numberOfSessions: numberOfSessions,
    subscriptionLimit: subscriptionLimit,typeOfSession: typeOfSession,squareImage: squareImage,
    consultantImage: consultantImage,consultantInfo: consultantInfo,consultantId: consultancyId,
    consultancyPrice: consultancyPrice,timeLimit: timeLimit,info: info
  );

  int consultancyId;
  String name;
  dynamic body;
  String image;
  String consultantName;
  int numberOfSessions;
  dynamic subscriptionLimit;
  dynamic typeOfSession;
  dynamic squareImage;
  String consultantImage;
  String consultantInfo;
  int consultantId;
  double consultancyPrice;
  double timeLimit;
  dynamic info;

  factory ConsultanciesModel.fromJson(Map<String, dynamic> json) => ConsultanciesModel(
    consultancyId: json["consultancyId"],
    name: json["name"],
    body: json["body"],
    image: json["image"],
    consultantName: json["consultantName"],
    numberOfSessions: json["numberOfSessions"],
    subscriptionLimit: json["subscriptionLimit"],
    typeOfSession: json["typeOfSession"],
    squareImage: json["squareImage"],
    consultantImage: json["consultantImage"],
    consultantInfo: json["consultantInfo"],
    consultantId: json["consultantId"],
    consultancyPrice: json["consultancyPrice"],
    timeLimit: json["timeLimit"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "consultancyId": consultancyId,
    "name": name,
    "body": body,
    "image": image,
    "consultantName": consultantName,
    "numberOfSessions": numberOfSessions,
    "subscriptionLimit": subscriptionLimit,
    "typeOfSession": typeOfSession,
    "squareImage": squareImage,
    "consultantImage": consultantImage,
    "consultantInfo": consultantInfo,
    "consultantId": consultantId,
    "consultancyPrice": consultancyPrice,
    "timeLimit": timeLimit,
    "info": info,
  };
}
