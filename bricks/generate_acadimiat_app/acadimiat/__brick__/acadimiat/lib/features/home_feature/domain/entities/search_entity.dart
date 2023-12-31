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

  int id;
  String header;
  bool authorized;
  bool discount;
  String image;
  String squareImage;
  String courseLink;
  String trainer;
  int numberOfCourses;
  dynamic featured;
  dynamic fromDate;
  dynamic toDate;
  int categoryId;
  double price;
  dynamic isCourse;
  double newPrice;
  int discountPercentage;
  String category;
  dynamic duration;
  dynamic courseDate;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}