import 'package:acadmiat/features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/myquizizz_entity.dart';


class GetMyQuizizzUseCase implements UseCase<MyQuizizzEntity, GetMyQuizezzParams> {
  final MyCoursesRepository repository;
  GetMyQuizizzUseCase({required this.repository});

  @override
  Future<Either<Failure, MyQuizizzEntity>> call(GetMyQuizezzParams params) {
    return repository.getMyQuizizz(params);
  }
}

class GetMyQuizezzParams {
  int userId;
  int lectureId;
  GetMyQuizezzParams({required this.lectureId, required this.userId});
}
