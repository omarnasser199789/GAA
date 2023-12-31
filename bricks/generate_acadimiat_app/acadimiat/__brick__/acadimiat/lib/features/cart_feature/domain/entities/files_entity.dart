import 'package:equatable/equatable.dart';

import '../../data/models/cart_model.dart';

class CartEntity extends Equatable{

  CartEntity({
  required this.carts,
  });

  List<Cart> carts;

  @override
  List<Object?> get props => [carts];

}