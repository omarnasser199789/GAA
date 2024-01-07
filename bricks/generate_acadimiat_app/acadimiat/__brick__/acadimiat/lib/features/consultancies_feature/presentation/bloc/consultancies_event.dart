import 'package:equatable/equatable.dart';
import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';

abstract class ConsultanciesEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetMyConsultanciesEvent extends ConsultanciesEvent {
  final int id;
  GetMyConsultanciesEvent({required this.id});
}
class GetConsultancyEvent extends ConsultanciesEvent {
  final int id;
  GetConsultancyEvent({required this.id});
}
class GetConsultationSessionsEvent extends ConsultanciesEvent {
  final int consultationID;
  GetConsultationSessionsEvent({required this.consultationID});
}

class BookMeetingEvent extends ConsultanciesEvent {
  final ReserveMeetingParams params;
  BookMeetingEvent({required this.params});
}
class GetRoomHoursEvent extends ConsultanciesEvent {
  final RoomHoursParams params;
  GetRoomHoursEvent({required this.params});
}
class GetRoomTimezoneEvent extends ConsultanciesEvent {
  final int id;
  GetRoomTimezoneEvent({required this.id});
}

class GetRoomCalendarEvent extends ConsultanciesEvent {
  final int id;
  GetRoomCalendarEvent({required this.id});
}


class Wait extends ConsultanciesEvent {}
