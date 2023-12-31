
import 'package:equatable/equatable.dart';

import '../../data/models/package_model.dart';
class PackageEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  PackageEntity({
    required  this.packageId,
    required  this.packageName,
    required  this.packageImage,
    required  this.packagePrice,
    required  this.packageLink,
    required  this.courses,
    required  this.mainPrice,
    required  this.currentPrice,
  });

  int packageId;
  String packageName;
  String packageImage;
  double packagePrice;
  String packageLink;
  List<Course> courses;
  double mainPrice;
  double currentPrice;
}