import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/functions.dart';
import '../../../domain/entities/consultancy_entity.dart';
import '../../../domain/entities/consultation_session_entity.dart';
import '../../../domain/entities/my_consultancies_entity.dart';
import '../../../domain/entities/room_hour_entity.dart';
import '../consultancies_state.dart';

Stream<ConsultanciesState> eitherSuccessGetConsultanciesOrErrorState(
  Either<Failure,List<MyConsultanciesEntity>> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (consultanciesEntityList) => SuccessGetMyConsultancies(
        consultanciesEntityList: consultanciesEntityList),
  );
}

Stream<ConsultanciesState> eitherSuccessGetConsultancyEventOrErrorState(
  Either<Failure,ConsultancyEntity> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (consultancyEntity) => SuccessGetConsultancy(
        consultancyEntity: consultancyEntity),
  );
}
Stream<ConsultanciesState> eitherSuccessGetConsultationSessionsOrErrorState(
  Either<Failure, List<ConsultationSessionEntity>> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (consultationSessionList) => SuccessGetConsultationSession(
        consultationSessionList: consultationSessionList),
  );
}
Stream<ConsultanciesState> eitherSuccessBookMeetingOrErrorState(
  Either<Failure,int> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (statusCode) => SuccessBookMeeting(
        statusCode: statusCode),
  );
}
Stream<ConsultanciesState> eitherSuccessGetRoomHoursOrErrorState(
  Either<Failure, List<RoomHourEntity>> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (list) => SuccessGetRoomHours(
        list: list),
  );
}
Stream<ConsultanciesState> eitherSuccessGetTimezoneOrErrorState(
  Either<Failure, String> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (time) => SuccessGetTimezone(
        time: time),
  );
}


Stream<ConsultanciesState> eitherSuccessGetRoomCalendarOrErrorState(
  Either<Failure, List<int>> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (roomCalendar) => SuccessGetRoomCalendar(
        roomCalendar: roomCalendar),
  );
}


