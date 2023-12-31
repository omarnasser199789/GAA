import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/apply_coupon_entity.dart';
import '../repositories/cart_repository.dart';
import 'dart:convert';

/// In this case, the use case is responsible for applying a coupon to a cart, using the [ApplyCouponParams] object.
///
/// The [ApplyCouponToCartUseCase] class implements the [UseCase] interface, similar to the first example.
/// It takes an instance of [MyCartRepository] as input, which is likely an abstraction over the cart in the application.
///
/// The [call] method is the main method of the use case, which takes an instance of [ApplyCouponParams] as input and returns a [Future] that resolves to either a Failure or a list of ApplyCouponEntity.
/// The [ApplyCouponParams] likely contains information about the coupon to be applied, such as its code or discount amount.
///
/// The implementation of the call method delegates the responsibility of applying the coupon to the repository instance by calling its [applyCouponParams] method with the params as input.
/// The [applyCouponParams] method likely performs the actual logic of applying the coupon to the cart and returns a [Future] that resolves to either a Failure or a list of ApplyCouponEntity, which represent the updated cart after applying the coupon.
///
/// Overall, this code appears to be a simple and straightforward implementation of a use case responsible for applying a coupon to a cart.
class ApplyCouponToCartUseCase implements UseCase< List<ApplyCouponEntity>, ApplyCouponParams> {
  final MyCartRepository repository;
  ApplyCouponToCartUseCase({required this.repository});
  @override
    Future<Either<Failure, List<ApplyCouponEntity>>> call(ApplyCouponParams params) {
    return repository.applyCouponParams(params);
  }
}


class ApplyCouponParams{
  List<CouponsList> couponsList;
  String coupon;
  ApplyCouponParams(
  {required this.couponsList,
    required this.coupon,});
}



List<CouponsList> couponsListFromJson(String str) => List<CouponsList>.from(json.decode(str).map((x) => CouponsList.fromJson(x)));

String couponsListToJson(List<CouponsList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CouponsList {
  CouponsList({
  required  this.type,
  required  this.productId,
  });

  int type;
  int productId;

  factory CouponsList.fromJson(Map<String, dynamic> json) => CouponsList(
    type: json["type"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "productId": productId,
  };
}


