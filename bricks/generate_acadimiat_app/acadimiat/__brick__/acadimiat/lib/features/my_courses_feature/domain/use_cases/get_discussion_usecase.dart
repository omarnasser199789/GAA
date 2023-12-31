import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/discussion_entity.dart';
import '../repositories/consultations_repository.dart';


class GetDiscussionUseCase implements UseCase< DiscussionEntity, int> {
  final MyCoursesRepository repository;
  GetDiscussionUseCase({required this.repository});
  @override
  Future<Either<Failure, DiscussionEntity>> call(int lectureId) {
    return repository.getDiscussion(lectureId);
  }
}
