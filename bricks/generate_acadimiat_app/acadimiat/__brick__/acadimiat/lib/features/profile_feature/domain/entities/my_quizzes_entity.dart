import 'package:equatable/equatable.dart';

class MyQuizzesEntity extends Equatable{


  int quizzId;
  String quizzName;
  String courseName;
  int courseId;
  double progress;
  double mark;
  bool isPassed;
  DateTime date;


  MyQuizzesEntity({
    required this.quizzId,
    required this.quizzName,
    required this.courseName,
    required this.courseId,
    required this.progress,
    required this.mark,
    required this.isPassed,
    required this.date,

});
  @override
  List<Object> get props => [quizzId,quizzName,courseName,courseId,progress,mark,isPassed,date];

}