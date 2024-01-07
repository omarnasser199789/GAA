import 'package:equatable/equatable.dart';

class MyQuizzesEntity extends Equatable{

 final int quizzId;
 final String quizzName;
 final String courseName;
 final int courseId;
 final double progress;
 final double mark;
 final bool isPassed;
 final DateTime date;


  const MyQuizzesEntity({
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