import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/authenticate_repository.dart';
class ResetPasswordUseCase implements UseCase<int, String> {
  final AuthenticateRepository repository;
  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(String email) {

    return repository.resetPassword(email);
  }
}

