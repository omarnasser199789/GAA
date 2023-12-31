import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/consultations_repository.dart';


class AddFileInLocalDBUseCase implements UseCase< int, AddFileParams> {
  final MyCoursesRepository repository;
  AddFileInLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(AddFileParams params) {

    return repository.addFile(params);
  }
}



class AddFileParams{
  final String name;
  final String path;
  final String url;


  const AddFileParams({
    required this.name,
    required this.path,
    required this.url,
  });

  // Convert a DogModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'url':url,
    };
  }

  // Implement toString to make it easier to see information about
  // each DogModel when using the print statement.
  @override
  String toString() {
    return 'DogModel{name: $name, path: $path , url:$path}';
  }
}