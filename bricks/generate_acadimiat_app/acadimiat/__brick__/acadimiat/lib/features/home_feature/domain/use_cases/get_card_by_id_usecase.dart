import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/card_by_id_entity.dart';
import '../repositories/latestP_repository.dart';

class GetCardByIdUseCase implements UseCase<CardByIdEntity, int> {
  final HomeRepository repository;
  GetCardByIdUseCase({required this.repository});

  @override
  Future<Either<Failure,CardByIdEntity>> call(int id) {
    return repository.getCardById(id);
  }
}



