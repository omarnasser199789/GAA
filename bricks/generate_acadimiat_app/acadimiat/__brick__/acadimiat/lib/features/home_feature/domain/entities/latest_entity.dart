import 'package:equatable/equatable.dart';

import '../../../../core/classes/category.dart';

class LatestEntity extends Equatable{


  int id;
  String header;
  bool authorized;
  bool discount;
  String image;
  String squareImage;
  String courseLink;
  String trainer;
  dynamic numberOfCourses;
  List<Category> categories;
  double price;
  dynamic isCourse;
  dynamic newPrice;

  LatestEntity({
    required this.id,
    required this.header,
    required this.authorized,
    required this.discount,
    required this.image,
    required this.squareImage,
    required this.courseLink,
    required this.trainer,
    required this.numberOfCourses,
    required this.categories,
    required this.price,
    required this.isCourse,
    required this.newPrice,
  });


  @override
  List<Object> get props => [id,authorized,discount,image,squareImage,
    courseLink,trainer,numberOfCourses,categories,price,isCourse,newPrice,header];

}