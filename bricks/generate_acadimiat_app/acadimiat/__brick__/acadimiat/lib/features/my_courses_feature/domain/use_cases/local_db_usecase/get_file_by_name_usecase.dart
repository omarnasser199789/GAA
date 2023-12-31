import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/files_entity.dart';
import '../../repositories/consultations_repository.dart';


class GetFileByUrlUseCase implements UseCase< FilesEntity, GetFileParams> {
  final MyCoursesRepository repository;
  GetFileByUrlUseCase({required this.repository});
  @override
  Future<Either<Failure, FilesEntity>> call(GetFileParams params) {

    return repository.getFileByUrl(params);
  }
}

class GetFileParams{
  int index;
  String url;
  GetFileParams({required this.index,required this.url});
}


