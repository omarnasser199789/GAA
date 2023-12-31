import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';





class DeleteAllSearchProcessFromDBUseCase implements UseCase<int,int> {
  final HomeRepository repository;
  DeleteAllSearchProcessFromDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(int id) {
    return repository.deleteAllSearchProcess();
  }
}


