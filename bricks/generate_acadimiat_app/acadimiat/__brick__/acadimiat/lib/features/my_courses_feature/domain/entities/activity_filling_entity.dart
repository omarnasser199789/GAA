import 'package:equatable/equatable.dart';
import '../../../../core/classes/word_type4.dart';
class ActivityFillingEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
  ActivityFillingEntity({
    required  this.id,
    required  this.userId,
    required  this.email,
    required  this.questionId,
    required  this.sentence,
    required  this.correct,
    required  this.isCorrect,
    required  this.reply,
    required  this.answer,
    required  this.date,
    required  this.words,
  });

 final int id;
 final int userId;
 final dynamic email;
 final int questionId;
 final dynamic sentence;
 final dynamic correct;
 final dynamic isCorrect;
 final dynamic reply;
 final dynamic answer;
 final DateTime date;
 final List<WordType4> words;
}