import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/banners_entity.dart';
import '../repositories/latestP_repository.dart';

class GetBannersUseCase implements UseCase<List<BannersEntity>, String> {
  final HomeRepository repository;
  GetBannersUseCase({required this.repository});

  @override
  Future<Either<Failure,  List<BannersEntity>>> call(String params) {
    return repository.getBanners();
  }
}



