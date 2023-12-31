import 'package:equatable/equatable.dart';
class CategoriesFromLocalDBEntity extends Equatable{


  @override
  List<Object?> get props => [categoryId,image,name,numberOfCourses];


  CategoriesFromLocalDBEntity({
    required  this.categoryId,
    required  this.image,
    required  this.name,
    required  this.numberOfCourses,
  });

  int categoryId;
  String image;
  String name;
  int numberOfCourses;
}