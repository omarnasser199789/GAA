import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/authenticate_entity.dart';
import '../repositories/authenticate_repository.dart';

class LoginUseCase implements UseCase<AuthenticateEntity, LoginParams> {
  final AuthenticateRepository repository;
  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, AuthenticateEntity>> call(LoginParams params) {
    return repository.login(params);
  }
}

class LoginParams {
  LoginParams({
    required this.loginName,
    required this.password,
  });
  String loginName;
  String password;
}
