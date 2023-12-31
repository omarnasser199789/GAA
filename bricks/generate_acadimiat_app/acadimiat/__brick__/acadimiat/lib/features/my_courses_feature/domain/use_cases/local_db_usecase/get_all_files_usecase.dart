import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../entities/files_entity.dart';
import '../../repositories/consultations_repository.dart';


class GetAllFilesUseCase implements UseCase<FilesEntity, String> {
  final MyCoursesRepository repository;
  GetAllFilesUseCase({required this.repository});
  @override
  Future<Either<Failure, FilesEntity>> call(String noParams) {

    return repository.getAllFiles(noParams);
  }
}

class GetFileParams{
  int index;
  String url;
  GetFileParams({required this.index,required this.url});
}


