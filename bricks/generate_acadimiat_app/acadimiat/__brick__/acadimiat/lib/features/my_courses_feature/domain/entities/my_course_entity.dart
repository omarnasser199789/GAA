import 'package:equatable/equatable.dart';

import '../../data/models/my_course_model.dart';



class MyCourseEntity extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  MyCourseEntity({
    required  this.id,
    required  this.courseName,
    required  this.preCourseQuizzId,
    required  this.courseLink,
    required  this.progress,
    required  this.courseCover,
    required  this.courseVideo,
    required  this.courseRecord,
    required  this.trainers,
    required  this.courseContents,
    required  this.quizz,
    required  this.currentLecture,
    required  this.assignments,
    required  this.wiki,
    required  this.forum,
    required  this.glossary,
    required  this.caseStudy,
  });

  int id;
  String courseName;
  int preCourseQuizzId;
  String courseLink;
  int progress;
  String courseCover;
  dynamic courseVideo;
  CourseRecord courseRecord;
  List<Trainer> trainers;
  List<CourseContent> courseContents;
  List<Quizz> quizz;
  dynamic currentLecture;
  List<Assignment> assignments;
  Wiki wiki;
  Forum forum;
  Glossary glossary;
  List<CaseStudy> caseStudy;
}