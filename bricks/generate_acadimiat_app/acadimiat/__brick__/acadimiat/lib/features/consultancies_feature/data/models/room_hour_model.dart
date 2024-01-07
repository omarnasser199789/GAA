import 'dart:convert';

import '../../domain/entities/room_hour_entity.dart';

List<RoomHoursModel> roomHoursModelFromJson(String str) => List<RoomHoursModel>.from(json.decode(str).map((x) => RoomHoursModel.fromJson(x)));

String roomHoursModelToJson(List<RoomHoursModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomHoursModel  extends RoomHourEntity{
  RoomHoursModel({
  required  this.startFrom,
  required  this.endAt,
  required  this.active,
  }):super(
    startFrom:startFrom,
    endAt:endAt,
    active:active,
  );

 final double startFrom;
 final double endAt;
 final bool active;

  factory RoomHoursModel.fromJson(Map<String, dynamic> json) => RoomHoursModel(
    startFrom: json["startFrom"],
    endAt: json["endAt"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "startFrom": startFrom,
    "endAt": endAt,
    "active": active,
  };
}
