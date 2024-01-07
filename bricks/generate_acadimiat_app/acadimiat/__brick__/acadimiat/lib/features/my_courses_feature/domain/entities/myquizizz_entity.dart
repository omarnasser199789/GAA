import 'package:equatable/equatable.dart';
import '../../../../core/classes/question.dart';


class MyQuizizzEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
  MyQuizizzEntity({
    required  this.id,
    required  this.materialId,
    required  this.courseId,
      this.unitId,
    required  this.name,
    required  this.beforeStart,
    required  this.optional,
    required  this.timeLimit,
    required  this.shuffle,
    required  this.repetition,
    required  this.myAttempts,
    required  this.ifPassed,
    required  this.ifFailed,
    required  this.minScore,
    required  this.attendance,
    required  this.questions,
  });

 final int id;
 final dynamic materialId;
 final int courseId;
 final int  ? unitId;
 final String name;
 final bool beforeStart;
 final bool optional;
 final int timeLimit;
 final bool shuffle;
 final int repetition;
 final int myAttempts;
 final int ifPassed;
 final int ifFailed;
 final double minScore;
 final dynamic attendance;
 final List<Question> questions;
}