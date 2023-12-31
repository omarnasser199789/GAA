import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

import '../repositories/cart_repository.dart';


class PaymentUseCase implements UseCase<Map<String, dynamic>?, PaymentParams> {
  final MyCartRepository repository;
  PaymentUseCase({required this.repository});
  @override
  Future<Either<Failure,Map<String, dynamic>?>> call(PaymentParams params) {

    return repository.payment(params);
  }
}
class PaymentParams{
  PaymentParams({
    required this.context,
    required this.total,
});
  double total;
  BuildContext  context;
}
