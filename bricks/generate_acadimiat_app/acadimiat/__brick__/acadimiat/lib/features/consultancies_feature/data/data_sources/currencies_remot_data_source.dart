
import 'package:http/http.dart' as http;
import '../../../../core/globals.dart';
import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';
import '../models/consultancies_model.dart';
import '../models/consultancy_model.dart';
import '../models/consultationSessionsModel.dart';
import '../models/room_hour_model.dart';
import 'currencies_remote_data_functions.dart';

abstract class MyConsultanciesRemoteDataSource {
  Future<List<MyConsultanciesModel>> getMyConsultancies(int userId);
  Future<ConsultancyModel> getConsultancy(int id);
  Future<List<ConsultationsSessionsModel>> getConsultationSession(int consultationID);
  Future<List<int>> getRoomCalendar(int id);
  Future<List<RoomHoursModel>> getRoomHour(RoomHoursParams params);
  Future<String> getRoomTimezone(int id);
  Future<int> reserveMeeting(ReserveMeetingParams params);
}


class MyConsultanciesRemoteDataSourceImpl implements MyConsultanciesRemoteDataSource {
  final http.Client client;
  MyConsultanciesRemoteDataSourceImpl({required this.client});

  MyConsultanciesRemoteDataFunctions functions = MyConsultanciesRemoteDataFunctions();
  @override
  Future<List<MyConsultanciesModel>> getMyConsultancies(int userId) {
    return functions.getMyConsultancies('$baseUrl/v1/myconsultancies/$userId');
  }

  @override
  Future<ConsultancyModel> getConsultancy(int id) {
    return functions.getConsultancy('$baseUrl/v1/consultancy/$id');
  }


  @override
  Future<List<ConsultationsSessionsModel>> getConsultationSession(int consultationID) {
    return functions.getConsultationSession('$baseUrl/v1/csessions/$consultationID');
  }

  @override
  Future<List<int>> getRoomCalendar(int id) {
    return functions.getRoomCalendar('$baseUrl/v1/roomcalendar/$id');
  }


  @override
  Future<List<RoomHoursModel>> getRoomHour(RoomHoursParams params) {
    return functions.getRoomHour('$baseUrl/v1/roomhours',params);
  }

  @override
  Future<String> getRoomTimezone(int id) {
    return functions.getRoomTimezone('$baseUrl/v1/roomtimezone/$id');
  }

  @override
  Future<int> reserveMeeting(ReserveMeetingParams params) {

    return functions.reserveMeeting('$baseUrl/v1/reservemeeting',params);
  }
}
