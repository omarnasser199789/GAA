import 'package:acadmiat/features/consultancies_feature/domain/entities/my_consultancies_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../entities/consultancies_entity.dart';
import '../../repositories/currencies_repository.dart';

class GetMyConsultanciesUseCase implements UseCase<List<MyConsultanciesEntity>, int> {
  final MyConsultanciesRepository repository;
  GetMyConsultanciesUseCase({required this.repository});
  @override
  Future<Either<Failure, List<MyConsultanciesEntity>>> call(int userId) {
    return repository.getMyConsultancies(userId);
  }
}


