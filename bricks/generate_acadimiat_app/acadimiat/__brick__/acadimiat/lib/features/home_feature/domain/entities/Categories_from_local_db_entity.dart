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

final int categoryId;
final String image;
final String name;
final int numberOfCourses;

}