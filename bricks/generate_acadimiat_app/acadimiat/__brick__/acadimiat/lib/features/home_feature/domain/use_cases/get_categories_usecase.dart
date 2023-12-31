import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../entities/categories_entity.dart';
import '../repositories/latestP_repository.dart';




class GetCategoriesUseCase implements UseCase<List<CategoriesEntity>, String> {
  final HomeRepository repository;
  GetCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CategoriesEntity>>> call(String params) {
    return repository.getCategories("");
  }
}



