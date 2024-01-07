import 'package:equatable/equatable.dart';
class DiplomasAndPackagesEntity extends Equatable{

  DiplomasAndPackagesEntity({
    required  this.id,
    required  this.apiId,
    required  this.image,
    required  this.courseName,
    required  this.trainerName,
    required  this.newPrice,
    required  this.oldPrice,
    required  this.fav,
    required  this.isCourse,
    required this.numberOfCourses,
  });

 final int id;
 final int apiId;
 final String image;
 final String courseName;
 final String trainerName;
 final double newPrice;
 final double oldPrice;
 final int fav;
 final int isCourse;
 final int numberOfCourses;

  @override
  List<Object?> get props => [id,apiId,image,courseName,trainerName,newPrice,oldPrice,fav,isCourse,numberOfCourses];
}