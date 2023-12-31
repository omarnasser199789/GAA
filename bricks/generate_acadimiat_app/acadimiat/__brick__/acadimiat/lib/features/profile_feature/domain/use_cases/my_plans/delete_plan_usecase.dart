import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_notes_entity.dart';
import '../../entities/my_payments_entity.dart';
import '../../entities/my_plans_entity.dart';
import '../../repositories/profile_repository.dart';


class DeletePlanUseCase implements UseCase<int, int> {
  final ProfileRepository repository;
  DeletePlanUseCase({required this.repository});


  @override
  Future<Either<Failure,int>> call(int planId) {
    return repository.deletePlan(planId);
  }
}





