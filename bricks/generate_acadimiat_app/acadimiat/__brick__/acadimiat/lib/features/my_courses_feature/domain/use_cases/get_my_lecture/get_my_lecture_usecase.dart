import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_lecture_entity.dart';
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
