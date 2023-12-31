import "package:equatable/equatable.dart";

import '../../../../core/classes/order.dart';
import '../../data/models/activity_logical_model.dart';
class ActiveLogicalEntity extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ActiveLogicalEntity({
    required  this.id,
    required  this.userId,
    required  this.email,
    required  this.questionId,
    required  this.isCorrect,
    required  this.reply,
    required  this.answer,
    required  this.date,
    required  this.orders,
  });

  int id;
  int userId;
  dynamic email;
  int questionId;
  dynamic isCorrect;
  dynamic reply;
  dynamic answer;
  DateTime date;
  List<Order> orders;
}