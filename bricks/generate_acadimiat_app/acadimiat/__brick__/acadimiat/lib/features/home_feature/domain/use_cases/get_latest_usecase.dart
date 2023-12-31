import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../my_courses_feature/domain/use_cases/get_my_courses_usecase.dart';
import '../entities/latest_entity.dart';
import '../repositories/latestP_repository.dart';




class GetLatestUseCase implements UseCase<List<LatestEntity>, bool> {
  final HomeRepository repository;
  GetLatestUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LatestEntity>>> call(bool isNew) {
    return repository.getLatest(isNew);
  }
}



