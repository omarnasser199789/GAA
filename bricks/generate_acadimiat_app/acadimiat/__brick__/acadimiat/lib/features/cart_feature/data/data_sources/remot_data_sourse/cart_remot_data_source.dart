import 'package:http/http.dart' as http;
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/apply_coupon_to_cart_usecase.dart';
import '../../../domain/use_cases/enable_courses_usecase.dart';
import '../../../domain/use_cases/payment_usecase.dart';
import '../../models/apply_coupon_model.dart';
import 'cart_remot_data_source_function.dart';


abstract class MyCartRemoteDataSource {
  Future< List<ApplyCouponModel>> applyCouponParams(ApplyCouponParams params);
  Future<Map<String, dynamic>?> payment(PaymentParams params);
  Future<int> enableCourses(EnableCoursesParams params);

}

class MyCartRemoteDataSourceImpl implements MyCartRemoteDataSource {
  final http.Client client;

  MyCartRemoteDataSourceImpl({required this.client});
  CartRemoteDataFunctions function = CartRemoteDataFunctions();

  @override
  Future< List<ApplyCouponModel>> applyCouponParams(ApplyCouponParams params) {
    return function.applyCouponParams('$baseUrl/v1/coupon/${params.coupon}',params.couponsList);
  }


  @override
  Future<Map<String, dynamic>?> payment(PaymentParams params) async {
    return function.payment(params: params);

  }

  @override
  Future<int> enableCourses(EnableCoursesParams params) {
    return function.enableCourses('$baseUrl/v1/mobile_payment',params);
  }


}
