import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_info_entity.dart';
import '../repositories/profile_repository.dart';


class GetUserInfoUseCase implements UseCase<UserInfoEntity, int> {
  final ProfileRepository repository;
  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserInfoEntity>> call(int userId) {
    return repository.getUserInfo(userId );
  }
}



