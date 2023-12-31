import 'package:acadmiat/features/my_courses_feature/data/models/myqizz_model.dart';
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

  int id;
  dynamic materialId;
  int courseId;
  int  ? unitId;
  String name;
  bool beforeStart;
  bool optional;
  int timeLimit;
  bool shuffle;
  int repetition;
  int myAttempts;
  int ifPassed;
  int ifFailed;
  double minScore;
  dynamic attendance;
  List<Question> questions;
}