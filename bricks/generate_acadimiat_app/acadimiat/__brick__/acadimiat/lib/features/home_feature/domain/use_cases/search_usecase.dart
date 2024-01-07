import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
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



