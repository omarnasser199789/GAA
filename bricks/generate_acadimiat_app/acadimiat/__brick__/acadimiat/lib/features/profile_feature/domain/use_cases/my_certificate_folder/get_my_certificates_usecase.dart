
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_certificates_entity.dart';
import '../../repositories/profile_repository.dart';


class GetMyCertificatesUseCase implements UseCase<List<MyCertificatesEntity>, int> {
  final ProfileRepository repository;
  GetMyCertificatesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MyCertificatesEntity>>> call(int userId) {
    return repository.getCertificatesList(userId);
  }
}
