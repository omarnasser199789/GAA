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

 final int assignmentId;
 final String assignment;
 final String body;
 final dynamic courseName;
 final int courseId;
 final bool isAccepted;
 final bool canAttend;
 final int allAccepted;
 final int allPending;
 final int allDeclined;
 final List<Attempt> attempts;
}