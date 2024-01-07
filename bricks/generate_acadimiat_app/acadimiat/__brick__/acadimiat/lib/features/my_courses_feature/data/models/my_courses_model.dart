import 'dart:convert';
import '../../domain/entities/my_courses_entity.dart';

List<MyCoursesModel> myCoursesModelFromJson(String str) => List<MyCoursesModel>.from(json.decode(str).map((x) => MyCoursesModel.fromJson(x)));

String myCoursesModelToJson(List<MyCoursesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyCoursesModel  extends MyCoursesEntity{
  MyCoursesModel({
  required this.id,
  required this.header,
  required this.authorized,
  required this.image,
  required this.courseLink,
  required this.trainer,
  required this.percent,
  required this.total,
  required this.isCourse,
  required this.hasBeforeQuizz,
  }):super(id: id,percent: percent,header: header,authorized: authorized,image: image,courseLink: courseLink,
  trainer: trainer,total: total,isCourse: isCourse,hasBeforeQuizz: hasBeforeQuizz);

 final int id;
 final String header;
 final bool authorized;
 final String image;
 final String courseLink;
 final String trainer;
 final int percent;
 final double total;
 final bool isCourse;
 final bool hasBeforeQuizz;

  factory MyCoursesModel.fromJson(Map<String, dynamic> json) => MyCoursesModel(
    id: json["id"],
    header: (json["header"]!=null)?json["header"]:"",
    authorized:(json["authorized"]==1||json["authorized"]==0)? (json["authorized"]==1)?true:false: json["authorized"],
    image: (json["image"]!=null)?json["image"]:"",
    courseLink: (json["courseLink"]!=null)?json["courseLink"]:"",
    trainer: (json["trainer"]!=null)?json["trainer"]:"",
    percent: json["percent"],
    total: json["total"].toDouble(),
    isCourse:(json["isCourse"]==1||json["isCourse"]==0)? (json["isCourse"]==1)?true:false: json["isCourse"],
    hasBeforeQuizz:(json["hasBeforeQuizz"]==1||json["hasBeforeQuizz"]==0)? (json["hasBeforeQuizz"]==1)?true:false: json["hasBeforeQuizz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "header": header,
    "authorized": authorized,
    "image": image,
    "courseLink": courseLink,
    "trainer": trainer,
    "percent": percent,
    "total": total,
    "isCourse": isCourse,
    "hasBeforeQuizz": hasBeforeQuizz,
  };
}
