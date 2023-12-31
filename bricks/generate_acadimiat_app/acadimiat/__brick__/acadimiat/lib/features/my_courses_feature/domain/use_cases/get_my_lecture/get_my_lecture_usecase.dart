import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import '../../../../../core/classes/user.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_course_entity.dart';
import '../../entities/my_courses_entity.dart';
import '../../entities/my_lecture_entity.dart';
import '../../entities/sign_cookie_entity.dart';
import '../../repositories/consultations_repository.dart';


class MyLectureUseCase implements UseCase< MyLectureEntity, MyLectureParams> {
  final MyCoursesRepository repository;
  MyLectureUseCase({required this.repository});
  @override
  Future<Either<Failure, MyLectureEntity>> call(MyLectureParams params) {
    return repository.getMyLecture(params);
  }
}

class MyLectureParams{
  int userId;
  int lectureId;
  MyLectureParams({required this.userId,required this.lectureId});

}
