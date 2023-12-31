import 'package:equatable/equatable.dart';

import '../../data/models/course_case_study_model.dart';
class CourseCaseStudyEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  CourseCaseStudyEntity({
    required  this.casestudyId,
    required  this.open,
    required  this.header,
    required  this.body,
      this.solution,
      this.attendanceTable,
  });

  int casestudyId;
  bool open;
  String header;
  String body;
  Solution  ? solution;
  AttendanceTable ?  attendanceTable;
}