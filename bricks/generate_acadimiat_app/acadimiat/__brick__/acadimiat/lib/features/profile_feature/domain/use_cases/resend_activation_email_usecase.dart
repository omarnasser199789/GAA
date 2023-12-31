import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class ResentActivationEmailUseCase implements UseCase<int, String> {
  final ProfileRepository repository;
  ResentActivationEmailUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(String email) {
    return repository.resendActivationEmail(email);
  }
}



