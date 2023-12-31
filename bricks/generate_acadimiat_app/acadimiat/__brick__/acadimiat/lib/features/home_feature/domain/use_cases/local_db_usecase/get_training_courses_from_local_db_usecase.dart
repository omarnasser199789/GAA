import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/diplomas_and_packages_entity.dart';
import '../../entities/training_courses_entity.dart';
import '../../repositories/latestP_repository.dart';


class GetTrainingCoursesFromLocaleDBUseCase implements UseCase<List<TrainingCoursesEntity>,String> {
  final HomeRepository repository;
  GetTrainingCoursesFromLocaleDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<TrainingCoursesEntity>>> call(String noParams) {
    return repository.getTrainingCourses(noParams);
  }
}



