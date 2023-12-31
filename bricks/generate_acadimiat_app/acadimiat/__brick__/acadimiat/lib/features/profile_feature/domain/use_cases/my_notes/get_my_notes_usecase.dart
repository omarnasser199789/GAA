import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_notes_entity.dart';
import '../../entities/my_payments_entity.dart';
import '../../repositories/profile_repository.dart';


class GetMyNotesUseCase implements UseCase<MyNoteEntity, int> {
  final ProfileRepository repository;
  GetMyNotesUseCase({required this.repository});


  @override
  Future<Either<Failure, MyNoteEntity>> call(int userId) {
    return repository.getMyNotes(userId);
  }
}





