import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';





class AddSearchProcessToLocalDBUseCase implements UseCase<int,String> {
  final HomeRepository repository;
  AddSearchProcessToLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(String text) {
    return repository.addSearchProcess(text);
  }
}


