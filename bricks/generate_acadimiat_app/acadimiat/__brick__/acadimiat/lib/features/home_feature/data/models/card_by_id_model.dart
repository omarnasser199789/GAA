
import 'dart:convert';

import '../../domain/entities/card_by_id_entity.dart';

CardByIdModel cardByIdModelFromJson(String str) => CardByIdModel.fromJson(json.decode(str));

String cardByIdModelToJson(CardByIdModel data) => json.encode(data.toJson());

class CardByIdModel  extends CardByIdEntity{
  CardByIdModel({
   required this.id,
   required this.courseName,
   required this.appleId,
   required this.googleId,
   required this.trainerName,
   required this.courseDescription,
   required this.mainPrice,
   required this.currentPrice,
   required this.courseLink,
   required this.courseKeywords,
   required this.courseCover,
   required this.courseVideo,
   required this.courseCertificateSample,
   required this.numberOfUnites,
   required this.numberOfLectures,
   required this.videosLength,
   required this.trainers,
   required this.coursePrices,
   required this.courseUnits,
   required this.courseInfo,
   required this.quizz,
  }):super(id:id,courseName: courseName,trainerName: trainerName,courseDescription: courseDescription,mainPrice: mainPrice,
  coursePrices: coursePrices,courseLink: courseLink,courseKeywords: courseKeywords,courseCover: courseCover,
  courseVideo: courseVideo,courseCertificateSample: courseCertificateSample,numberOfLectures: numberOfLectures,
    videosLength:videosLength,trainers: trainers,currentPrice: coursePrices,courseUnits: courseUnits,courseInfo:courseInfo,
      numberOfUnites:numberOfUnites ,quizz: quizz,appleId: appleId,googleId: googleId
  );

 final int id;
 final String courseName;
 final String appleId;
 final String googleId;
 final String trainerName;
 final String courseDescription;
 final double mainPrice;
 final double currentPrice;
 final dynamic courseLink;
 final dynamic courseKeywords;
 final String courseCover;
 final String courseVideo;
 final String courseCertificateSample;
 final int numberOfUnites;
 final int numberOfLectures;
 final int videosLength;
 final List<Trainer> trainers;
 final dynamic coursePrices;
 final List<CourseUnit> courseUnits;
 final List<CourseInfo> courseInfo;
 final dynamic quizz;

  factory CardByIdModel.fromJson(Map<String, dynamic> json) => CardByIdModel(
    id: json["id"],
    courseName: (json["courseName"]!=null)?json["courseName"]:"",
    appleId: (json["appleId"]!=null)?json["appleId"]:"",
    googleId: (json["googleId"]!=null)?json["googleId"]:"",
    trainerName: (json["trainerName"]!=null)?json["trainerName"]:"",
    courseDescription: (json["courseDescription"]!=null)?json["courseDescription"]:"",
    mainPrice:( json["mainPrice"]!=null)? json["mainPrice"]:0.0,
    currentPrice: (json["currentPrice"]!=null)?json["currentPrice"]:0.0,
    courseLink: json["courseLink"],
    courseKeywords: json["courseKeywords"],
    courseCover: (json["courseCover"]!=null)?json["courseCover"]:"",
    courseVideo: (json["courseVideo"]!=null)?json["courseVideo"]:"",
    courseCertificateSample: (json["courseCertificateSample"]!=null)?json["courseCertificateSample"]:"",
    numberOfUnites: json["numberOfUnites"],
    numberOfLectures: json["numberOfLectures"],
    videosLength: json["videosLength"],
    trainers: List<Trainer>.from(json["trainers"].map((x) => Trainer.fromJson(x))),
    coursePrices: (json["coursePrices"]!=null)?json["coursePrices"]:0.0,
    courseUnits: List<CourseUnit>.from(json["courseUnits"].map((x) => CourseUnit.fromJson(x))),
    courseInfo: List<CourseInfo>.from(json["courseInfo"].map((x) => CourseInfo.fromJson(x))),
    quizz: json["quizz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseName": courseName,
    "appleId": appleId,
    "googleId": googleId,
    "trainerName": trainerName,
    "courseDescription": courseDescription,
    "mainPrice": mainPrice,
    "currentPrice": currentPrice,
    "courseLink": courseLink,
    "courseKeywords": courseKeywords,
    "courseCover": courseCover,
    "courseVideo": courseVideo,
    "courseCertificateSample": courseCertificateSample,
    "numberOfUnites": numberOfUnites,
    "numberOfLectures": numberOfLectures,
    "videosLength": videosLength,
    "trainers": List<dynamic>.from(trainers.map((x) => x.toJson())),
    "coursePrices": coursePrices,
    "courseUnits": List<dynamic>.from(courseUnits.map((x) => x.toJson())),
    "courseInfo": List<dynamic>.from(courseInfo.map((x) => x.toJson())),
    "quizz": quizz,
  };
}

class CourseInfo {
  CourseInfo({
  required this.header,
  required this.body,
  required this.videoLink,
  });

  String header;
  String body;
  String videoLink;

  factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
    header: (json["header"]!=null)?json["header"]:"",
    body: (json["body"]!=null)?json["body"]:"",
    videoLink: (json["videoLink"]!=null)?json["videoLink"]:"",
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "body": body,
    "videoLink": videoLink,
  };
}

class CourseUnit {
  CourseUnit({
  required this.id,
  required this.unitName,
  required this.unitDesc,
  // required this.unitBanner,
  required this.materials,
  required this.quizz,
  });

  dynamic id;
  String unitName;
  String unitDesc;
  // String unitBanner;
  List<Material> materials;
  dynamic quizz;

  factory CourseUnit.fromJson(Map<String, dynamic> json) => CourseUnit(
    id: json["id"],
    unitName: (json["unitName"]!=null)?json["unitName"]:"",
    unitDesc: (json["unitDesc"]!=null)?json["unitDesc"]:"",
    // unitBanner:json["unitBanner"],
    materials: List<Material>.from(json["materials"].map((x) => Material.fromJson(x))),
    quizz: json["quizz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unitName": unitName,
    "unitDesc": unitDesc,
    // "unitBanner": unitBanner,
    "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
    "quizz": quizz,
  };
}

class Material {
  Material({
  required this.materialId,
  required this.materialName,
  required this.materialLink,
  required this.materialLength,
  required this.materialContents,
  });

  int materialId;
  String materialName;
  String materialLink;
  String materialLength;
  List<MaterialContent> materialContents;

  factory Material.fromJson(Map<String, dynamic> json) => Material(
    materialId: json["materialId"],
    materialName: (json["materialName"]!=null)?json["materialName"]:"",
    materialLink: (json["materialLink"]!=null)?json["materialLink"]:"",
    materialLength: (json["materialLength"]!=null)?json["materialLength"]:"",
    materialContents: List<MaterialContent>.from(json["materialContents"].map((x) => MaterialContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "materialId": materialId,
    "materialName": materialName,
    "materialLink": materialLink,
    "materialLength": materialLength,
    "materialContents": List<dynamic>.from(materialContents.map((x) => x.toJson())),
  };
}

class MaterialContent {
  MaterialContent({
   required this.contentType,
   required this.contentLength,
  });

  int contentType;
  double contentLength;

  factory MaterialContent.fromJson(Map<String, dynamic> json) => MaterialContent(
    contentType: json["contentType"],
    contentLength:(json["contentLength"]!=null)? json["contentLength"].toDouble():0.0,
  );

  Map<String, dynamic> toJson() => {
    "contentType": contentType,
    "contentLength": contentLength,
  };
}//

class Trainer {
  Trainer({
   required this.id,
   required this.trainerName,
   required this.trainerInfo,
   required this.trainerAvatar,
   required this.trainerMoreInfo,
   required this.trainerCourses,
  });

  int id;
  String trainerName;
  String trainerInfo;
  String trainerAvatar;
  String trainerMoreInfo;
  dynamic trainerCourses;

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
    id: json["id"],
    trainerName: (json["trainerName"]!=null)?json["trainerName"]:"",
    trainerInfo: (json["trainerInfo"]!=null)?json["trainerInfo"]:"",
    trainerAvatar: (json["trainerAvatar"]!=null)?json["trainerAvatar"]:"",
    trainerMoreInfo: (json["trainerMoreInfo"]!=null)?json["trainerMoreInfo"]:"",
    trainerCourses: json["trainerCourses"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trainerName": trainerName,
    "trainerInfo": trainerInfo,
    "trainerAvatar": trainerAvatar,
    "trainerMoreInfo": trainerMoreInfo,
    "trainerCourses": trainerCourses,
  };
}
