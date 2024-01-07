import 'package:dartz/dartz.dart';
import '../../features/my_courses_feature/domain/use_cases/get_my_courses_usecase.dart';
import '../classes/user.dart';
import '../error/failures.dart';

//type is a return type of what else than call function
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams  extends Params{
  NoParams() : super(new User());
  @override
  List<Object> get props => [];
}
