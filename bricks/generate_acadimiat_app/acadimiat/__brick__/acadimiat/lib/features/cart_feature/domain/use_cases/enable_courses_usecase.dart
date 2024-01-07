import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/cart_repository.dart';
import 'dart:convert';


class EnableCoursesUseCase implements UseCase< int, EnableCoursesParams> {
  final MyCartRepository repository;
  EnableCoursesUseCase({required this.repository});
  @override
  Future<Either<Failure,int>> call(EnableCoursesParams params) {
    return repository.enableCourses(params);
  }
}




EnableCoursesParams enableCoursesParamsFromJson(String str) => EnableCoursesParams.fromJson(json.decode(str));

String enableCoursesParamsToJson(EnableCoursesParams data) => json.encode(data.toJson());

class EnableCoursesParams {
  EnableCoursesParams({
  required this.email,
  required this.token,
  required this.invoiceId,
  required this.cart,
  });

  String email;
  String token;
  String invoiceId;
  List<Cart> cart;

  factory EnableCoursesParams.fromJson(Map<String, dynamic> json) => EnableCoursesParams(
    email: json["email"],
    token: json["token"],
    invoiceId: json["invoiceId"],
    cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "token": token,
    "invoiceId": invoiceId,
    "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
  };
}

class Cart {
  Cart({

  required this.type,
  required this.couponApplied,
   this.couponCode,
  required this.productId,
  required this.productImage,
   this.affiliateCode,
  required this.productName,
  required this.productPrice,
  required this.productOPrice,
  });


  int type;
  bool couponApplied;
  String ? couponCode;
  int productId;
  String productImage;
  String? affiliateCode;
  String productName;
  double productPrice;
  double productOPrice;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(

    type: json["type"],
    couponApplied: json["couponApplied"],
    couponCode: json["couponCode"],
    productId: json["productId"],
    productImage: json["productImage"],

    affiliateCode: json["affiliateCode"],

    productName: json["productName"],
    productPrice: json["productPrice"].toDouble(),
    productOPrice: json["productOPrice"],
  );

  Map<String, dynamic> toJson() => {

    "type": type,
    "couponApplied": couponApplied,
    "couponCode": couponCode,
    "productId": productId,
    "productImage": productImage,
    "affiliateCode":(affiliateCode!=null)? affiliateCode:"",
    "productName": productName,
    "productPrice": productPrice,
    "productOPrice": productOPrice,
  };
}
