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

 final int casestudyId;
 final bool open;
 final String header;
 final String body;
 final Solution  ? solution;
 final AttendanceTable ?  attendanceTable;
}