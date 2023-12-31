
import 'package:equatable/equatable.dart';

import '../../data/models/my_assignments_model.dart';

class MyAssignmentsEntity extends Equatable {
  int assignmentId;
  String assignment;
  String courseName;
  int courseId;
  bool isAccepted;
  int allAccepted;
  int allDeclined;
  List<Attempt> attempts;

  MyAssignmentsEntity({
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
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
