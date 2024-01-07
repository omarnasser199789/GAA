import "package:equatable/equatable.dart";
import '../../../../core/classes/order.dart';

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

 final int id;
 final int userId;
 final dynamic email;
 final int questionId;
 final dynamic isCorrect;
 final dynamic reply;
 final dynamic answer;
 final DateTime date;
 final List<Order> orders;
}