import 'package:equatable/equatable.dart';
 class CouponEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

  CouponEntity({
    required  this.type,
    required  this.productId,
  });

 final int type;
 final int productId;
}