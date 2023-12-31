// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/counsultancy_entity.dart';

PackageModel packageModelFromJson(String str) => PackageModel.fromJson(json.decode(str));

String packageModelToJson(PackageModel data) => json.encode(data.toJson());

class PackageModel extends PackageEntity {
  PackageModel({
  required  this.packageId,
  required  this.packageName,
  required  this.packageImage,
  required  this.packagePrice,
  required  this.packageLink,
  required  this.courses,
  required  this.mainPrice,
  required  this.currentPrice,
  }):super(
    packageId:packageId,
    packageName:packageName,
    packageImage:packageImage,
    packagePrice:packagePrice,
    packageLink:packageLink,
    courses:courses,
    mainPrice:mainPrice,
    currentPrice:currentPrice,
  );

  int packageId;
  String packageName;
  String packageImage;
  double packagePrice;
  String packageLink;
  List<Course> courses;
  double mainPrice;
  double currentPrice;

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    packageId: json["packageId"],
    packageName: (json["packageName"]!=null)?json["packageName"]:"",
    packageImage: (json["packageImage"]!=null)?json["packageImage"]:"",
    packagePrice: json["packagePrice"],
    packageLink: (json["packageLink"]!=null)?json["packageLink"]:"",
    courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    mainPrice: json["mainPrice"],
    currentPrice: json["currentPrice"],
  );

  Map<String, dynamic> toJson() => {
    "packageId": packageId,
    "packageName": packageName,
    "packageImage": packageImage,
    "packagePrice": packagePrice,
    "packageLink": packageLink,
    "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    "mainPrice": mainPrice,
    "currentPrice": currentPrice,
  };
}

class Course {
  Course({
  required  this.id,
  required  this.courseName,
  required  this.trainerName,
  required  this.courseDescription,
  required  this.mainPrice,
  required  this.currentPrice,
  required  this.courseLink,
  required  this.courseKeywords,
  required  this.courseCover,
  required  this.courseVideo,
  required  this.courseCertificateSample,
  required  this.numberOfUnites,
  required  this.numberOfLectures,
  required  this.videosLength,
  required  this.trainers,
  required  this.coursePrices,
  required  this.courseUnits,
  required  this.courseInfo,
  required  this.quizz,
  });

  int id;
  String courseName;
  String trainerName;
  String courseDescription;
  double mainPrice;
  double currentPrice;
  dynamic courseLink;
  dynamic courseKeywords;
  String courseCover;
  String courseVideo;
  dynamic courseCertificateSample;
  int numberOfUnites;
  int numberOfLectures;
  int videosLength;
  List<Trainer> trainers;
  dynamic coursePrices;
  List<CourseUnit> courseUnits;
  List<CourseInfo> courseInfo;
  Quizz quizz;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    courseName: (json["courseName"]!=null)?json["courseName"]:"",
    trainerName: (json["trainerName"]!=null)?json["trainerName"]:"",
    courseDescription: (json["courseDescription"]!=null)?json["courseDescription"]:"",
    mainPrice: json["mainPrice"],
    currentPrice: json["currentPrice"],
    courseLink: json["courseLink"],
    courseKeywords: json["courseKeywords"],
    courseCover: (json["courseCover"]!=null)?json["courseCover"]:"",
    courseVideo: (json["courseVideo"]!=null)?json["courseVideo"]:"",
    courseCertificateSample: json["courseCertificateSample"],
    numberOfUnites: json["numberOfUnites"],
    numberOfLectures: json["numberOfLectures"],
    videosLength: json["videosLength"],
    trainers: List<Trainer>.from(json["trainers"].map((x) => Trainer.fromJson(x))),
    coursePrices: json["coursePrices"],
    courseUnits: List<CourseUnit>.from(json["courseUnits"].map((x) => CourseUnit.fromJson(x))),
    courseInfo: List<CourseInfo>.from(json["courseInfo"].map((x) => CourseInfo.fromJson(x))),
    quizz: (json["quizz"]!=null)? Quizz.fromJson(json["quizz"]):Quizz(quizzId: -1, quizzName: '', attempts: -1),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseName": courseName,
    "trainerName": trainerName,
    "courseDescription": courseDescription,
    "mainPrice": mainPrice,
    "currentPrice": currentPrice,
    "courseLink": courseLink,
    "courseKeywords": courseKeywords,
    "courseCover": courseCover,
    "courseVideo": courseVideo == null ? null : courseVideo,
    "courseCertificateSample": courseCertificateSample,
    "numberOfUnites": numberOfUnites,
    "numberOfLectures": numberOfLectures,
    "videosLength": videosLength,
    "trainers": List<dynamic>.from(trainers.map((x) => x.toJson())),
    "coursePrices": coursePrices,
    "courseUnits": List<dynamic>.from(courseUnits.map((x) => x.toJson())),
    "courseInfo": List<dynamic>.from(courseInfo.map((x) => x.toJson())),
    "quizz": quizz == null ? null : quizz.toJson(),
  };
}

class CourseInfo {
  CourseInfo({
  required  this.header,
  required  this.body,
  required  this.videoLink,
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
  required  this.id,
  required  this.unitName,
  required  this.unitDesc,
  required  this.unitBanner,
  required  this.materials,
  required  this.quizz,
  });

  dynamic id;
  String unitName;
  String unitDesc;
  String unitBanner;
  List<Material> materials;
  Quizz quizz;

  factory CourseUnit.fromJson(Map<String, dynamic> json) => CourseUnit(
    id: json["id"],
    unitName: (json["unitName"]!=null)?json["unitName"]:"",
    unitDesc: (json["unitDesc"]!=null)? json["unitDesc"]:"",
    unitBanner: (json["unitBanner"]!=null)?json["unitBanner"]:"",
    materials: (json["materials"]!=null)?List<Material>.from(json["materials"].map((x) => Material.fromJson(x))):[],
    quizz: (json["quizz"]!=null)? Quizz.fromJson(json["quizz"]):Quizz(quizzId: -1, quizzName: '', attempts: -1),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unitName": unitName,
    "unitDesc": unitDesc == null ? null : unitDesc,
    "unitBanner": unitBanner == null ? null : unitBanner,
    "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
    "quizz": quizz == null ? null : quizz.toJson(),
  };
}

class Material {
  Material({
  required  this.materialId,
  required  this.materialName,
  required  this.materialLink,
  required  this.materialLength,
  required  this.materialContents,
  });

  int materialId;
  String materialName;
  String materialLink;
  String materialLength;
  dynamic materialContents;

  factory Material.fromJson(Map<String, dynamic> json) => Material(
    materialId: json["materialId"],
    materialName: (json["materialName"]!=null)?json["materialName"]:"",
    materialLink: (json["materialLink"]!=null)?json["materialLink"]:"",
    materialLength: (json["materialLength"]!=null)?json["materialLength"]:"",
    materialContents: json["materialContents"],
  );

  Map<String, dynamic> toJson() => {
    "materialId": materialId,
    "materialName": materialName,
    "materialLink": materialLink == null ? null : materialLink,
    "materialLength": materialLength,
    "materialContents": materialContents,
  };
}

class Quizz {
  Quizz({
  required  this.quizzId,
  required  this.quizzName,
  required  this.attempts,
  });

  int quizzId;
  String quizzName;
  int attempts;

  factory Quizz.fromJson(Map<String, dynamic> json) => Quizz(
    quizzId: json["quizzId"],
    quizzName: (json["quizzName"]!=null)?json["quizzName"]:"",
    attempts: json["attempts"],
  );

  Map<String, dynamic> toJson() => {
    "quizzId": quizzId,
    "quizzName": quizzName,
    "attempts": attempts,
  };
}

class Trainer {
  Trainer({
  required  this.id,
  required  this.trainerName,
  required  this.trainerInfo,
  required  this.trainerAvatar,
  required  this.trainerMoreInfo,
  required  this.trainerCourses,
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
//