import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/apply_coupon_entity.dart';
import '../../domain/entities/files_entity.dart';


typedef Future<int> _StatusCode();
typedef Future<Map<String, dynamic>?> _Payment();
typedef Future<List<ApplyCouponEntity>> _ApplyCouponEntity();
typedef Future<CartEntity> _CartEntity();


class ConsultationsRepositoryFunctions {


  Future<Either<Failure, int>> statusCode(
      _StatusCode _statusCode,
      ) async {
    try {
      final remote = await _statusCode();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, Map<String, dynamic>?>> payment(
      _Payment _payment,
      ) async {
    try {
      final remote = await _payment();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<ApplyCouponEntity>>> applyCouponParams(
      _ApplyCouponEntity _applyCouponEntity,
      ) async {
    try {
      final remote = await _applyCouponEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }





  Future<Either<Failure, CartEntity>> convertToCartEntity(
      _CartEntity _cartEntity,
      ) async {
    try {
      final remote = await _cartEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }




}


