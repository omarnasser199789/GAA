import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../my_courses_feature/domain/use_cases/get_my_courses_usecase.dart';
import '../entities/counsultancy_entity.dart';
import '../entities/latestp_entity.dart';
import '../repositories/latestP_repository.dart';


class GetPackageByIdUseCase implements UseCase<PackageEntity, int> {
  final HomeRepository repository;
  GetPackageByIdUseCase({required this.repository});

  @override
  Future<Either<Failure,PackageEntity>> call(int id) {
    return repository.getPackageById(id);
  }
}



