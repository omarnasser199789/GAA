import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_courses_entity.dart';
import '../../entities/my_courses_from_local_db_entity.dart';
import '../../repositories/consultations_repository.dart';


class GetMyCoursesFromLocaleDBUseCase implements UseCase<List<MyCoursesEntity>,String> {
  final MyCoursesRepository repository;
  GetMyCoursesFromLocaleDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<MyCoursesEntity>>> call(String params) {
    return repository.getMyCoursesFromLocalDb(params);
  }
}



