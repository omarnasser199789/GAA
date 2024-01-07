import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/profile_repository.dart';


class DeletePlanUseCase implements UseCase<int, int> {
  final ProfileRepository repository;
  DeletePlanUseCase({required this.repository});


  @override
  Future<Either<Failure,int>> call(int planId) {
    return repository.deletePlan(planId);
  }
}





