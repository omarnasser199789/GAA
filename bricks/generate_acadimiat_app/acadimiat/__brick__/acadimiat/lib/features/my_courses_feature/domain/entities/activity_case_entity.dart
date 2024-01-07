import 'package:equatable/equatable.dart';

class ActivityCaseEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ActivityCaseEntity({
    required  this.id,
    required  this.userId,
    required  this.answerId,
    required  this.caseId,
    required  this.correctAnswerId,
    required  this.correctAnswer,
    required  this.email,
    required  this.solution,
    required  this.explanation,
    required  this.explanation2,
    required  this.isCorrect,
    required  this.reply,
    required  this.answer,
    required  this.date,
  });

 final int id;
 final int userId;
 final int answerId;
 final int caseId;
 final int correctAnswerId;
 final String correctAnswer;
 final dynamic email;
 final dynamic solution;
 final String explanation;
 final String explanation2;
 final bool isCorrect;
 final dynamic reply;
 final dynamic answer;
 final DateTime date;

}