import 'package:acadmiat/features/authentication_feature/domain/use_cases/reset_password_usecase.dart';
import 'package:acadmiat/features/authentication_feature/presentation/bloc/success_error/either_success_or_error.dart';
import '../../domain/use_cases/check_password_usecase.dart';
import '../../domain/use_cases/facheck_usecase.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/register_usecase.dart';
import '../../domain/use_cases/update_user_info_usecase.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {

  final LoginUseCase _loginUseCase;
  final CheckPasswordUseCase _checkPasswordUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;
  final RegisterUseCase _registerUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final FacheckUseCase _facheckUseCase;


  AuthenticateBloc(
      {
    required LoginUseCase concreteLoginUseCase,
    required CheckPasswordUseCase concreteCheckPasswordUseCase,
    required UpdateUserInfoUseCase concreteUpdateUserInfoUseCase,
    required RegisterUseCase concreteRegisterUseCase,
    required ResetPasswordUseCase concreteResetPasswordUseCase,
    required FacheckUseCase concreteFacheckUseCase,
  }): _loginUseCase = concreteLoginUseCase,
        _checkPasswordUseCase = concreteCheckPasswordUseCase,
        _updateUserInfoUseCase = concreteUpdateUserInfoUseCase,
        _registerUseCase = concreteRegisterUseCase,
        _resetPasswordUseCase = concreteResetPasswordUseCase,
        _facheckUseCase = concreteFacheckUseCase,
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
    else if(event is ResetPassword){
      yield Loading();
      final failureOrPhysician = await _resetPasswordUseCase(event.email);
      yield* eitherSuccessResetPasswordOrErrorState(failureOrPhysician);
    }
  }
}
