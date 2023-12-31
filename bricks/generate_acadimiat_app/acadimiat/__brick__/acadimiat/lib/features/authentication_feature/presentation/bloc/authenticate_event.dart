import 'package:equatable/equatable.dart';
import '../../domain/use_cases/facheck_usecase.dart';
import '../../domain/use_cases/register_usecase.dart';

abstract class AuthenticateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends AuthenticateEvent {
  String id;
  int userId;
  String password;

  ChangePasswordEvent({
    required this.userId,
    required this.id,
    required this.password,
  });
}

class UpdateUserInfo extends AuthenticateEvent {
  final String email;
  final int id;
  final String name;
  final String phone;
  final String birthdate;

  UpdateUserInfo({
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.birthdate,
  });
}

class ResetPassword extends AuthenticateEvent {
  final String email;


  ResetPassword({
    required this.email,
  });
}

class ResetPasswordDbaEvent extends AuthenticateEvent {
  String id;
  int userId;
  String password;

  ResetPasswordDbaEvent({
    required this.userId,
    required this.id,
    required this.password,
  });
}

class ReactivateEvent extends AuthenticateEvent {
  String email;

  ReactivateEvent({
    required this.email,
  });
}

class ResetEvent extends AuthenticateEvent {
  String email;

  ResetEvent({
    required this.email,
  });
}

class ResetPasswordEvent extends AuthenticateEvent {

  String userId;
  String email;

  ResetPasswordEvent({
    required this.email,
    required this.userId,

  });

}

class GetInEvent extends AuthenticateEvent {
  String id;
  int userId;
  String password;

  GetInEvent({
    required this.id,
    required this.userId,
    required this.password,

  });

}

class ConfirmEvent extends AuthenticateEvent {
  String userId;
  String email;

  ConfirmEvent({
    required this.email,
    required this.userId,
  });
}

class GetLoginUser extends AuthenticateEvent {
  final String loginName;
  final String password;
  GetLoginUser( {required this.loginName,required this.password});
}

class Facheck extends AuthenticateEvent {
  final FacheckParams facheckParams;
  Facheck( {required this.facheckParams});
}

class RegisterUserEvent extends AuthenticateEvent {
  final RegisterParams registerParams;
  RegisterUserEvent( {required this.registerParams});
}

class CheckPassword extends AuthenticateEvent {
  final String loginName;
  final String password;
  CheckPassword( {required this.loginName,required this.password});
}

class ChangePassword extends AuthenticateEvent {
  final String loginName;
  final String password;
  ChangePassword( {required this.loginName,required this.password});
}

class RegisterUser extends AuthenticateEvent {
  final String email;
  final String password;
  final String phone;
  final String fullname;
  RegisterUser(this.email, this.password, this.phone, this.fullname);
}

class GetJWTToken extends AuthenticateEvent {}

class LoginUsingFacebook extends AuthenticateEvent {}

class LoginUsingGoogle extends AuthenticateEvent {}

class LoginUsingTwitter extends AuthenticateEvent {}

class Wait extends AuthenticateEvent {}
