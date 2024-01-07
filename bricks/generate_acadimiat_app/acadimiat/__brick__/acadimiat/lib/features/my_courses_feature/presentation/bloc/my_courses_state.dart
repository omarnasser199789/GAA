



import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';

import '../../domain/entities/BookmarkEntity.dart';
import '../../domain/entities/activity_case_entity.dart';
import '../../domain/entities/activity_decision_entity.dart';
import '../../domain/entities/activity_filling_entity.dart';
import '../../domain/entities/activity_logical_entity.dart';
import '../../domain/entities/activity_match_entity.dart';
import '../../domain/entities/activity_quizz_entity.dart';
import '../../domain/entities/article_details_entity.dart';
import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/concept_entity.dart';
import '../../domain/entities/course_case_study_entity.dart';
import '../../domain/entities/discussion_entity.dart';
import '../../domain/entities/files_entity.dart';
import '../../domain/entities/my_course_entity.dart';
import '../../domain/entities/my_courses_entity.dart';
import '../../domain/entities/my_lecture_entity.dart';
import '../../domain/entities/my_quizz_info_entity.dart';
import '../../domain/entities/sign_cookie_entity.dart';
import '../../domain/entities/topic_reply_entity.dart';

abstract class MyCoursesState {}

class MyCoursesInitial extends MyCoursesState {}
class Empty extends MyCoursesState {}
class Loading extends MyCoursesState {}
class SuccessGetMyQuizizz extends MyCoursesState {
  MyQuizizzEntity myQuizizzEntity;
  SuccessGetMyQuizizz({
    required this.myQuizizzEntity
  });
}
class SuccessSubmitQuizState extends MyCoursesState {
  int statusCode;
  SuccessSubmitQuizState({
    required this.statusCode
  });
}
class SuccessGetQuizizzInfoState extends MyCoursesState {
  MyQuizzInfoEntity myQuizzInfoEntity;
  SuccessGetQuizizzInfoState({
    required this.myQuizzInfoEntity
  });
}
class SuccessAssignmentEntityState extends MyCoursesState {
  AssignmentEntity assignmentEntity;
  SuccessAssignmentEntityState({
    required this.assignmentEntity
  });
}
class SuccessPostNewAssignmentEntityState extends MyCoursesState {
  int  statusCode;
  SuccessPostNewAssignmentEntityState({
    required this.statusCode
  });
}
class SuccessPostConceptEntityState extends MyCoursesState {
  ConceptEntity  conceptEntity;
  SuccessPostConceptEntityState({
    required this.conceptEntity
  });
}
class SuccessAddFileEntityState extends MyCoursesState {
  int  statusCode;
  SuccessAddFileEntityState({
    required this.statusCode
  });
}
class SuccessGetFileEntityState extends MyCoursesState {
  FilesEntity  filesEntity;
  SuccessGetFileEntityState({
    required this.filesEntity
  });
}
class SuccessTopicReplyState extends MyCoursesState {
  TopicReplyEntity  topicReplyEntity;
  SuccessTopicReplyState({
    required this.topicReplyEntity
  });
}
class SuccessCourseCaseStudyState extends MyCoursesState {
  CourseCaseStudyEntity  courseCaseStudyEntity;
  SuccessCourseCaseStudyState({
    required this.courseCaseStudyEntity
  });
}
class SuccessArticleDetailsState extends MyCoursesState {
  ArticleDetailsEntity  articleDetailsEntity;
  SuccessArticleDetailsState({
    required this.articleDetailsEntity
  });
}
class SuccessActivityFillingState extends MyCoursesState {
  ActivityFillingEntity  activityFillingEntity;
  SuccessActivityFillingState({
    required this.activityFillingEntity
  });
}
class SuccessActivityQuizzState extends MyCoursesState {
  ActivityQuizzEntity  activityQuizzEntity;
  SuccessActivityQuizzState({
    required this.activityQuizzEntity
  });
}
class SuccessAttendCaseState extends MyCoursesState {
  int  statusCode;
  SuccessAttendCaseState({
    required this.statusCode
  });
}
class SuccessDeleteFileFromDBState extends MyCoursesState {
  int  statusCode;
  SuccessDeleteFileFromDBState({
    required this.statusCode
  });
}
class SuccessGetMyCoursesFromLocaleDBState extends MyCoursesState {
    List<MyCoursesEntity>  myCoursesEntity;
  SuccessGetMyCoursesFromLocaleDBState({
    required this.myCoursesEntity
  });
}
class SuccessActivityDecisionEntityState extends MyCoursesState {
  ActivityDecisionEntity  activityDecisionEntity;
  SuccessActivityDecisionEntityState({
    required this.activityDecisionEntity
  });
}
class SuccessActivityMatchingState extends MyCoursesState {
  ActivityMatchEntity  activityMatchEntity;
  SuccessActivityMatchingState({
    required this.activityMatchEntity
  });
}
class SuccessActiveLogicalState extends MyCoursesState {
  ActiveLogicalEntity  activeLogicalEntity;
  SuccessActiveLogicalState({
    required this.activeLogicalEntity
  });
}

class SuccessActivityCaseState extends MyCoursesState {
  ActivityCaseEntity  activityCaseEntity;
  SuccessActivityCaseState({
    required this.activityCaseEntity
  });
}


class Error extends MyCoursesState {
  final String message;

  Error({required this.message});//we use this constructor in ((BLOC & test))

  List<Object> get props => [message];
}
class NotActiveSubscriptionState extends MyCoursesState {
  final String message;

  NotActiveSubscriptionState({required this.message});//we use this constructor in ((BLOC & test))

  List<Object> get props => [message];
}

class Loaded extends MyCoursesState {
  final  List<MyCoursesEntity> myCoursesEntity;//Entities form domain

  Loaded({required this.myCoursesEntity});//we use this constructor in ((BLOC & test))

  List<Object> get props => [myCoursesEntity];
}
class SuccessGetMyCourse extends MyCoursesState {
  final MyCourseEntity myCourseEntity;//Entities form domain

  SuccessGetMyCourse({required this.myCourseEntity});//we use this constructor in ((BLOC & test))


}
class SuccessGetSignCookieEntity extends MyCoursesState {
  final SignCookieEntity signCookieEntity;//Entities form domain

  SuccessGetSignCookieEntity({required this.signCookieEntity});//we use this constructor in ((BLOC & test))

}

class SuccessGetMyLectureEntity extends MyCoursesState {
  final MyLectureEntity myLectureEntity;//Entities form domain

  SuccessGetMyLectureEntity({required this.myLectureEntity});//we use this constructor in ((BLOC & test))

}
class SuccessGetDiscussionEntity extends MyCoursesState {
  final DiscussionEntity discussionEntity;//Entities form domain

  SuccessGetDiscussionEntity({required this.discussionEntity});//we use this constructor in ((BLOC & test))

}
class SuccessInitVideo extends MyCoursesState {
}

class SuccessAddBookmarkEntity extends MyCoursesState {

  BookmarkEntity bookmarkEntity;
  SuccessAddBookmarkEntity({
    required this.bookmarkEntity
});
}

class SuccessDeleteBookmark extends MyCoursesState {

  int statusCode;
  SuccessDeleteBookmark({
    required this.statusCode
});
}
class SuccessAddComment extends MyCoursesState {

  int statusCode;
  SuccessAddComment({
    required this.statusCode
});
}



