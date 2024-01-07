import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/diplomas_and_packages_entity.dart';
import '../../repositories/latestP_repository.dart';

class GetDiplomasAndPackagesFromLocaleDBUseCase implements UseCase<List<DiplomasAndPackagesEntity>,String> {
  final HomeRepository repository;
  GetDiplomasAndPackagesFromLocaleDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<DiplomasAndPackagesEntity>>> call(String params) {
    return repository.getDiplomasAndPackages(params);
  }
}



