import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/authenticate_entity.dart';
import '../entities/check_password_entity.dart';
import '../entities/update_user_info_entity.dart';
import '../use_cases/facheck_usecase.dart';
import '../use_cases/login_usecase.dart';
import '../use_cases/register_usecase.dart';
import '../use_cases/update_user_info_usecase.dart';

abstract class AuthenticateRepository{
  Future<Either<Failure,AuthenticateEntity>> login(LoginParams noParams);
  Future<Either<Failure,int>> register(RegisterParams noParams);
  Future<Either<Failure,int>> facheck(FacheckParams noParams);
  Future<Either<Failure,CheckPasswordEntity>> checkPassword(LoginParams noParams);
  Future<Either<Failure,int>> changePassword(LoginParams noParams);
  Future<Either<Failure,UpdateUserInfoEntity>> updateUserInfo(UserInfoParams noParams);
  Future<Either<Failure,int>> resetPassword(String email);
}