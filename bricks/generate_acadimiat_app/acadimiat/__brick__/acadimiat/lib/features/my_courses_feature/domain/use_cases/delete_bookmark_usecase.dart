import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/consultations_repository.dart';


class DeleteBookmarkUseCase implements UseCase< int, int> {
  final MyCoursesRepository repository;
  DeleteBookmarkUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(int bookmarkId) {
    return repository.deleteBookmark(bookmarkId);
  }
}
