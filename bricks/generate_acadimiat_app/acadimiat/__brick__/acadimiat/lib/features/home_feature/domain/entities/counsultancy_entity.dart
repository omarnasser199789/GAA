
import 'package:equatable/equatable.dart';

import '../../data/models/package_model.dart';
class PackageEntity extends Equatable{
  @override
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

 final int packageId;
 final String packageName;
 final String packageImage;
 final double packagePrice;
 final String packageLink;
 final List<Course> courses;
 final double mainPrice;
 final double currentPrice;
}