import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/Categories_from_local_db_entity.dart';
import '../../entities/consultancies_from_local_db_entity.dart';
import '../../repositories/latestP_repository.dart';


class GetCategoriesFromLocalDBUseCase implements UseCase<List<CategoriesFromLocalDBEntity>,String> {
  final HomeRepository repository;
  GetCategoriesFromLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<CategoriesFromLocalDBEntity>>> call(String noParams) {
    return repository.getCategoriesFromLocalDB(noParams);
  }
}



