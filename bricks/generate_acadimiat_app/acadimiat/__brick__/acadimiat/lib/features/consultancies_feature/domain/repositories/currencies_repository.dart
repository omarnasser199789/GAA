import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/consultancies_entity.dart';
import '../entities/consultancy_entity.dart';
import '../entities/consultation_session_entity.dart';
import '../entities/my_consultancies_entity.dart';
import '../entities/reserve_meeting_entity.dart';
import '../entities/room_hour_entity.dart';
import '../use_cases/present_section/get_room_hours_usecase.dart';
import '../use_cases/present_section/reserve_meeting_usecase.dart';


abstract class MyConsultanciesRepository{
  Future<Either<Failure,List<MyConsultanciesEntity>>> getMyConsultancies(int userId);
  Future<Either<Failure,ConsultancyEntity>> getConsultancy(int id);
  Future<Either<Failure,List<ConsultationSessionEntity>>> getConsultationSession(int consultationID);
  Future<Either<Failure,List<int>>> getRoomCalendar(int id);
  Future<Either<Failure, List<RoomHourEntity>>> getRoomHour(RoomHoursParams params);
  Future<Either<Failure, String>> getRoomTimezone(int id);
  Future<Either<Failure, int>> reserveMeeting(ReserveMeetingParams params);
}