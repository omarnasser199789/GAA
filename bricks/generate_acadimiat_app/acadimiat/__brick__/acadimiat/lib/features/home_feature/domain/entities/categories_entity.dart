import 'package:equatable/equatable.dart';
class CategoriesEntity extends Equatable{
  CategoriesEntity({
    required  this.categoryId,
    required  this.categoryName,
    required  this.categoryCourses,
  });

 final int categoryId;
 final String categoryName;
 final int categoryCourses;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}