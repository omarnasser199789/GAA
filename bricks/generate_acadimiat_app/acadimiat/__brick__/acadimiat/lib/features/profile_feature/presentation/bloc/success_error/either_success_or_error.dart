
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/globals.dart';
import '../../../domain/entities/add_new_note_entity.dart';
import '../../../domain/entities/my_assignments_entity.dart';
import '../../../domain/entities/my_bookmarks_entity.dart';
import '../../../domain/entities/my_certificates_entity.dart';
import '../../../domain/entities/my_notes_entity.dart';
import '../../../domain/entities/my_payments_entity.dart';
import '../../../domain/entities/my_plans_entity.dart';
import '../../../domain/entities/my_quizzes_entity.dart';
import '../../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../../../domain/entities/user_info_entity.dart';
import '../profile_state.dart';



Stream<ProfileState> updateMyAvatarEitherLoadedOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (resCode) => SuccessUpdateUserAvtarEntity(
        resCode: resCode),
  );
}


Stream<ProfileState> getMyPaymentsUseCaseEitherLoadedOrErrorState(
    Either<Failure, List<MyPaymentEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myPaymentListEntity) => SuccessgetMyPaymentsEntity(
        myPaymentListEntity: myPaymentListEntity),
  );
}

Stream<ProfileState> updateUserInfoUseCaseEitherLoadedOrErrorState(
    Either<Failure, UpdateUserInfoEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (updateUserInfoEntity) => SuccessUpdateUserInfoEntity(
        updateUserInfoEntity: updateUserInfoEntity),
  );
}

Stream<ProfileState> getUserInfoUseCaseEitherLoadedOrErrorState(
    Either<Failure, UserInfoEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (userInfoEntity) =>
        SuccessGetUserInfoEntity(userInfoEntity: userInfoEntity),
  );
}

Stream<ProfileState> getMyBookmarksListEitherLoadedOrErrorState(
    Either<Failure, List<MyBookmarksEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myBookmarksListEntity) => SuccessGetMyBookmarksListEntity(
        myBookmarksListEntity: myBookmarksListEntity),
  );
}

Stream<ProfileState> getMyAssignmentsListEitherLoadedOrErrorState(
    Either<Failure, List<MyAssignmentsEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myAssignmentsListEntity) => SuccessgetMyAssignmentsListEntity(
        myAssignmentsListEntity: myAssignmentsListEntity),
  );
}

Stream<ProfileState> getMyCertificatesUseCaseEitherLoadedOrErrorState(
    Either<Failure,List<MyCertificatesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myCertificatesListEntity) => SuccessGetMyCertificatesEntity(
        myCertificatesListEntity: myCertificatesListEntity),
  );
}
Stream<ProfileState> exportCertificateToPDFEitherLoadedOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => ExportCertificateToPDFEntity(
        statusCode: statusCode),
  );
}
Stream<ProfileState> getMyNotesEitherLoadedOrErrorState(
    Either<Failure,MyNoteEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myNoteEntity) => MyNotesEntity(
        myNoteEntity: myNoteEntity),
  );
}
Stream<ProfileState> deleteNoteSuccessOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessDeleteNoteEntity(
        statusCode: statusCode),
  );
}

Stream<ProfileState> addNewNoteSuccessOrErrorState(
    Either<Failure,AddNewNoteEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (addNewNoteEntity) => SuccessAddNoteEntity(
            addNewNoteEntity: addNewNoteEntity),
  );
}
Stream<ProfileState> getMyPlansSuccessOrErrorState(
    Either<Failure,List<MyPlansEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myPlans) => SuccessGetMyPlansEntity(
            myPlans: myPlans),
  );
}
Stream<ProfileState> deletePlanSuccessOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessDeletePlanEntity(
            statusCode: statusCode),
  );
}
Stream<ProfileState> postMyPlanSuccessOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessPostMyPlanEntity(
            statusCode: statusCode),
  );
}
Stream<ProfileState> getMyQuizzesListEitherLoadedOrErrorState(
    Either<Failure, List<MyQuizzesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myQuizzesListEntity) => SuccessGetMyQuizzesListEntity(
        myQuizzesListEntity: myQuizzesListEntity),
  );
}

Stream<ProfileState> eitherResendActivationEmailLoadedOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessSendActivationEmail(statusCode: statusCode),
  );
}
Stream<ProfileState> eitherChangePasswordLoadedOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessChangePassword(statusCode: statusCode),
  );
}

Stream<ProfileState> eitherLoadedOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessSendActivationEmail(statusCode: statusCode),
  );
}


Stream<ProfileState> eitherResetPasswordLoadedOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessResetPassword(statusCode: statusCode),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}