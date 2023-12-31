import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/fav_entity.dart';
import '../../repositories/latestP_repository.dart';





class GetAllProductFromFavLocalDBUseCase implements UseCase<List<FavEntity>,String> {
  final HomeRepository repository;
  GetAllProductFromFavLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<FavEntity>>> call(String params) {
    return repository.getAllProductFromFav(params);
  }
}
