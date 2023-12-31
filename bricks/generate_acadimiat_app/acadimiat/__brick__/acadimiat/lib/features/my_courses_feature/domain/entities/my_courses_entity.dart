import 'package:equatable/equatable.dart';

class MyCoursesEntity extends Equatable{
  int id;
  String header;
  bool authorized;
  String image;
  String courseLink;
  String trainer;
  int percent;
  double total;
  bool isCourse;
  bool hasBeforeQuizz;

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