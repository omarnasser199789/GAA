import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/latestp_entity.dart';
import '../repositories/latestP_repository.dart';

class GetLatestPUseCase implements UseCase<List<LatestPEntity>, String> {
  final HomeRepository repository;
  GetLatestPUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LatestPEntity>>> call(String params) {
    return repository.getLatestP();
  }
}



