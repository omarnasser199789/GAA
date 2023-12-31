import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import '../../../../../core/classes/user.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_course_entity.dart';
import '../../entities/my_courses_entity.dart';
import '../../repositories/consultations_repository.dart';


class GetMyCourseUseCase implements UseCase< MyCourseEntity, GetMyCourseParams> {
  final MyCoursesRepository repository;
  GetMyCourseUseCase({required this.repository});
  @override
  Future<Either<Failure, MyCourseEntity>> call(GetMyCourseParams params) {
    return repository.getMyCourse( params);
  }
}

class GetMyCourseParams{
  int userId;
  int courseId;
  GetMyCourseParams({required this.userId,required this.courseId});

}
