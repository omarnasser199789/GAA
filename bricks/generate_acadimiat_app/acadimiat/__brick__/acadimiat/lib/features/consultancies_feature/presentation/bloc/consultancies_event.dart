import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';

@immutable
abstract class ConsultanciesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMyConsultanciesEvent extends ConsultanciesEvent {
  int id;
  GetMyConsultanciesEvent({required this.id});
}
class GetConsultancyEvent extends ConsultanciesEvent {
  int id;
  GetConsultancyEvent({required this.id});
}
class GetConsultationSessionsEvent extends ConsultanciesEvent {
  int consultationID;
  GetConsultationSessionsEvent({required this.consultationID});
}

class BookMeetingEvent extends ConsultanciesEvent {
  ReserveMeetingParams params;
  BookMeetingEvent({required this.params});
}
class GetRoomHoursEvent extends ConsultanciesEvent {
  RoomHoursParams params;
  GetRoomHoursEvent({required this.params});
}
class GetRoomTimezoneEvent extends ConsultanciesEvent {
  int id;
  GetRoomTimezoneEvent({required this.id});
}

class GetRoomCalendarEvent extends ConsultanciesEvent {
  int id;
  GetRoomCalendarEvent({required this.id});
}


class Wait extends ConsultanciesEvent {}
