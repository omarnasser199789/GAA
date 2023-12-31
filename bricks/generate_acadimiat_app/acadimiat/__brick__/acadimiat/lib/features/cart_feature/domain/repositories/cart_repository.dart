import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/apply_coupon_entity.dart';
import '../entities/files_entity.dart';
import '../use_cases/add_product_in_local_db_usecase.dart';
import '../use_cases/apply_coupon_to_cart_usecase.dart';
import '../../../home_feature/domain/use_cases/check_purchase_usecase.dart';
import '../use_cases/enable_courses_usecase.dart';
import '../use_cases/payment_usecase.dart';

abstract class MyCartRepository{
  Future<Either<Failure,int>> deleteProduct(int id);
  Future<Either<Failure,int>> addProduct(AddProductParams params);
  Future<Either<Failure,CartEntity>> getProductsFromLocaleDB();
  Future<Either<Failure,int>> checkIfProductIsExitInDB(int id);
  Future<Either<Failure,List<ApplyCouponEntity>>> applyCouponParams(ApplyCouponParams params);
  Future<Either<Failure,int>> deleteAllProducts();
  Future<Either<Failure,Map<String, dynamic>?>> payment(PaymentParams params);
  Future<Either<Failure,int>> enableCourses(EnableCoursesParams params);





}