import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_notes_entity.dart';
import '../../entities/my_payments_entity.dart';
import '../../entities/my_plans_entity.dart';
import '../../repositories/profile_repository.dart';


class GetMyPlansUseCase implements UseCase<List<MyPlansEntity>, int> {
  final ProfileRepository repository;
  GetMyPlansUseCase({required this.repository});


  @override
  Future<Either<Failure, List<MyPlansEntity>>> call(int userId) {
    return repository.getMyPlans(userId);
  }
}





