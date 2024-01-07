import 'package:acadmiat/features/cart_feature/domain/use_cases/apply_coupon_to_cart_usecase.dart';
import 'package:acadmiat/features/cart_feature/domain/use_cases/enable_courses_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/apply_coupon_entity.dart';
import '../../domain/entities/files_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/use_cases/add_product_in_local_db_usecase.dart';
import '../../domain/use_cases/payment_usecase.dart';
import '../data_sources/local_data_source/myCart_local_data_source.dart';
import '../data_sources/remot_data_sourse/cart_remot_data_source.dart';
import 'mycart_repository_functions.dart';

class MyCartRepositoryImpl implements MyCartRepository {

  final MyCartLocalDataSource myCartLocalDataSource;
  final MyCartRemoteDataSource myCartRemoteDataSource;
  ConsultationsRepositoryFunctions functions = ConsultationsRepositoryFunctions();
  MyCartRepositoryImpl({
    required this.myCartLocalDataSource,
    required this.myCartRemoteDataSource,
  });

  @override
  Future<Either<Failure, int>> addProduct(AddProductParams params) async{
    return await functions.statusCode(() {
      return myCartLocalDataSource.addProduct(params);
    });
  }

  @override
  Future<Either<Failure, CartEntity>> getProductsFromLocaleDB() async{
    return await functions.convertToCartEntity(() {
      return myCartLocalDataSource.getProductsFromLocaleDB();
    });
  }

  @override
  Future<Either<Failure, int>> deleteProduct(int id)async {
    return await functions.statusCode(() {
      return myCartLocalDataSource.deleteProduct(id);
    });
  }

  @override
  Future<Either<Failure, int>> checkIfProductIsExitInDB(int id)async {
    return await functions.statusCode(() {
      return myCartLocalDataSource.checkIfProductIsExitInDB(id);
    });
  }

  @override
  Future<Either<Failure,List<ApplyCouponEntity>>> applyCouponParams(ApplyCouponParams params) async{
    return await functions.applyCouponParams(() {
      return myCartRemoteDataSource.applyCouponParams(params);
    });
  }

  @override
  Future<Either<Failure, int>> deleteAllProducts() async{
    return await functions.statusCode(() {
      return myCartLocalDataSource.deleteAllProducts();
    });
  }

  @override
  Future<Either<Failure,Map<String, dynamic>?>> payment(PaymentParams params) async {
    return await functions.payment(() {
      return myCartRemoteDataSource.payment(params);
    });
  }

  @override
  Future<Either<Failure, int>> enableCourses(EnableCoursesParams params) async {
    return await functions.statusCode(() {
      return myCartRemoteDataSource.enableCourses(params);
    });
  }





}
