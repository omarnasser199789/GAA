import 'dart:convert';

import '../../domain/entities/my_bookmarks_entity.dart';


List<MyBookmarksModel> myBookmarksModelFromJson(String str) =>
    List<MyBookmarksModel>.from(
        json.decode(str).map((x) => MyBookmarksModel.fromJson(x)));

String myBookmarksModelToJson(List<MyBookmarksModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBookmarksModel extends MyBookmarksEntity {
  MyBookmarksModel({
    required this.bookmarkId,
    required this.lectureId,
    required this.courseId,
    required this.lecture,
    required this.course,
    required this.atTime,
    required this.notes,
    required this.unit,
  }) : super(
            bookmarkId: bookmarkId,
            lectureId: lectureId,
            courseId: courseId,
            lecture: lecture,
            course: course,
            atTime: atTime,
            notes: notes,
            unit: unit);

  int bookmarkId;
  int lectureId;
  int courseId;
  String lecture;
  String course;
  double atTime;
  String notes;
  String unit;

  factory MyBookmarksModel.fromJson(Map<String, dynamic> json) =>
      MyBookmarksModel(
        bookmarkId: json["bookmarkId"],
        lectureId: json["lectureId"],
        courseId: json["courseId"],
        lecture: json["lecture"],
        course: json["course"],
        atTime: json["atTime"],
        notes: json["notes"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "bookmarkId": bookmarkId,
        "lectureId": lectureId,
        "courseId": courseId,
        "lecture": lecture,
        "course": course,
        "atTime": atTime,
        "notes": notes,
        "unit": unit,
      };
}
