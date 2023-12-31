

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../entities/room_hour_entity.dart';
import '../../repositories/currencies_repository.dart';

//https://v1.emasteryacademy.com/v1/roomhours
class GetRoomHoursUseCase implements UseCase<List<RoomHourEntity>, RoomHoursParams> {
  final MyConsultanciesRepository repository;
  GetRoomHoursUseCase({required this.repository});
  @override
  Future<Either<Failure, List<RoomHourEntity>>> call(RoomHoursParams params) {
    return repository.getRoomHour(params);
  }
}


RoomHoursParams roomHoursParamsFromJson(String str) => RoomHoursParams.fromJson(json.decode(str));

String roomHoursParamsToJson(RoomHoursParams data) => json.encode(data.toJson());

class RoomHoursParams {
  RoomHoursParams({
  required  this.consultancyId,
  required  this.date,
  });

  int consultancyId;
  String date;

  factory RoomHoursParams.fromJson(Map<String, dynamic> json) => RoomHoursParams(
    consultancyId: json["consultancyId"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "consultancyId": consultancyId,
    "date": date,
  };
}



