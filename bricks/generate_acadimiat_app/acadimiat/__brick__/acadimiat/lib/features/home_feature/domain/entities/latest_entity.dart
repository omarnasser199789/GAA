import 'package:equatable/equatable.dart';

import '../../../../core/classes/category.dart';

class LatestEntity extends Equatable{


 final int id;
 final String header;
 final bool authorized;
 final bool discount;
 final String image;
 final String squareImage;
 final String courseLink;
 final String trainer;
 final dynamic numberOfCourses;
 final List<Category> categories;
 final double price;
 final dynamic isCourse;
 final dynamic newPrice;

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