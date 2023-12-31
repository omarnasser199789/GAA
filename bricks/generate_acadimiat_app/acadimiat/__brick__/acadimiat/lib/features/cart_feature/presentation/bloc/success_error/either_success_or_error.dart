
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/globals.dart';
import '../../../domain/entities/apply_coupon_entity.dart';
import '../../../domain/entities/files_entity.dart';
import '../my_cart_state.dart';




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




Stream<MyCartState> cartEntityLoadedOrErrorState(
    Either<Failure,CartEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (cartEntity) => SuccessGetCartEntity(
            cartEntity: cartEntity),
  );
}



Stream<MyCartState> productDeleteFromCartOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessDeleteProductFromCartEntity(
            statusCode: statusCode),
  );
}

Stream<MyCartState> successApplyCouponOrErrorState(
    Either<Failure,List<ApplyCouponEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (applyCouponEntity) => SuccessApplyCouponEntity(
            applyCouponEntity: applyCouponEntity),
  );
}

Stream<MyCartState> successCheckIfProductIsExitOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessCheckProductEntity(
            statusCode: statusCode),
  );
}
Stream<MyCartState> successPaymentOrErrorState(
    Either<Failure,Map<String, dynamic>?> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (map) => SuccessPaymentEntity(
            map: map),
  );
}
Stream<MyCartState> successEnableCoursesOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessEnableCoursesState(
            statusCode: statusCode),
  );
}



