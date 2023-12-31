import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';


class DeleteAllProductFromLocalDBUseCase implements UseCase< int, String> {
  final MyCartRepository repository;
  DeleteAllProductFromLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(String noParams) {

    return repository.deleteAllProducts();
  }
}


