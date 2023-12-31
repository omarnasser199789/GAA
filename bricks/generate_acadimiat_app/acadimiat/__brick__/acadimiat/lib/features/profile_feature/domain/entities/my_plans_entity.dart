import 'package:equatable/equatable.dart';
class MyPlansEntity extends Equatable {
  MyPlansEntity({
    required  this.planId,
    required  this.fromDate,
    required  this.toDate,
    required  this.progress,
    required  this.daysLeft,
  });

  int planId;
  DateTime fromDate;
  DateTime toDate;
  int progress;
  int daysLeft;

  @override
  List<Object?> get props =>   [planId, fromDate, toDate, progress, daysLeft];
}