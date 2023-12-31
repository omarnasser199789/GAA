import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/apply_coupon_to_cart_usecase.dart';
import '../../../domain/use_cases/enable_courses_usecase.dart';
import '../../../domain/use_cases/payment_usecase.dart';
import '../../models/apply_coupon_model.dart';
class CartRemoteDataFunctions {

  Future< List<ApplyCouponModel>> applyCouponParams(String url,List<CouponsList> couponsList) async {

    var client = http.Client();
    if (kDebugMode) {
      print(url);
      print(couponsListToJson(couponsList));
    }
    try {
      final response = await client
          .post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
        },
        body: couponsListToJson(couponsList),
      )
          .timeout(Duration(seconds: timeout));

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }


      if (response.statusCode == 200) {
        return  applyCouponModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }


  Future<int> enableCourses(String url,EnableCoursesParams params) async {
    var client = http.Client();
    JWT =  globalSH.getString(CACHED_JWT_TOKEN).toString();
    if (kDebugMode) {
      print(url);
      print(enableCoursesParamsToJson(params));
    }
    try {
      final response = await client
          .post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: enableCoursesParamsToJson(params),
      )
          .timeout(Duration(seconds: timeout));

      if (kDebugMode) {
        print(response.body);
      }


      if (response.statusCode == 200) {
        return  200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }



  Future<Map<String, dynamic>?> payment({required PaymentParams params}) async {
    Map<String, dynamic>? paymentIntent;
    String secretKey="sk_test_51Kx69uEekY6rrsbS5EHkDxcMF7rN9O2Bw0vYbqAFeZqwGB2XeyXZGfDGRS3rSan1VRu6WiIAcgLwNk5o9K9I4IuR00sIayNdN0";

    try {
      Map<String, dynamic> body = {
        'amount':calculateAmount(params.total),
        'currency': 'USD',
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (kDebugMode) {
        print('Payment Intent Body->>> ${response.body.toString()}');
      }



      return jsonDecode(response.body);

    } catch (e) {
      if (kDebugMode) {
        print('err charging user: ${e.toString()}');
      }
    }
    return paymentIntent;
  }

  calculateAmount(double amount) {
    final calculatedAmount = (int.parse("${(amount*100).round()}")) ;
    return calculatedAmount.toString();
  }

}
