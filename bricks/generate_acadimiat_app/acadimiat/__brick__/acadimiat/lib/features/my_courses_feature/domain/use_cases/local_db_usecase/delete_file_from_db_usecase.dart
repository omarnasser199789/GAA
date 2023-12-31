import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/files_model.dart';
import '../../repositories/consultations_repository.dart';


class DeleteFileFromLocalDBUseCase implements UseCase<int, FilesModel> {
  final MyCoursesRepository repository;
  DeleteFileFromLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(FilesModel files) {

    return repository.deleteFile(files);
  }
}
