import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repositories/authenticate_repository.dart';

class RegisterUseCase implements UseCase<int, RegisterParams> {
  final AuthenticateRepository repository;
  RegisterUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(RegisterParams params) {
    return repository.register(params);
  }
}

class RegisterParams {
  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.rePassword,
    required this.acceptTerms,
    required this.phone,
  });
  String email;
  String password;
  String fullName;
  String rePassword;
  bool acceptTerms;
  String phone;
}
