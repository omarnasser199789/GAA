import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/profile_repository.dart';


class DeleteNoteUseCase implements UseCase<int, int> {
  final ProfileRepository repository;
  DeleteNoteUseCase({required this.repository});


  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteNote(id);
  }
}





