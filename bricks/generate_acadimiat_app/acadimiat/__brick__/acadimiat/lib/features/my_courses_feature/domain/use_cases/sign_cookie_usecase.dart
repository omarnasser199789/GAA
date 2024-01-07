import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/sign_cookie_entity.dart';
import '../repositories/consultations_repository.dart';

class SignCookieUseCase implements UseCase< SignCookieEntity, String> {
  final MyCoursesRepository repository;
  SignCookieUseCase({required this.repository});
  @override
  Future<Either<Failure, SignCookieEntity>> call(String params) {
    return repository.getSignCookie();
  }
}

