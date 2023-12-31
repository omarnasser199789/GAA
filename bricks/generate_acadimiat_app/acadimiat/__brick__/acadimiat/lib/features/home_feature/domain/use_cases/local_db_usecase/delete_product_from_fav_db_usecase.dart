import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';





class DeleteProductFromFavLocalDBUseCase implements UseCase<int,int> {
  final HomeRepository repository;
  DeleteProductFromFavLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(int id) {
    return repository.deleteProductFromFav(id);
  }
}


