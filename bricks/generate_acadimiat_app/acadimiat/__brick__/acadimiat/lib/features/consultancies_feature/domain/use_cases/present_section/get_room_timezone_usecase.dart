import 'package:dartz/dartz.dart';
import '../../../../../../../core/error/failures.dart';
import '../../../../../../../core/usecases/usecase.dart';
import '../../repositories/currencies_repository.dart';


class GetRoomTimezoneUseCase implements UseCase<String, int> {
  final MyConsultanciesRepository repository;
  GetRoomTimezoneUseCase({required this.repository});
  @override
  Future<Either<Failure,String>> call(int id) {
    return repository.getRoomTimezone(id);
  }
}