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

  int id;
  int userId;
  int answerId;
  int caseId;
  int correctAnswerId;
  String correctAnswer;
  dynamic email;
  dynamic solution;
  String explanation;
  String explanation2;
  bool isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime date;

}