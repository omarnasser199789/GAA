import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../my_courses_feature/domain/use_cases/get_my_courses_usecase.dart';
import '../entities/counsultancy_entity.dart';
import '../entities/latestp_entity.dart';
import '../entities/search_entity.dart';
import '../repositories/latestP_repository.dart';


class SearchUseCase implements UseCase<List<SearchEntity>, String> {
  final HomeRepository repository;
  SearchUseCase({required this.repository});

  @override
  Future<Either<Failure,List<SearchEntity>>> call(String text) {
    return repository.search(text);
  }
}



