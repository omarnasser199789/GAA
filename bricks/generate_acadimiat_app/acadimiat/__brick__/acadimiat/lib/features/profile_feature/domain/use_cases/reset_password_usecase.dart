import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class ResetPasswordUseCase implements UseCase<int, String> {
  final ProfileRepository repository;
  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(String email) {
    return repository.resetPassword(email);
  }
}



