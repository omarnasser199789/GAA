// This file contains a `LoginModel` class that represents a JSON serialization/deserialization model for
// user login data, and maps to the `LoginEntity` entity class defined in the domain layer.
//
// To parse JSON data into an instance of `LoginModel`, use the `loginModelFromJson` function.
// To encode an instance of `LoginModel` into a JSON string, use the `loginModelToJson` function.
import 'dart:convert';
import 'package:acadmiat/features/authentication_feature/domain/entities/login_entity.dart';

// The `loginModelFromJson` function parses the given JSON string into an instance of `LoginModel`.
LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// The `loginModelToJson` function encodes the given instance of `LoginModel` into a JSON string.
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// This class represents a JSON serialization/deserialization model for user login data,
// and extends the `LoginEntity` entity class defined in the domain layer.
class LoginModel extends LoginEntity {
  // The constructor takes in the required parameters for user login,
  // and calls the superclass constructor with the same parameters to initialize the fields.
  LoginModel({
    required  this.id,
    required  this.email,
    required  this.name,
    required  this.avatar,
    required  this.groupId,
    required  this.trainerId,
    required  this.userId,
    required  this.jwtToken,
    required this.myCourses,
    required  this.refreshToken,
  }) : super(
    id:id,
    email: email,
    name: name,
    avatar: avatar,
    groupId: groupId,
    trainerId: trainerId,
    userId: userId,
    jwtToken: jwtToken,
    myCourses:myCourses,
    refreshToken: refreshToken,
  );

  // Fields that represent the data associated with user login.
  String id;
  String email;
  String name;
  String avatar;
  String groupId;
  dynamic trainerId;
  String userId;
  String jwtToken;
  List<MyCourse> myCourses;
  String refreshToken;

  // The `fromJson` factory method creates an instance of `LoginModel` from a
  // `Map<String, dynamic>` object, assuming that the keys correspond to the field names.
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    avatar: (json["avatar"]!=null)?json["avatar"]:"",
    groupId: json["groupId"],
    trainerId:json["trainerId"],
    userId: json["userId"],
    jwtToken: json["jwtToken"],
    myCourses:(json["myCourses"]!=null)? List<MyCourse>.from(json["myCourses"].map((x) => MyCourse.fromJson(x))):[],
    refreshToken: json["refreshToken"],
  );

  // The `toJson` method converts the `LoginModel` instance to a `Map<String, dynamic>`
  // object, suitable for encoding as JSON. The keys correspond to the field names.
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "avatar": avatar,
    "groupId": groupId,
    "trainerId": trainerId,
    "userId": userId,
    "jwtToken": jwtToken,
    "myCourses": List<dynamic>.from(myCourses.map((x) => x.toJson())),
    "refreshToken": refreshToken,
  };
}

// This class represents a `MyCourse` entity, which contains information about a course that a user is enrolled in.
class MyCourse {
  // The `MyCourse` constructor takes in the required `courseId` and optional `courseName` parameters,
  // and initializes the corresponding fields.
  MyCourse({
    required this.courseId,
    this.courseName,
  });

  // Fields that represent the data associated with a `MyCourse` entity.
  int courseId;
  dynamic courseName;

  // The `fromJson` factory method creates an instance of `MyCourse` from a
  // `Map<String, dynamic>` object, assuming that the keys correspond to the field names.
  factory MyCourse.fromJson(Map<String, dynamic> json) => MyCourse(
    courseId: (json["courseId"]!=null)?json["courseId"]:-1,
    courseName: (json["courseName"]!=null)?json["courseName"]:"",
  );

  // The `toJson` method converts the `MyCourse` instance to a `Map<String, dynamic>`
  // object, suitable for encoding as JSON. The keys correspond to the field names.
  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "courseName": courseName,
  };
}
