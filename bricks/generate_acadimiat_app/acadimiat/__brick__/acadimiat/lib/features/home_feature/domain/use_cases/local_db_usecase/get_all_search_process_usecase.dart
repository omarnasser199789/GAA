import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/fav_entity.dart';
import '../../entities/search_process_entity.dart';
import '../../repositories/latestP_repository.dart';





class GetAllSearchProcessFromLocalDBUseCase implements UseCase<List<SearchProcessEntity>,String> {
  final HomeRepository repository;
  GetAllSearchProcessFromLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<SearchProcessEntity> >> call(String noParams) {
    return repository.getAllSearchProcess();
  }
}
