import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../domain/entities/authenticate_entity.dart';
import '../../../domain/entities/check_password_entity.dart';
import '../../../domain/entities/update_user_info_entity.dart';
import '../authenticate_state.dart';

Stream<AuthenticateState> eitherSuccessLogInOrErrorState(
  Either<Failure,int> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (statusCode) => SuccessLogin(statusCode: statusCode),
  );
}
Stream<AuthenticateState> eitherSuccessAuthenticateOrErrorState(Either<Failure,AuthenticateEntity> failureOrSuccess) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (authenticateEntity) => SuccessAuthenticate(authenticateEntity: authenticateEntity),
  );
}
Stream<AuthenticateState> eitherSuccessFacheckOrErrorState(Either<Failure,int> failureOrSuccess) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (authenticateEntity) => SuccessFacheck(),
  );
}
Stream<AuthenticateState> eitherSuccessCheckPasswordOrErrorState(
  Either<Failure,CheckPasswordEntity> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (checkPasswordEntity) => SuccessCheckPassword(
        checkPasswordEntity: checkPasswordEntity),
  );
}
Stream<AuthenticateState> eitherRegisterUserInFirebaseEventSuccessOrErrorState(
  Either<Failure,int> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (statusCode) => SuccessRegisterUserInFirebase(
        statusCode: statusCode),
  );
}

Stream<AuthenticateState> updateUserInfoUseCaseEitherLoadedOrErrorState(
    Either<Failure, UpdateUserInfoEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (updateUserInfoEntity) => SuccessUpdateUserInfoEntity(
        updateUserInfoEntity: updateUserInfoEntity),
  );
}
Stream<AuthenticateState> eitherSuccessResetPasswordOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (statusCode) => SuccessResetPassword(
            statusCode: statusCode),
  );
}

Stream<AuthenticateState> eitherSuccessChangePasswordOrErrorState(
  Either<Failure,int> failureOrSuccess,
) async* {
  yield failureOrSuccess.fold(
    (failure) => Error(message: mapFailureToMessage(failure)),
    (statusCode) => SuccessChangePassword(
        statusCode: statusCode),
  );
}
