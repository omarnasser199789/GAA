import 'package:equatable/equatable.dart';

class MyCoursesEntity extends Equatable{
 final int id;
 final String header;
 final bool authorized;
 final String image;
 final String courseLink;
 final String trainer;
 final int percent;
 final double total;
 final bool isCourse;
 final bool hasBeforeQuizz;

  MyCoursesEntity({
    required this.id,
    required this.header,
    required this.authorized,
    required this.image,
    required this.courseLink,
    required this.trainer,
    required this.percent,
    required this.total,
    required this.isCourse,
    required this.hasBeforeQuizz,

});
  @override
  List<Object> get props => [];}