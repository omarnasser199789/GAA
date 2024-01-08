import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';

import '../../data/models/files_model.dart';
import '../../data/models/my_courses_model.dart';
import '../../domain/entities/my_course_entity.dart';
import '../../domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../domain/use_cases/activity_case_usecase.dart';
import '../../domain/use_cases/activity_filling_usecase.dart';
import '../../domain/use_cases/activity_logical_usecase.dart';
import '../../domain/use_cases/activity_match_usecase.dart';
import '../../domain/use_cases/activity_quizz_usecase.dart';
import '../../domain/use_cases/add_bookmark_usecase.dart';
import '../../domain/use_cases/add_comment_usecase.dart';
import '../../domain/use_cases/Assignment/get_assignment.dart';
import '../../domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../domain/use_cases/case_study/activity_decision_usecase.dart';
import '../../domain/use_cases/case_study/attendcase_usecase.dart';
import '../../domain/use_cases/case_study/course_case_study_usecase.dart';
import '../../domain/use_cases/get_my_course/get_my_course_usecase.dart';
import '../../domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import '../../domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import '../../domain/use_cases/post_concept_usecase.dart';
import '../../domain/use_cases/submit_quiz_usecase.dart';
import '../../domain/use_cases/topic_reply_usecase.dart';
import '../../domain/use_cases/wiki/article_details_usecase.dart';

abstract class MyCoursesEvent {}

 class GetMyCourses extends MyCoursesEvent {}
 class GetMyQuizizzInfoEvent extends MyCoursesEvent {
   GetMyQuizizzInfoParams getMyQuizizzInfoParams;
   GetMyQuizizzInfoEvent({
     required this.getMyQuizizzInfoParams
 });
 }

class GetAssignmentEvent extends MyCoursesEvent {
  GetAssignmentParams getAssignmentParams;
  GetAssignmentEvent({
    required this.getAssignmentParams
  });
}

class PostNewAssignmentEvent extends MyCoursesEvent {
  PostNewAssignmentParams postNewAssignmentParams;
  PostNewAssignmentEvent({
    required this.postNewAssignmentParams
  });
}

class PostConceptEvent extends MyCoursesEvent {
  PostConceptParams params;
  PostConceptEvent({
    required this.params
  });
}
class AddFileEvent extends MyCoursesEvent {
  AddFileParams params;
  AddFileEvent({
    required this.params
  });
}
class GetFileByUrlEvent extends MyCoursesEvent {
  GetFileParams params;
GetFileByUrlEvent({
    required this.params
  });
}
class GetAllFilesEvent extends MyCoursesEvent {

}
class TopicReplyEvent extends MyCoursesEvent {
  TopicReplyParams params;
  TopicReplyEvent({
    required this.params
  });
}
class CourseCaseStudyEvent extends MyCoursesEvent {
  CourseCaseStudyParams params;
  CourseCaseStudyEvent({
    required this.params
  });
}

class ArticleDetailsEvent extends MyCoursesEvent {
  ArticleDetailsParams params;
  ArticleDetailsEvent({
    required this.params
  });
}
class ActivityFillingEvent extends MyCoursesEvent {
  ActivityFillingParams params;
  ActivityFillingEvent({
    required this.params
  });
}
class ActivityMatchingEvent extends MyCoursesEvent {
  ActivityMatchParams params;
  ActivityMatchingEvent({
    required this.params
  });
}

class ActivityLogicalEvent extends MyCoursesEvent {
  ActivityLogicalParams params;
  ActivityLogicalEvent({
    required this.params
  });
}
class ActivityCaseEvent extends MyCoursesEvent {
  ActivityCaseParams  params;
  ActivityCaseEvent({
    required this.params
  });
}
class ActivityQuizzEvent extends MyCoursesEvent {
  ActivityQuizzParams  params;
  ActivityQuizzEvent({
    required this.params
  });
}
class AttendCaseEvent extends MyCoursesEvent {
  AttendCaseParams  params;
  AttendCaseEvent({
    required this.params
  });
}
class ActivityDecisionEvent extends MyCoursesEvent {
  ActivityDecisionParams  params;
  ActivityDecisionEvent({
    required this.params
  });
}
class DeleteFileFromDBEvent extends MyCoursesEvent {
  FilesModel  files;
  DeleteFileFromDBEvent({
    required this.files
  });
}
class DeleteAllFilesFromDBEvent extends MyCoursesEvent {
  FilesModel files;
  DeleteAllFilesFromDBEvent({required this.files});
}
class UpdateMyCoursesFromLocaleDBEvent extends MyCoursesEvent {
  List<MyCoursesModel> params;
  UpdateMyCoursesFromLocaleDBEvent({required this.params});
}
class GetMyCoursesFromLocaleDBEvent extends MyCoursesEvent {}
 class SubmitQuizEvent extends MyCoursesEvent {
   SubmitQuizParams submitQuizParams;
  SubmitQuizEvent({
   required this.submitQuizParams});
 }

class GetMyQuizizz extends MyCoursesEvent {
  GetMyQuizezzParams getMyQuizezzParams;

  GetMyQuizizz({
    required this.getMyQuizezzParams
  });

}

 class LaunchNewVideoEvent extends MyCoursesEvent {
   LaunchNewVideoEvent({
     required this.lectureId,
     required this.myCourseEntity,
     required this.index,
     required this.part,
     required this.courseCover,
   });
   final int lectureId;
   final MyCourseEntity myCourseEntity;
   final int index;
   final int part;
   final String courseCover;
 }

 class GetMyCourse extends MyCoursesEvent {
   GetMyCourse({required this.getMyCourseParams});
   GetMyCourseParams getMyCourseParams;
 }
 class GetMyLecture extends MyCoursesEvent {
   GetMyLecture({required this.myLectureParams});
   MyLectureParams myLectureParams;
 }
class GetSignCookie extends MyCoursesEvent {}
class InitVideo extends MyCoursesEvent {}


class GetDiscussionEvent extends MyCoursesEvent {
  int lectureId;
  GetDiscussionEvent({required this.lectureId});
}

class AddBookmarkEvent extends MyCoursesEvent {
  AddBookMarkParams addBookMarkParams;
  AddBookmarkEvent({required this.addBookMarkParams});
}
class DeleteBookmarkEvent extends MyCoursesEvent {
  int bookmarkId;
  DeleteBookmarkEvent({required this.bookmarkId});
}
class ResetEvent extends MyCoursesEvent {
  ResetEvent();

}

class AddCommentEvent extends MyCoursesEvent {
  AddCommentParams addCommentParams;
  AddCommentEvent({required this.addCommentParams});
}
