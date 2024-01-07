import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/counsultancy_entity.dart';
import '../repositories/latestP_repository.dart';

class GetPackageByIdUseCase implements UseCase<PackageEntity, int> {
  final HomeRepository repository;
  GetPackageByIdUseCase({required this.repository});

  @override
  Future<Either<Failure,PackageEntity>> call(int id) {
    return repository.getPackageById(id);
  }
}



