import 'package:acadmiat/features/consultancies_feature/domain/entities/consultancy_entity.dart';
import 'package:acadmiat/features/consultancies_feature/domain/entities/consultation_session_entity.dart';
import 'package:acadmiat/features/consultancies_feature/domain/entities/room_hour_entity.dart';
import 'package:acadmiat/features/consultancies_feature/domain/use_cases/present_section/get_room_hours_usecase.dart';
import 'package:acadmiat/features/consultancies_feature/domain/use_cases/present_section/reserve_meeting_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/my_consultancies_entity.dart';
import '../../domain/repositories/currencies_repository.dart';
import '../data_sources/currencies_remot_data_source.dart';
import 'convert_To.dart';

class MyConsultanciesRepositoryImpl extends MyConsultanciesRepository {
  final MyConsultanciesRemoteDataSource myConsultanciesRemoteDataSource;

  MyConsultanciesRepositoryImpl({
    required this.myConsultanciesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<MyConsultanciesEntity>>> getMyConsultancies(int userId) async{
    return await convertToMyConsultanciesEntity(() {
      return myConsultanciesRemoteDataSource.getMyConsultancies(userId);
    });
  }

  @override
  Future<Either<Failure, ConsultancyEntity>> getConsultancy(int id) async{
    return await convertToConsultancyEntity(() {
      return myConsultanciesRemoteDataSource.getConsultancy(id);
    });
  }

  @override
  Future<Either<Failure, List<ConsultationSessionEntity>>> getConsultationSession(int consultationID) async{
    return await convertToConsultationSessionEntity(() {
        return myConsultanciesRemoteDataSource.getConsultationSession(consultationID);
    });
  }

  @override
  Future<Either<Failure, List<int>>> getRoomCalendar(int id) async{
    return await convertToIntList(() {
      return myConsultanciesRemoteDataSource.getRoomCalendar(id);
    });
  }

  @override
  Future<Either<Failure, List<RoomHourEntity>>> getRoomHour(RoomHoursParams params)async {
    return await convertToRoomHourEntityList(() {
      return myConsultanciesRemoteDataSource.getRoomHour(params);
    });
  }

  @override
  Future<Either<Failure, String>> getRoomTimezone(int id) async{
    return await convertToString(() {
      return myConsultanciesRemoteDataSource.getRoomTimezone(id);
    });
  }

  @override
  Future<Either<Failure, int>> reserveMeeting(ReserveMeetingParams params) async{
    return await convertToInt(() {
      return myConsultanciesRemoteDataSource.reserveMeeting(params);
    });
  }

}
