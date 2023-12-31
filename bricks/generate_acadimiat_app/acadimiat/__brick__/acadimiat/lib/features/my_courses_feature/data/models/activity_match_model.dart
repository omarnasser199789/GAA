
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

  int id;
  int userId;
  dynamic questionId;
  dynamic email;
  dynamic isCorrect;
  DateTime date;
  List<Matched> matched;

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

// class Matched {
//   Matched({
//   required  this.id,
//   required  this.attendanceId,
//   required  this.pairId,
//   required  this.selectedId,
//   required  this.first,
//   required  this.second,
//   required  this.shouldBe,
//   required  this.attendance,
//   });
//
//   int id;
//   int attendanceId;
//   dynamic pairId;
//   dynamic selectedId;
//   String first;
//   String second;
//   String shouldBe;
//   dynamic attendance;
//
//   factory Matched.fromJson(Map<String, dynamic> json) => Matched(
//     id: (json["id"]!=null)?json["id"]:-1,
//     attendanceId: (json["attendanceId"]!=null)?json["attendanceId"]:-1,
//     pairId: json["pairId"],
//     selectedId: json["selectedId"],
//     first: (json["first"]!=null)?json["first"]:"",
//     second: (json["second"]!=null)?json["second"]:"",
//     shouldBe: (json["shouldBe"]!=null)?json["shouldBe"]:"",
//     attendance: json["attendance"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "attendanceId": attendanceId,
//     "pairId": pairId,
//     "selectedId": selectedId,
//     "first": first,
//     "second": second,
//     "shouldBe": shouldBe,
//     "attendance": attendance,
//   };
// }
