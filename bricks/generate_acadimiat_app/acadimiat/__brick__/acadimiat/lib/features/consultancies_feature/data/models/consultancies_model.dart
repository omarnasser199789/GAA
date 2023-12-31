// To parse this JSON data, do
//
//     final myConsultanciesModel = myConsultanciesModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_consultancies_entity.dart';

List<MyConsultanciesModel> myConsultanciesModelFromJson(String str) => List<MyConsultanciesModel>.from(json.decode(str).map((x) => MyConsultanciesModel.fromJson(x)));

String myConsultanciesModelToJson(List<MyConsultanciesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyConsultanciesModel  extends MyConsultanciesEntity{
  MyConsultanciesModel({
  required this.id,
  required this.consultancy,
  required this.consultancyImage,
  required this.consultant,
  required this.email,
  required this.phone,
  required this.date,
  required this.numberOfSessions,
  }):super(
    id:id,
    consultancy:consultancy,
    consultancyImage:consultancyImage,
    consultant:consultant,
    email:email,
    phone:phone,
    date:date,
    numberOfSessions:numberOfSessions,
  );

  int id;
  String consultancy;
  String consultancyImage;
  String consultant;
  String email;
  String phone;
  DateTime date;
  int numberOfSessions;

  factory MyConsultanciesModel.fromJson(Map<String, dynamic> json) => MyConsultanciesModel(
    id: json["id"],
    consultancy:( json["consultancy"]!=null)? json["consultancy"]:"",
    consultancyImage: (json["consultancyImage"]!=null)?json["consultancyImage"]:"",
    consultant: json["consultant"],
    email: json["email"],
    phone: (json["phone"]!=null)?json["phone"]:"",
    date: DateTime.parse(json["date"]),
    numberOfSessions: json["numberOfSessions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "consultancy": consultancy,
    "consultancyImage": consultancyImage,
    "consultant": consultant,
    "email": email,
    "phone": phone,
    "date": date.toIso8601String(),
    "numberOfSessions": numberOfSessions,
  };
}
