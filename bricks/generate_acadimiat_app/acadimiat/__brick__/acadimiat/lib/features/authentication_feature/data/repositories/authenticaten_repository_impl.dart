import 'package:acadmiat/features/authentication_feature/domain/entities/update_user_info_entity.dart';
import 'package:acadmiat/features/authentication_feature/domain/use_cases/facheck_usecase.dart';
import 'package:acadmiat/features/authentication_feature/domain/use_cases/register_usecase.dart';
import 'package:acadmiat/features/authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/authenticate_entity.dart';
import '../../domain/entities/check_password_entity.dart';
import '../../domain/repositories/authenticate_repository.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../data_sources/remot_data_sources/authenticate_remot_data_source.dart';
import 'convert_To.dart';

class AuthenticateRepositoryImpl extends AuthenticateRepository {
  final AuthenticateRemoteDataSource authenticateRemoteDataSource;

  AuthenticateRepositoryImpl({
    required this.authenticateRemoteDataSource,
  });

  @override
  Future<Either<Failure, AuthenticateEntity>> login(LoginParams noParams) async{
    return await convertToAuthenticateEntity(() {
      return authenticateRemoteDataSource.login(noParams);
    });
  }

  @override
  Future<Either<Failure, CheckPasswordEntity>> checkPassword(LoginParams params)async {
    return await convertToCheckPasswordEntity(() {
      return authenticateRemoteDataSource.checkPassword(params);
    });
  }

  @override
  Future<Either<Failure, int>> changePassword(LoginParams params) async{
    return await convertToInt(() {
      return authenticateRemoteDataSource.changePassword(params);
    });
  }

  @override
  Future<Either<Failure, UpdateUserInfoEntity>> updateUserInfo(UserInfoParams params) async {
    return await convertUpdateUserInfo(() {
      return authenticateRemoteDataSource.updateUserInfo(params);
    });
  }

  @override
  Future<Either<Failure, int>> register(RegisterParams params)async {
    return await convertToInt(() {
      return authenticateRemoteDataSource.register(params);
    });
  }

  @override
  Future<Either<Failure, int>> resetPassword(String email) async {
    return await convertToInt(() {
      return authenticateRemoteDataSource.resetPassword(email);
    });
  }

  @override
  Future<Either<Failure, int>> facheck(FacheckParams params) async{
    return await convertToInt(() {
      return authenticateRemoteDataSource.facheck(params);
    });
  }

}
