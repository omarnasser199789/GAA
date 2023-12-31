import 'package:acadmiat/features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_quizz_info_entity.dart';
import '../../entities/myquizizz_entity.dart';


class GetMyQuizizzInfoUseCase implements UseCase<MyQuizzInfoEntity, GetMyQuizizzInfoParams> {
  final MyCoursesRepository repository;
  GetMyQuizizzInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, MyQuizzInfoEntity>> call(GetMyQuizizzInfoParams params) {
    return repository.getMyQuizizzInfo(params);
  }
}

class GetMyQuizizzInfoParams {
  int userId;
  int quizzId;
  GetMyQuizizzInfoParams({required this.quizzId, required this.userId});
}
