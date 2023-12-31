import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../entities/consultation_session_entity.dart';
import '../../repositories/currencies_repository.dart';

class GetConsultationSessionsUseCase implements UseCase<List<ConsultationSessionEntity>, int> {
  final MyConsultanciesRepository repository;
  GetConsultationSessionsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<ConsultationSessionEntity>>> call(int consultationID) {
    return repository.getConsultationSession(consultationID);
  }
}


