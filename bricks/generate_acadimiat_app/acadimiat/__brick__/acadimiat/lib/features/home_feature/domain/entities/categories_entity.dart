import 'package:equatable/equatable.dart';
class CategoriesEntity extends Equatable{
  CategoriesEntity({
    required  this.categoryId,
    required  this.categoryName,
    required  this.categoryCourses,
  });

  int categoryId;
  String categoryName;
  int categoryCourses;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}