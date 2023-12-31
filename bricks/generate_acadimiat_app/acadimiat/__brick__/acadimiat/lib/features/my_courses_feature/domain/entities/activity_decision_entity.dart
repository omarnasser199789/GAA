import 'package:equatable/equatable.dart';
class ActivityDecisionEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  ActivityDecisionEntity({
    required  this.id,
    required  this.decisionId,
    required  this.repliedAt,
    required  this.userId,
    required  this.attendanceAt,
    required  this.opinion,
    required  this.comments,
  });

  int id;
  dynamic decisionId;
  DateTime repliedAt;
  int userId;
  DateTime attendanceAt;
  String opinion;
  List<dynamic> comments;
}