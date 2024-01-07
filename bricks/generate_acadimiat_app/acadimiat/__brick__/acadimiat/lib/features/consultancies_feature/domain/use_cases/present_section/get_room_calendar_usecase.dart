import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../repositories/currencies_repository.dart';

class GetRoomCalendarUseCase implements UseCase<List<int>, int> {
  final MyConsultanciesRepository repository;
  GetRoomCalendarUseCase({required this.repository});
  @override
  Future<Either<Failure, List<int>>> call(int id) {
    return repository.getRoomCalendar(id);
  }
}
