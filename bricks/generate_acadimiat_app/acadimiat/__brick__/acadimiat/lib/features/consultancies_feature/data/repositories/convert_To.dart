import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/consultancy_entity.dart';
import '../../domain/entities/consultation_session_entity.dart';
import '../../domain/entities/my_consultancies_entity.dart';
import '../../domain/entities/reserve_meeting_entity.dart';
import '../../domain/entities/room_hour_entity.dart';


typedef Future<List<MyConsultanciesEntity>> _LastFiveEntityInfoChooser();
typedef Future<ConsultancyEntity> _ConsultancyEntityInfoChooser();
typedef Future<List<ConsultationSessionEntity>> _ConsultationSessionEntityInfoChooser();
typedef Future<List<int>> _IntListInfoChooser();
typedef Future<String> _StringInfoChooser();
typedef Future<List<ReserveMeetingEntity>> _ReserveMeetingEntity();
typedef Future<int> _IntInfoChooser();
typedef Future<List<RoomHourEntity>> _RoomHourEntityListInfoChooser();



Future<Either<Failure,  List<MyConsultanciesEntity>>> convertToMyConsultanciesEntity(
    _LastFiveEntityInfoChooser _lastFiveEntityInfoChooser,
    ) async {

  try {
    final remotePatient = await _lastFiveEntityInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}

Future<Either<Failure, ConsultancyEntity>> convertToConsultancyEntity(
    _ConsultancyEntityInfoChooser _consultancyEntityInfoChooser,
    ) async {

  try {
    final remotePatient = await _consultancyEntityInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, List<ConsultationSessionEntity>>> convertToConsultationSessionEntity(
    _ConsultationSessionEntityInfoChooser _consultationSessionEntityInfoChooser,
    ) async {

  try {
    final remotePatient = await _consultationSessionEntityInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, List<int>>> convertToIntList(
    _IntListInfoChooser _intListInfoChooser,
    ) async {

  try {
    final remotePatient = await _intListInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, List<RoomHourEntity>>> convertToRoomHourEntityList(
    _RoomHourEntityListInfoChooser _roomHourEntityListInfoChooser,
    ) async {

  try {
    final remotePatient = await _roomHourEntityListInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, String>> convertToString(
    _StringInfoChooser _stringInfoChooser,
    ) async {

  try {
    final remotePatient = await _stringInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, List<ReserveMeetingEntity>>> convertToReserveMeetingEntity(
    _ReserveMeetingEntity _reserveMeetingEntity,
    ) async {

  try {
    final remotePatient = await _reserveMeetingEntity();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}
Future<Either<Failure, int>> convertToInt(
    _IntInfoChooser _intInfoChooser,
    ) async {

  try {
    final remotePatient = await _intInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(CacheFailure());
  }
}