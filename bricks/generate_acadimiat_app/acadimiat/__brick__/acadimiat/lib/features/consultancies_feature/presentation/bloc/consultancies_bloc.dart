
import 'package:acadmiat/features/consultancies_feature/presentation/bloc/success_error/either_success_or_error.dart';

import '../../domain/use_cases/buy_section/get_consultancy_usecase.dart';
import '../../domain/use_cases/present_section/get_consultation_sessions_usecase.dart';
import '../../domain/use_cases/present_section/get_my_consultations.dart';
import '../../domain/use_cases/present_section/get_room_calendar_usecase.dart';
import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/get_room_timezone_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsultanciesBloc extends Bloc<ConsultanciesEvent, ConsultanciesState> {

  final GetMyConsultanciesUseCase _getMyConsultanciesUseCase;
  final GetConsultancyUseCase _getConsultancyUseCase;
  final GetConsultationSessionsUseCase _getConsultationSessionsUseCase;
  final GetRoomCalendarUseCase _getRoomCalendarUseCase;
  final GetRoomHoursUseCase _getRoomHoursUseCase;
  final GetRoomTimezoneUseCase _getRoomTimezoneUseCase;
  final ReserveMeetingUseCase _reserveMeetingUseCase;



  ConsultanciesBloc(
      {
    required GetMyConsultanciesUseCase concreteGetMyConsultanciesUseCase,
    required GetConsultancyUseCase concreteGetConsultancyUseCase,
    required GetConsultationSessionsUseCase concreteGetConsultationSessionsUseCase,
    required GetRoomCalendarUseCase concreteGetRoomCalendarUseCase,
    required GetRoomHoursUseCase concreteGetRoomHoursUseCase,
    required GetRoomTimezoneUseCase concreteGetRoomTimezoneUseCase,
    required ReserveMeetingUseCase concreteReserveMeetingUseCase,
  }
  )
      : _getMyConsultanciesUseCase = concreteGetMyConsultanciesUseCase,
        _getConsultancyUseCase = concreteGetConsultancyUseCase,
        _getConsultationSessionsUseCase= concreteGetConsultationSessionsUseCase,
        _getRoomCalendarUseCase= concreteGetRoomCalendarUseCase,
        _getRoomHoursUseCase= concreteGetRoomHoursUseCase,
        _getRoomTimezoneUseCase= concreteGetRoomTimezoneUseCase,
        _reserveMeetingUseCase= concreteReserveMeetingUseCase,

        super(Empty());

  @override
  Stream<ConsultanciesState> mapEventToState(ConsultanciesEvent event) async* {

    if (event is GetMyConsultanciesEvent) {
      yield Loading();
      final failureOrPhysician = await _getMyConsultanciesUseCase(event.id);
      yield* eitherSuccessGetConsultanciesOrErrorState(failureOrPhysician);
    }
    if (event is GetConsultancyEvent) {
      yield Loading();
      final failureOrPhysician = await _getConsultancyUseCase(event.id);
      yield* eitherSuccessGetConsultancyEventOrErrorState(failureOrPhysician);
    }
    if (event is GetConsultationSessionsEvent) {
      yield Loading();
      final failureOrPhysician = await _getConsultationSessionsUseCase(event.consultationID);
      yield* eitherSuccessGetConsultationSessionsOrErrorState(failureOrPhysician);
    }
    if (event is BookMeetingEvent) {
      yield LoadingBTN();
      final failureOrPhysician = await _reserveMeetingUseCase(event.params);
      yield* eitherSuccessBookMeetingOrErrorState(failureOrPhysician);
    }
    if (event is GetRoomHoursEvent) {
      yield Loading();
      final failureOrPhysician = await _getRoomHoursUseCase(event.params);
      yield* eitherSuccessGetRoomHoursOrErrorState(failureOrPhysician);
    }
    if (event is GetRoomTimezoneEvent) {
      yield Loading();
      final failureOrPhysician = await _getRoomTimezoneUseCase(event.id);
      yield* eitherSuccessGetTimezoneOrErrorState(failureOrPhysician);
    }
    if (event is GetRoomCalendarEvent) {
      yield Loading();
      final failureOrPhysician = await _getRoomCalendarUseCase(event.id);
      yield* eitherSuccessGetRoomCalendarOrErrorState(failureOrPhysician);
    }

  }
}
