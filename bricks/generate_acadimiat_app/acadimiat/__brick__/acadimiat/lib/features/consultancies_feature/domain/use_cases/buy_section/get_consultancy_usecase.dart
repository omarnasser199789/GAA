import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../entities/consultancy_entity.dart';
import '../../repositories/currencies_repository.dart';

class GetConsultancyUseCase implements UseCase<ConsultancyEntity, int> {
  final MyConsultanciesRepository repository;
  GetConsultancyUseCase({required this.repository});
  @override
  Future<Either<Failure,ConsultancyEntity>> call(int id) {
    return repository.getConsultancy(id);
  }
}


