import '../../domain/entities/apply_coupon_entity.dart';
import '../../domain/entities/files_entity.dart';



abstract class MyCartState {}

class MyCoursesInitial extends MyCartState {}
class Empty extends MyCartState {}
class Loading extends MyCartState {}

class Error extends MyCartState {
  final String message;

  Error({required this.message}); //we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [message];
}
class SuccessGetCartEntity extends MyCartState {
  CartEntity cartEntity;
  SuccessGetCartEntity({required this.cartEntity});
}

class SuccessDeleteProductFromCartEntity extends MyCartState {
  int statusCode;
  SuccessDeleteProductFromCartEntity({required this.statusCode});
}

class SuccessApplyCouponEntity extends MyCartState {
  List<ApplyCouponEntity> applyCouponEntity;
  SuccessApplyCouponEntity({required this.applyCouponEntity});
}

class SuccessCheckProductEntity extends MyCartState {
  int statusCode;
  SuccessCheckProductEntity({required this.statusCode});
}

class SuccessEnableCoursesState extends MyCartState {
  int statusCode;
  SuccessEnableCoursesState({required this.statusCode});
}

class SuccessPaymentEntity extends MyCartState {
  Map<String, dynamic>? map;
  SuccessPaymentEntity({required this.map});
}

