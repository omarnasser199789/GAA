import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';


class DeleteProductFromLocalDBUseCase implements UseCase< int, int> {
  final MyCartRepository repository;
  DeleteProductFromLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(int id) {

    return repository.deleteProduct(id);
  }
}


