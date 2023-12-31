import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';


class UpdateMyAvatarUseCase implements UseCase<int, UpdateMyAvatarParam> {
  final ProfileRepository repository;
  UpdateMyAvatarUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(UpdateMyAvatarParam param) {
    return repository.updateMyAvatar(param);
  }
}

class UpdateMyAvatarParam {
  final String userId;
  final String image;
  UpdateMyAvatarParam({required this.userId,required this.image});
}
