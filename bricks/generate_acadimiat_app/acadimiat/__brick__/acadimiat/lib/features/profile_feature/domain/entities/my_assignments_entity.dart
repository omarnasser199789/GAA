import 'package:equatable/equatable.dart';
import '../../data/models/my_assignments_model.dart';

class MyAssignmentsEntity extends Equatable {
  final int assignmentId;
  final String assignment;
  final String courseName;
  final int courseId;
  final bool isAccepted;
  final int allAccepted;
  final int allDeclined;
  final List<Attempt> attempts;

  const MyAssignmentsEntity({
    required this.assignmentId,
    required this.assignment,
    required this.courseName,
    required this.courseId,
    required this.isAccepted,
    required this.allAccepted,
    required this.allDeclined,
    required this.attempts,
    
  });

  @override
  List<Object> get props => [assignmentId];
}
