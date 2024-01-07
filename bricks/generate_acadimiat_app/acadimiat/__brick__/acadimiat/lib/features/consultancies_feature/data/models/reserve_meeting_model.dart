import 'dart:convert';
import '../../domain/entities/reserve_meeting_entity.dart';

List<ReserveMeetingModel> reserveMeetingModelFromJson(String str) => List<ReserveMeetingModel>.from(json.decode(str).map((x) => ReserveMeetingModel.fromJson(x)));

String reserveMeetingModelToJson(List<ReserveMeetingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReserveMeetingModel extends ReserveMeetingEntity {
  ReserveMeetingModel({
  required this.meetingId,
  required this.timezone,
  required this.consultancyTimezone,
  required this.id,
  required this.date,
  required this.hour,
  required this.isActive,
  required this.isDone,
  required this.day,
  required this.url,
  required this.meetingLongId,
  required this.attendeePw,
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

  factory ReserveMeetingModel.fromJson(Map<String, dynamic> json) => ReserveMeetingModel(
    meetingId: (json["meetingID"]!=null)?json["meetingID"]:"",
    timezone: (json["timezone"]!=null)?json["timezone"]:"",
    consultancyTimezone: (json["consultancyTimezone"]!=null)?json["consultancyTimezone"]:"",
    id: (json["id"]!=null)?json["id"]:-1,
    date: (json["date"]!=null)?DateTime.parse(json["date"]):DateTime.now(),
    hour:(json["hour"]!=null)? DateTime.parse(json["hour"]):DateTime.now(),
    isActive: false,//(json["isActive"]!=null)?json["isActive"]:false,
    isDone: false,//(json["isDone"]!=null)?json["isDone"]:false,
    day: (json["day"]!=null)?json["day"]:"",
    url: (json["url"]!=null)?json["url"]:"",
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
