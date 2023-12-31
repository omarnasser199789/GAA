
import 'package:equatable/equatable.dart';

import '../../data/models/apply_coupon_model.dart';
class ApplyCouponEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


  ApplyCouponEntity({
    required  this.courseId,
    required  this.type,
    required  this.couponId,
    required  this.code,
    required  this.isActive,
    required  this.amount,
    required  this.status,

  });

  int courseId;
  int type;
  int couponId;
  String code;
  bool isActive;
  double amount;
  String status;
}