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

  int apiId;
  String image;
  String name;
  int percent;
}