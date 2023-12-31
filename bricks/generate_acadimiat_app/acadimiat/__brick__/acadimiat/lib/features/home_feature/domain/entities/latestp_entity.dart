import 'package:equatable/equatable.dart';

class LatestPEntity extends Equatable{


 final int id;
 final String header;
 final bool authorized;
 final bool discount;
 final String image;
 final String squareImage;
 final String courseLink;
 final String trainer;
 final int numberOfCourses;
 final int categoryId;
 final double price;
 final bool isCourse;
 final double newPrice;
 final String appleId;
 final String googleId;

  LatestPEntity({
    required this.header,
    required this.id,
    required this.authorized,
    required this.discount,
    required this.image,
    required this.squareImage,
    required this.courseLink,
    required this.trainer,
    required this.numberOfCourses,
    required this.categoryId,
    required this.price,
    required this.isCourse,
    required this.newPrice,
    required this.appleId,
    required this.googleId
});


  @override
  List<Object> get props => [id,authorized,discount,image,squareImage,
    courseLink,trainer,numberOfCourses,categoryId,price,isCourse,newPrice,header];

}