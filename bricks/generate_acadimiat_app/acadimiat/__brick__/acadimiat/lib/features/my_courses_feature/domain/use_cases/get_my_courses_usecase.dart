import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/classes/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/my_courses_entity.dart';
import '../repositories/consultations_repository.dart';


class GetMyCoursesUseCase implements UseCase< List<MyCoursesEntity>, Params> {
  final MyCoursesRepository repository;
  GetMyCoursesUseCase({required this.repository});
  @override
  Future<Either<Failure,  List<MyCoursesEntity> >> call(Params params) {
    return repository.getMyCourses();
  }
}




class Params extends Equatable {
  final User  user;

  Params( this.user) ;

  @override
  List<Object> get props => [user];
}

