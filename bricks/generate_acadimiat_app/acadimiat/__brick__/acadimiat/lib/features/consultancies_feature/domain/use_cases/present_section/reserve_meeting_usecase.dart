import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../repositories/currencies_repository.dart';
import 'dart:convert';

class ReserveMeetingUseCase implements UseCase<int, ReserveMeetingParams> {
  final MyConsultanciesRepository repository;
  ReserveMeetingUseCase({required this.repository});
  @override
  Future<Either<Failure,int>> call(ReserveMeetingParams params) {
    return repository.reserveMeeting(params);
  }
}

ReserveMeetingParams reserveMeetingParamsFromJson(String str) => ReserveMeetingParams.fromJson(json.decode(str));

String reserveMeetingParamsToJson(ReserveMeetingParams data) => json.encode(data.toJson());

class ReserveMeetingParams {
  ReserveMeetingParams({
  required  this.roomId,
  required  this.day,
  required  this.hour,
  required  this.timezone,
  required  this.userId,
  });

  int roomId;
  String day;
  int hour;
  String timezone;
  String userId;

  factory ReserveMeetingParams.fromJson(Map<String, dynamic> json) => ReserveMeetingParams(
    roomId: json["roomId"],
    day: json["day"],
    hour: json["hour"],
    timezone: json["timezone"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "roomId": roomId,
    "day": day,
    "hour": hour,
    "timezone": timezone,
    "userId": userId,
  };
}
