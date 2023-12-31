import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/assignment_entity.dart';
import '../../repositories/consultations_repository.dart';


class GetAssignmentUseCase implements UseCase< AssignmentEntity, GetAssignmentParams> {
  final MyCoursesRepository repository;
  GetAssignmentUseCase({required this.repository});
  @override
  Future<Either<Failure, AssignmentEntity>> call(GetAssignmentParams getAssignmentParams) {
    return repository.getAssignment(getAssignmentParams);
  }
}//


class GetAssignmentParams{
  int userId;
  int courseId;
  int assignmentId;

  GetAssignmentParams({
    required this.userId,
    required this.courseId,
    required this.assignmentId
});
}
