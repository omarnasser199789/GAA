import 'package:equatable/equatable.dart';

class MyBookmarksEntity extends Equatable {
  int bookmarkId;
  int lectureId;
  int courseId;
  String lecture;
  String course;
  double atTime;
  String notes;
  String unit;

  MyBookmarksEntity({
    required this.bookmarkId,
    required this.lectureId,
    required this.courseId,
    required this.lecture,
    required this.course,
    required this.atTime,
    required this.notes,
    required this.unit,
  });

  @override
  // TODO: implement props
  List<Object> get props =>
      [bookmarkId, lectureId, courseId, lecture, course, atTime, notes, unit];
}
