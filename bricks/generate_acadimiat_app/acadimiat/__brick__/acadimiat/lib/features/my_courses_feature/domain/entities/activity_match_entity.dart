import 'package:equatable/equatable.dart';
import '../../../../core/classes/matched.dart';

class ActivityMatchEntity extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  ActivityMatchEntity({
    required  this.id,
    required  this.userId,
    required  this.questionId,
    required  this.email,
    required  this.isCorrect,
    required  this.date,
    required  this.matched,
  });

 final int id;
 final int userId;
 final dynamic questionId;
 final dynamic email;
 final dynamic isCorrect;
 final DateTime date;
 final List<Matched> matched;
}