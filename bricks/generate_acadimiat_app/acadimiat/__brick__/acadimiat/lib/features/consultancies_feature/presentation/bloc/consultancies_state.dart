
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/consultancies_entity.dart';
import '../../domain/entities/consultancy_entity.dart';
import '../../domain/entities/consultation_session_entity.dart';
import '../../domain/entities/my_consultancies_entity.dart';
import '../../domain/entities/reserve_meeting_entity.dart';
import '../../domain/entities/room_hour_entity.dart';



@immutable
abstract class ConsultanciesState extends Equatable  {
  @override
  List<Object> get props => [];
}

class Empty extends ConsultanciesState {}
class Loading extends ConsultanciesState {}
class LoadingBTN extends ConsultanciesState {}

class SuccessGetMyConsultancies extends ConsultanciesState {
  final List<MyConsultanciesEntity> consultanciesEntityList;//Entities form domain

  SuccessGetMyConsultancies({required this.consultanciesEntityList});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}

class SuccessGetConsultancy extends ConsultanciesState {
  final ConsultancyEntity consultancyEntity;//Entities form domain

  SuccessGetConsultancy({required this.consultancyEntity});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}

class SuccessGetConsultationSession extends ConsultanciesState {
  final  List<ConsultationSessionEntity> consultationSessionList;//Entities form domain

  SuccessGetConsultationSession({required this.consultationSessionList});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class SuccessBookMeeting extends ConsultanciesState {
  final  int statusCode;//Entities form domain

  SuccessBookMeeting({required this.statusCode});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}

class SuccessGetRoomHours extends ConsultanciesState {
  final  List<RoomHourEntity> list;

  SuccessGetRoomHours({required this.list});

  @override
  List<Object> get props => [];
}
class SuccessGetTimezone extends ConsultanciesState {
  final  String time;

  SuccessGetTimezone({required this.time});

  @override
  List<Object> get props => [];
}
class SuccessGetRoomCalendar extends ConsultanciesState {
  final  List<int> roomCalendar;

  SuccessGetRoomCalendar({required this.roomCalendar});

  @override
  List<Object> get props => [];
}

class Error extends ConsultanciesState {
  final String message;

  Error({required this.message});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [message];
}


