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

 final int id;
 final dynamic decisionId;
 final DateTime repliedAt;
 final int userId;
 final DateTime attendanceAt;
 final String opinion;
 final List<dynamic> comments;
}