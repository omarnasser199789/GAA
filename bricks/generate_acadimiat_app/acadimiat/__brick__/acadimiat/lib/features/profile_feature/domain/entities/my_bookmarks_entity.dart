import 'package:equatable/equatable.dart';

class MyBookmarksEntity extends Equatable {
  final int bookmarkId;
  final int lectureId;
  final int courseId;
  final String lecture;
  final String course;
  final double atTime;
  final String notes;
  final String unit;

  const MyBookmarksEntity({
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
  List<Object> get props =>
      [bookmarkId, lectureId, courseId, lecture, course, atTime, notes, unit];
}
