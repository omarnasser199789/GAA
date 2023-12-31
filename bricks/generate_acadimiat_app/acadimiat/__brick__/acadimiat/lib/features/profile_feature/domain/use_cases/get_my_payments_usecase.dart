import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/my_payments_entity.dart';
import '../repositories/profile_repository.dart';


class GetMyPaymentsUseCase implements UseCase<List<MyPaymentEntity>, String> {
  final ProfileRepository repository;
  GetMyPaymentsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MyPaymentEntity>>> call(String userId) {
    return repository.getMyPaymentsList(userId);
  }
}





