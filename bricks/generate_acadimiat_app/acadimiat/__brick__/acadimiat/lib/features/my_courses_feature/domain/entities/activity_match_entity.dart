import 'package:equatable/equatable.dart';

import '../../../../core/classes/matched.dart';
import '../../data/models/activity_match_model.dart';
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

  int id;
  int userId;
  dynamic questionId;
  dynamic email;
  dynamic isCorrect;
  DateTime date;
  List<Matched> matched;
}