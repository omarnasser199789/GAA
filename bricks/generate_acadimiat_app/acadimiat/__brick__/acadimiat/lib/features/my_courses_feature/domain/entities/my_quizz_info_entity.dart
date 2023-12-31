
import 'package:acadmiat/features/my_courses_feature/data/models/my_quizz_info_model.dart';
import 'package:equatable/equatable.dart';

class MyQuizzInfoEntity extends Equatable{


  @override
  List<Object?> get props => throw UnimplementedError();
  MyQuizzInfoEntity({
    required  this.quizzId,
    required  this.quizzName,
    required  this.totalAttempts,
    required  this.totalTime,
    required  this.hasPassword,
    required  this.minScore,
    required  this.beforeStart,
    required  this.optional,
    required  this.myAttempts,
  });

  int quizzId;
  String quizzName;
  int totalAttempts;
  int totalTime;
  bool hasPassword;
  double minScore;
  bool beforeStart;
  bool optional;
  List<MyAttempt> myAttempts;

}