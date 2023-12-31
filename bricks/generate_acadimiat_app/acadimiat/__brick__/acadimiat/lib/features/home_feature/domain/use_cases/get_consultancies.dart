import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../repositories/latestP_repository.dart';




class GetConsultanciesUseCase implements UseCase<List<ConsultanciesEntity>, String> {
  final HomeRepository repository;
  GetConsultanciesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ConsultanciesEntity>>> call(String params) {
    return repository.getConsultancies();
  }
}



