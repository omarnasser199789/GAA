import 'package:equatable/equatable.dart';
class SearchEntity extends Equatable{
  SearchEntity({
    required  this.id,
    required  this.header,
    required  this.authorized,
    required  this.discount,
    required  this.image,
    required  this.squareImage,
    required  this.courseLink,
    required  this.trainer,
    required  this.numberOfCourses,
    required  this.featured,
    required  this.fromDate,
    required  this.toDate,
    required  this.categoryId,
    required  this.price,
    required  this.isCourse,
    required  this.newPrice,
    required  this.discountPercentage,
    required  this.category,
    required  this.duration,
    required  this.courseDate,
  });

 final int id;
 final String header;
 final bool authorized;
 final bool discount;
 final String image;
 final String squareImage;
 final String courseLink;
 final String trainer;
 final int numberOfCourses;
 final dynamic featured;
 final dynamic fromDate;
 final dynamic toDate;
 final int categoryId;
 final double price;
 final dynamic isCourse;
 final double newPrice;
 final int discountPercentage;
 final String category;
 final dynamic duration;
 final dynamic courseDate;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}