
import 'package:equatable/equatable.dart';
import '../../data/models/fav_model.dart';
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

  int  id;
  int apiId;
  int productType;
  String name;
  String image;
  String trainer;
  double newPrice;
  double oldPrice;
  int fav;


  @override
  // TODO: implement props
  List<Object?> get props =>[id,apiId,productType,name,image,trainer,newPrice,oldPrice,fav];
}