// To parse this JSON data, do
//
//     final consultaionSessionsModel = consultaionSessionsModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/consultation_session_entity.dart';

List<ConsultationsSessionsModel> consultationsSessionsModelFromJson(String str) => List<ConsultationsSessionsModel>.from(json.decode(str).map((x) => ConsultationsSessionsModel.fromJson(x)));

String consultationsSessionsModelToJson(List<ConsultationsSessionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsultationsSessionsModel  extends ConsultationSessionEntity{
  ConsultationsSessionsModel({
  required  this.meetingId,
  required  this.timezone,
  required  this.consultancyTimezone,
  required  this.id,
  required  this.date,
  required  this.hour,
  required  this.isActive,
  required  this.isDone,
  required  this.day,
  required  this.url,
  required  this.meetingLongId,
  required  this.attendeePw,
  }):super(
    meetingId:meetingId,
    timezone:timezone,
    consultancyTimezone:consultancyTimezone,
    id:id,
    date:date,
    hour:hour,
    isActive:isActive,
    isDone:isDone,
    day:day,
    url:url,
    meetingLongId:meetingLongId,
    attendeePw:attendeePw,
  );

 final String meetingId;
 final String timezone;
 final String consultancyTimezone;
 final int id;
 final DateTime date;
 final DateTime hour;
 final bool isActive;
 final bool isDone;
 final String day;
 final String url;
 final dynamic meetingLongId;
 final dynamic attendeePw;

  factory ConsultationsSessionsModel.fromJson(Map<String, dynamic> json) => ConsultationsSessionsModel(
    meetingId: json["meetingID"],
    timezone: json["timezone"],
    consultancyTimezone: json["consultancyTimezone"],
    id: json["id"],
    date: DateTime.parse(json["date"]),
    hour: DateTime.parse(json["hour"]),
    isActive: json["isActive"],
    isDone: json["isDone"],
    day: json["day"],
    url: json["url"],
    meetingLongId: json["meetingLongId"],
    attendeePw: json["attendeePW"],
  );

  Map<String, dynamic> toJson() => {
    "meetingID": meetingId,
    "timezone": timezone,
    "consultancyTimezone": consultancyTimezone,
    "id": id,
    "date": date.toIso8601String(),
    "hour": hour.toIso8601String(),
    "isActive": isActive,
    "isDone": isDone,
    "day": day,
    "url": url,
    "meetingLongId": meetingLongId,
    "attendeePW": attendeePw,
  };
}
