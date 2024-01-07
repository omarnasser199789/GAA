import 'package:equatable/equatable.dart';
class MyCoursesFromLocalDbEntity extends Equatable{
  @override
  List<Object?> get props => [apiId,image,name,percent];


  MyCoursesFromLocalDbEntity({
    required  this.apiId,
    required  this.image,
    required  this.name,
    required  this.percent,
  });

 final int apiId;
 final String image;
 final String name;
 final int percent;
}