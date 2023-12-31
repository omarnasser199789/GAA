import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/update_user_info_entity.dart';
import '../repositories/authenticate_repository.dart';

class UpdateUserInfoUseCase implements UseCase<UpdateUserInfoEntity, UserInfoParams> {
  final AuthenticateRepository repository;
  UpdateUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UpdateUserInfoEntity>> call(UserInfoParams params) {
    return repository.updateUserInfo(params);
  }
}

class UserInfoParams extends Equatable {
  final String email;
  final int userId;
  final String name;
  final String phone;
  final String birthDate;
  const UserInfoParams({
    required this.email,
    required this.userId,
    required this.name,
    required this.phone,
    required this.birthDate,
  });

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
