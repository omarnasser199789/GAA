import 'package:equatable/equatable.dart';
class MyPlansEntity extends Equatable {
  const MyPlansEntity({
    required  this.planId,
    required  this.fromDate,
    required  this.toDate,
    required  this.progress,
    required  this.daysLeft,
  });

  final int planId;
  final DateTime fromDate;
  final DateTime toDate;
  final int progress;
  final int daysLeft;

  @override
  List<Object?> get props =>   [planId, fromDate, toDate, progress, daysLeft];
}