import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/assignment_entity.dart';
import '../../repositories/consultations_repository.dart';


class PostNewAssignmentUseCase implements UseCase< int, PostNewAssignmentParams> {
  final MyCoursesRepository repository;
  PostNewAssignmentUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(PostNewAssignmentParams getAssignmentParams) {
    return repository.postNewAssignment(getAssignmentParams);
  }
}//


class PostNewAssignmentParams{
  int userId;
  Uint8List file;
  String fileName;
  int assignmentId;

  PostNewAssignmentParams({
    required this.userId,
    required this.file,
    required this.fileName,
    required this.assignmentId
  });
}
