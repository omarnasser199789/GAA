import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/globals.dart';
import '../../../data/models/posts_model.dart';
import '../profile_state.dart';






Stream<TestState> GetTestSuccessOrErrorState(
    Either<Failure,  List<PostsModel>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (resCode) => SuccessGetEntity(
        resCode: resCode),
  );
}
Stream<TestState> SuccessGetPostOrErrorState(
    Either<Failure,  PostsModel> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (resCode) => SuccessGetPostEntity(
        resCode: resCode),
  );
}


String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}