import 'package:equatable/equatable.dart';

import '../../data/models/assignment_model.dart';

class AssignmentEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
  AssignmentEntity({
    required  this.assignmentId,
    required  this.assignment,
    required  this.body,
    required  this.courseName,
    required  this.courseId,
    required  this.isAccepted,
    required  this.canAttend,
    required  this.allAccepted,
    required  this.allPending,
    required  this.allDeclined,
    required  this.attempts,
  });

  int assignmentId;
  String assignment;
  String body;
  dynamic courseName;
  int courseId;
  bool isAccepted;
  bool canAttend;
  int allAccepted;
  int allPending;
  int allDeclined;
  List<Attempt> attempts;
}