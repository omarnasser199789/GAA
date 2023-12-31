import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/check_password_entity.dart';
import '../repositories/authenticate_repository.dart';
import 'login_usecase.dart';

class CheckPasswordUseCase implements UseCase<CheckPasswordEntity, LoginParams> {
  final AuthenticateRepository repository;
  CheckPasswordUseCase({required this.repository});
  @override
  Future<Either<Failure, CheckPasswordEntity>> call(LoginParams params) {
    return repository.checkPassword(params);
  }
}

