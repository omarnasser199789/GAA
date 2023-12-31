import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/authenticate_entity.dart';
import '../../domain/entities/check_password_entity.dart';
import '../../domain/entities/update_user_info_entity.dart';

@immutable
abstract class AuthenticateState extends Equatable  {
  @override
  List<Object> get props => [];
}

class Empty extends AuthenticateState {}

class Loading extends AuthenticateState {}
class LoadedReset extends AuthenticateState {
  final int statusCode;//Entities form domain

  LoadedReset({required this.statusCode});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class SuccessUpdateUserInfoEntity extends AuthenticateState {
  final UpdateUserInfoEntity updateUserInfoEntity;
  SuccessUpdateUserInfoEntity({required this.updateUserInfoEntity});
}
class SuccessLogin extends AuthenticateState {
  final int statusCode;//Entities form domain
  SuccessLogin({required this.statusCode});//we use this constructor in ((BLOC & test))
}
class SuccessAuthenticate extends AuthenticateState {
  final AuthenticateEntity authenticateEntity;//Entities form domain
  SuccessAuthenticate({required this.authenticateEntity});//we use this constructor in ((BLOC & test))
}
class SuccessFacheck extends AuthenticateState {}
class SuccessResetPassword extends AuthenticateState {
  final int statusCode;//Entities form domain

  SuccessResetPassword({required this.statusCode});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class SuccessCheckPassword extends AuthenticateState {
  final CheckPasswordEntity checkPasswordEntity;//Entities form domain

  SuccessCheckPassword({required this.checkPasswordEntity});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class SuccessRegisterUserInFirebase extends  AuthenticateState {
  int statusCode;
  SuccessRegisterUserInFirebase({required this.statusCode});
}
class SuccessChangePassword extends AuthenticateState {
  final int statusCode;//Entities form domain

  SuccessChangePassword({required this.statusCode});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class LoadedReActiveEmail extends AuthenticateState {
  final String message;//Entities form domain

  LoadedReActiveEmail({required this.message});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [];
}
class HaveYouAlreadyRegistered extends AuthenticateState{}
class Error extends AuthenticateState {
  final String message;

  Error({required this.message});//we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [message];
}


