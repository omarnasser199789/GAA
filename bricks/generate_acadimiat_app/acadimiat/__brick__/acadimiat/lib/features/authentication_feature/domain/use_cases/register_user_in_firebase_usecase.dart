import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/authenticate_repository.dart';
class RegisterUserInFirebaseUseCase implements UseCase<int, PhoneAuthCredential> {
  final AuthenticateRepository repository;
  RegisterUserInFirebaseUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(PhoneAuthCredential phoneAuthCredential) {

    return repository.registerUserInFirebase(phoneAuthCredential);
  }
}

