import 'dart:convert';
import '../../../../core/classes/matched.dart';
import '../../domain/entities/activity_match_entity.dart';

ActivityMatchModel activityMatchModelFromJson(String str) => ActivityMatchModel.fromJson(json.decode(str));

String activityMatchModelToJson(ActivityMatchModel data) => json.encode(data.toJson());

class ActivityMatchModel  extends ActivityMatchEntity{
  ActivityMatchModel({
  required  this.id,
  required  this.userId,
  required  this.questionId,
  required  this.email,
  required  this.isCorrect,
  required  this.date,
  required  this.matched,
  }):super(
    id:id,
    userId:userId,
    questionId:questionId,
    email:email,
    isCorrect:isCorrect,
    date:date,
    matched:matched,
  );

 final int id;
 final int userId;
 final dynamic questionId;
 final dynamic email;
 final dynamic isCorrect;
 final DateTime date;
 final List<Matched> matched;

  factory ActivityMatchModel.fromJson(Map<String, dynamic> json) => ActivityMatchModel(
    id: (json["id"]!=null)?json["id"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    questionId: json["questionId"],
    email: json["email"],
    isCorrect: json["isCorrect"],
    date: (json["date"]!=null)?DateTime.parse(json["date"]):DateTime.now(),
    matched:(json["matched"]!=null)? List<Matched>.from(json["matched"].map((x) => Matched.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "questionId": questionId,
    "email": email,
    "isCorrect": isCorrect,
    "date": date.toIso8601String(),
    "matched": List<dynamic>.from(matched.map((x) => x.toJson())),
  };
}
