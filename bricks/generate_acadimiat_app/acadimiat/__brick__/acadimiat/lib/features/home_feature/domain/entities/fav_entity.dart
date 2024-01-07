import 'package:equatable/equatable.dart';

class FavEntity extends Equatable{
  FavEntity({
    required this.id,
    required  this.apiId,
    required  this.productType,
    required  this.name,
    required  this.image,
    required  this.trainer,
    required  this.newPrice,
    required  this.oldPrice,
    required  this.fav,
  });

 final int  id;
 final int apiId;
 final int productType;
 final String name;
 final String image;
 final String trainer;
 final double newPrice;
 final double oldPrice;
 final int fav;


  @override
  List<Object?> get props =>[id,apiId,productType,name,image,trainer,newPrice,oldPrice,fav];
}