import 'package:equatable/equatable.dart';
class TrainingCoursesEntity extends Equatable{

  TrainingCoursesEntity({
    required  this.id,
    required  this.apiId,
    required  this.image,
    required  this.courseName,
    required  this.trainerName,
    required  this.newPrice,
    required  this.oldPrice,
    required  this.fav,
  });

  int id;
  int apiId;
  String image;
  String courseName;
  String trainerName;
  double newPrice;
  double oldPrice;
  int fav;

  @override
  // TODO: implement props
  List<Object?> get props => [id,apiId,image,courseName,trainerName,newPrice,oldPrice,fav];
}