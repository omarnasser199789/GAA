import '../../domain/use_cases/add_product_in_local_db_usecase.dart';
import '../../domain/use_cases/apply_coupon_to_cart_usecase.dart';
import '../../domain/use_cases/enable_courses_usecase.dart';

abstract class MyCartEvent {}

class GetAllProductsFromCart extends MyCartEvent {

}

class AddProductToCart extends MyCartEvent {
  AddProductParams params;
  AddProductToCart({
    required this.params
  });
}

class DeleteProductToCart extends MyCartEvent {
  int id;
  DeleteProductToCart({
    required this.id
  });
}

class DeleteAllProductsFromCart extends MyCartEvent {}

class RestartEvent extends MyCartEvent {}

class EnableCoursesEvent extends MyCartEvent {
  EnableCoursesEvent({
    required this.params,
});
  EnableCoursesParams params;

}

class ApplyCouponEvent extends MyCartEvent {
  ApplyCouponParams applyCouponParams;
  ApplyCouponEvent({
    required this.applyCouponParams
  });
}

class CheckIfProductIsExitEvent extends MyCartEvent {
  int id;
  CheckIfProductIsExitEvent({
    required this.id
  });
}

