
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class RegisterNewAccountUseCase implements UseCase<int, RegisterNewAccountParams> {
  final ProfileRepository repository;
  RegisterNewAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(RegisterNewAccountParams params) {
    return repository.registerNewAccount(params);
  }
}

class RegisterNewAccountParams extends Equatable{
  final String fullName;
  final String email;
  final String password;
  final String phone;
  RegisterNewAccountParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone
});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();


}



