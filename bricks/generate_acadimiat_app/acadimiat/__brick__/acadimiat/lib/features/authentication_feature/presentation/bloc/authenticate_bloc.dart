

import 'package:acadmiat/features/authentication_feature/domain/use_cases/reset_password_usecase.dart';
import 'package:acadmiat/features/authentication_feature/presentation/bloc/success_error/either_success_or_error.dart';

import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/check_password_usecase.dart';
import '../../domain/use_cases/facheck_usecase.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/register_usecase.dart';
import '../../domain/use_cases/register_user_in_firebase_usecase.dart';
import '../../domain/use_cases/update_user_info_usecase.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {

  final LoginUseCase _loginUseCase;
  final CheckPasswordUseCase _checkPasswordUseCase;
  final RegisterUserInFirebaseUseCase _registerUserInFirebaseUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;
  final RegisterUseCase _registerUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final FacheckUseCase _facheckUseCase;
  // final ChangePasswordUseCase _changePasswordUseCase;


  AuthenticateBloc(
      {
    required LoginUseCase concreteLoginUseCase,
    required CheckPasswordUseCase concreteCheckPasswordUseCase,
    required RegisterUserInFirebaseUseCase concreteRegisterUserInFirebaseUseCase,
    required UpdateUserInfoUseCase concreteUpdateUserInfoUseCase,
    required RegisterUseCase concreteRegisterUseCase,
    required ResetPasswordUseCase concreteResetPasswordUseCase,
    required FacheckUseCase concreteFacheckUseCase,
    // required ChangePasswordUseCase concreteChangePasswordUseCase,
  }): assert(concreteLoginUseCase != null, concreteCheckPasswordUseCase != null),
        _loginUseCase = concreteLoginUseCase,
        _checkPasswordUseCase = concreteCheckPasswordUseCase,
        _registerUserInFirebaseUseCase = concreteRegisterUserInFirebaseUseCase,
        _updateUserInfoUseCase = concreteUpdateUserInfoUseCase,
        _registerUseCase = concreteRegisterUseCase,
        _resetPasswordUseCase = concreteResetPasswordUseCase,
        _facheckUseCase = concreteFacheckUseCase,
        // _changePasswordUseCase=concreteChangePasswordUseCase,

        super(Empty());

  @override
  Stream<AuthenticateState> mapEventToState(AuthenticateEvent event) async* {

    if (event is GetLoginUser) {
      yield Loading();
      final failureOrPhysician = await _loginUseCase(LoginParams(loginName: event.loginName, password: event.password));
      yield* eitherSuccessAuthenticateOrErrorState(failureOrPhysician);
    }
    else if(event is Facheck){
      yield Loading();
      final failureOrPhysician = await _facheckUseCase(event.facheckParams);
      yield* eitherSuccessFacheckOrErrorState(failureOrPhysician);
    }
    else if (event is RegisterUserEvent) {
      yield Loading();
      final failureOrPhysician = await _registerUseCase(event.registerParams);
      yield* eitherSuccessLogInOrErrorState(failureOrPhysician);
    }

    else if(event is CheckPassword){
      yield Loading();
      final failureOrPhysician = await _checkPasswordUseCase(LoginParams(loginName: event.loginName, password: event.password));
      yield* eitherSuccessCheckPasswordOrErrorState(failureOrPhysician);
    }

    if(event is RegisterUserInFirebaseEvent){
      yield Loading();
      final failureOrPhysician = await _registerUserInFirebaseUseCase(event.phoneAuthCredential);
      yield* eitherRegisterUserInFirebaseEventSuccessOrErrorState(failureOrPhysician);
    }

     if (event is UpdateUserInfo) {
      yield Loading();
      final failureOrPhysician = await _updateUserInfoUseCase(UserInfoParams(
        birthDate: event.birthdate,
        email: event.email,
        name: event.name,
        phone: event.phone,
        userId: event.id,
      ));
      yield* updateUserInfoUseCaseEitherLoadedOrErrorState(failureOrPhysician);
    }


    // else if(event is ChangePassword){
    //   yield Loading();
    //   final failureOrPhysician = await _changePasswordUseCase(LoginParams(loginName: event.loginName, password: event.password));
    //   yield* eitherSuccessChangePasswordOrErrorState(failureOrPhysician);
    // }

    else if(event is ResetPassword){
      yield Loading();
      final failureOrPhysician = await _resetPasswordUseCase(event.email);
      yield* eitherSuccessResetPasswordOrErrorState(failureOrPhysician);
    }
  }
}
