import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';

import '../../domain/entities/authenticate_entity.dart';
import '../../domain/entities/check_password_entity.dart';
import '../../domain/entities/update_user_info_entity.dart';

typedef Future<int> _IntInfoChooser();
typedef Future<UpdateUserInfoEntity> _UpdateUserInfoEntityInfoChooser();
typedef Future<CheckPasswordEntity> _CheckPasswordEntityInfoChooser();
typedef Future<AuthenticateEntity> _AuthenticateEntityInfoChooser();

Future<Either<Failure,  int>> convertToInt(
    _IntInfoChooser _intInfoChooser,
    ) async {
  try {
    final remotePatient = await _intInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(ServerFailure());
  }
}
Future<Either<Failure,  UpdateUserInfoEntity>> convertUpdateUserInfo(
    _UpdateUserInfoEntityInfoChooser _updateUserInfoEntityInfoChooser,
    ) async {
  try {
    final remotePatient = await _updateUserInfoEntityInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(ServerFailure());
  }
}

Future<Either<Failure,  CheckPasswordEntity>> convertToCheckPasswordEntity(
    _CheckPasswordEntityInfoChooser _checkPasswordEntityInfoChooser,
    ) async {
    try {
      final remotePatient = await _checkPasswordEntityInfoChooser();

      return Right(remotePatient);
    } on ServerException {
      return Left(ServerFailure());
    }

}

Future<Either<Failure,  AuthenticateEntity>> convertToAuthenticateEntity(
    _AuthenticateEntityInfoChooser _authenticateEntityInfoChooser,
    ) async {
  try {
    final remotePatient = await _authenticateEntityInfoChooser();

    return Right(remotePatient);
  } on ServerException {
    return Left(ServerFailure());
  }

}
