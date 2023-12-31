import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/consultancies_from_local_db_entity.dart';
import '../../repositories/latestP_repository.dart';


class GetConsultanciesFromLocalDBUseCase implements UseCase<List<ConsultanciesFromLocalDbEntity>,String> {
  final HomeRepository repository;
  GetConsultanciesFromLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,List<ConsultanciesFromLocalDbEntity>>> call(String params) {
    return repository.getConsultanciesFromLocalDB(params);
  }
}



