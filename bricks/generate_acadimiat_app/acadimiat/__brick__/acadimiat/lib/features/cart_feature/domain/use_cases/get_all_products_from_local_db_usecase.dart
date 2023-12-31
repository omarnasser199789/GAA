import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/files_entity.dart';
import '../repositories/cart_repository.dart';


class GetAllProductsFromLocalDBUseCase implements UseCase<CartEntity, String> {
  final MyCartRepository repository;
  GetAllProductsFromLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, CartEntity>> call(String noParams) {

    return repository.getProductsFromLocaleDB();
  }
}
