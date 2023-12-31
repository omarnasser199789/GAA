import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';


class CheckIfProductIsExitInDBUseCase implements UseCase< int, int> {
  final MyCartRepository repository;
  CheckIfProductIsExitInDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(int id) {

    return repository.checkIfProductIsExitInDB(id);
  }
}



