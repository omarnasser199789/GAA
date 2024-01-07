// To parse this JSON data, do
//
//     final myCertificatesModel = myCertificatesModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/my_certificates_entity.dart';

List<MyCertificatesModel> myCertificatesModelFromJson(String str) => List<MyCertificatesModel>.from(json.decode(str).map((x) => MyCertificatesModel.fromJson(x)));

String myCertificatesModelToJson(List<MyCertificatesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyCertificatesModel extends MyCertificatesEntity{
  MyCertificatesModel({
  required  this.id,
  required  this.courseId,
  required  this.course,
  required  this.userId,
  required  this.curriculaId,
  required  this.certificateName,
  required  this.image,
  required  this.courseName,
  required  this.curricula,
  required  this.certificates,
  }):super(
    id:id,
    courseId:courseId,
    course:course,
    userId:userId,
    curriculaId:curriculaId,
    certificateName:certificateName,
    image:image,
    courseName:courseName,
    curricula:curricula,
    certificates:certificates,
  );

 final int id;
 final int courseId;
 final dynamic course;
 final dynamic userId;
 final dynamic curriculaId;
 final String certificateName;
 final String image;
 final String courseName;
 final dynamic curricula;
 final dynamic certificates;

  factory MyCertificatesModel.fromJson(Map<String, dynamic> json) => MyCertificatesModel(
    id: json["id"],
    courseId: json["courseId"],
    course: json["course"],
    userId: json["userId"],
    curriculaId: json["curriculaId"],
    certificateName: json["certificateName"],
    image: json["image"],
    courseName: json["courseName"],
    curricula: json["curricula"],
    certificates: json["certificates"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseId": courseId,
    "course": course,
    "userId": userId,
    "curriculaId": curriculaId,
    "certificateName": certificateName,
    "image": image,
    "courseName": courseName,
    "curricula": curricula,
    "certificates": certificates,
  };
}
