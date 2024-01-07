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

 final int id;
 final String courseName;
 final int preCourseQuizzId;
 final String courseLink;
 final int progress;
 final String courseCover;
 final dynamic courseVideo;
 final CourseRecord courseRecord;
 final List<Trainer> trainers;
 final List<CourseContent> courseContents;
 final List<Quizz> quizz;
 final dynamic currentLecture;
 final List<Assignment> assignments;
 final Wiki wiki;
 final Forum forum;
 final Glossary glossary;
 final List<CaseStudy> caseStudy;
}