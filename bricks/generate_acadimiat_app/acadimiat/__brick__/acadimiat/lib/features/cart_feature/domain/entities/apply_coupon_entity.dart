
import 'package:equatable/equatable.dart';

class ApplyCouponEntity extends Equatable{

  ApplyCouponEntity({
    required  this.courseId,
    required  this.type,
    required  this.couponId,
    required  this.code,
    required  this.isActive,
    required  this.amount,
    required  this.status,
  });

 final int courseId;
 final int type;
 final int couponId;
 final String code;
 final bool isActive;
 final double amount;
 final String status;

  @override
  List<Object?> get props => [courseId];
}