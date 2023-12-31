import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_match_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/globals.dart';
import '../../../domain/entities/BookmarkEntity.dart';
import '../../../domain/entities/activity_case_entity.dart';
import '../../../domain/entities/activity_decision_entity.dart';
import '../../../domain/entities/activity_filling_entity.dart';
import '../../../domain/entities/activity_logical_entity.dart';
import '../../../domain/entities/activity_quizz_entity.dart';
import '../../../domain/entities/article_details_entity.dart';
import '../../../domain/entities/assignment_entity.dart';
import '../../../domain/entities/concept_entity.dart';
import '../../../domain/entities/course_case_study_entity.dart';
import '../../../domain/entities/discussion_entity.dart';
import '../../../domain/entities/files_entity.dart';
import '../../../domain/entities/my_course_entity.dart';
import '../../../domain/entities/my_courses_entity.dart';
import '../../../domain/entities/my_courses_from_local_db_entity.dart';
import '../../../domain/entities/my_lecture_entity.dart';
import '../../../domain/entities/my_quizz_info_entity.dart';
import '../../../domain/entities/sign_cookie_entity.dart';
import '../../../domain/entities/topic_reply_entity.dart';
import '../my_courses_state.dart';
String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}


Stream<MyCoursesState> eitherLoadedOrErrorState(
    Either<Failure,  List<MyCoursesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myCoursesEntity) => Loaded(myCoursesEntity: myCoursesEntity),
  );
}


Stream<MyCoursesState> eitherGetMyCourseOrErrorState(
    Either<Failure, MyCourseEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => NotActiveSubscriptionState(message: _mapFailureToMessage(failure)),
        (myCourseEntity) => SuccessGetMyCourse(myCourseEntity: myCourseEntity),
  );
}
Stream<MyCoursesState> eitherSignCookieOrErrorState(
    Either<Failure, SignCookieEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (signCookieEntity) => SuccessGetSignCookieEntity(signCookieEntity: signCookieEntity),
  );
}
Stream<MyCoursesState> eitherSuccessGetMyLectureOrErrorState(
    Either<Failure, MyLectureEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myLectureEntity) => SuccessGetMyLectureEntity(myLectureEntity: myLectureEntity),
  );
}
Stream<MyCoursesState> eitherSuccessGetDiscussionEventOrErrorState(
    Either<Failure, DiscussionEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (discussionEntity) => SuccessGetDiscussionEntity(discussionEntity: discussionEntity),
  );
}
Stream<MyCoursesState> eitherSuccessAddBookmarkEventOrErrorState(
    Either<Failure, BookmarkEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (bookmarkEntity) => SuccessAddBookmarkEntity(bookmarkEntity: bookmarkEntity),
  );
}
Stream<MyCoursesState> eitherSuccessDeleteBookmarkEventOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessDeleteBookmark(statusCode: statusCode),
  );
}
Stream<MyCoursesState> eitherSuccessAddCommentEventOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessAddComment(statusCode: statusCode),
  );
}
Stream<MyCoursesState> eitherSuccessResetEventOrErrorState() async* {
  // yield failureOrSuccess.fold(
  //       (failure) => Error(message: _mapFailureToMessage(failure)),
  //       (statusCode) => Empty(),
  // );
  yield Empty();
}

Stream<MyCoursesState> eitherSuccessInitVideoOrErrorState(
    // Either<Failure, MyLectureEntity> failureOrSuccess,
    ) async* {
  yield SuccessInitVideo();
}


Stream<MyCoursesState> eitherSuccessGetMyQuizizzOrErrorState(
    Either<Failure,  MyQuizizzEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myQuizizzEntity) => SuccessGetMyQuizizz(myQuizizzEntity: myQuizizzEntity),
  );
}
Stream<MyCoursesState> eitherSuccessSubmitQuizOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessSubmitQuizState(statusCode: statusCode),
  );
}

Stream<MyCoursesState> eitherSuccessGetQuizizzInfoOrErrorState(
    Either<Failure,  MyQuizzInfoEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myQuizzInfoEntity) => SuccessGetQuizizzInfoState(myQuizzInfoEntity: myQuizzInfoEntity),
  );
}
Stream<MyCoursesState> eitherSuccessGetAssignmentOrErrorState(
    Either<Failure,  AssignmentEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (assignmentEntity) => SuccessAssignmentEntityState(assignmentEntity: assignmentEntity),
  );
}
Stream<MyCoursesState> eitherSuccessPostNewAssignmentOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessPostNewAssignmentEntityState(statusCode: statusCode),
  );
}

Stream<MyCoursesState> eitherSuccessPostCoceptOrErrorState(
    Either<Failure,  ConceptEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (conceptEntity) => SuccessPostConceptEntityState(conceptEntity: conceptEntity),
  );
}
Stream<MyCoursesState> eitherSuccessGetFileOrErrorState(
    Either<Failure,  FilesEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (filesEntity) => SuccessGetFileEntityState(filesEntity: filesEntity),
  );
}
Stream<MyCoursesState> eitherSuccessTopicReplyOrErrorState(
    Either<Failure,  TopicReplyEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (topicReplyEntity) => SuccessTopicReplyState(topicReplyEntity: topicReplyEntity),
  );
}
Stream<MyCoursesState> eitherSuccessCourseCaseStudyEntityOrErrorState(
    Either<Failure,  CourseCaseStudyEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (courseCaseStudyEntity) => SuccessCourseCaseStudyState(courseCaseStudyEntity: courseCaseStudyEntity),
  );
}
Stream<MyCoursesState> eitherSuccessArticleDetailsEntityOrErrorState(
    Either<Failure,  ArticleDetailsEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (articleDetailsEntity) => SuccessArticleDetailsState(articleDetailsEntity: articleDetailsEntity),
  );
}
Stream<MyCoursesState> eitherSuccessActivityFillingEntityOrErrorState(
    Either<Failure,  ActivityFillingEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activityFillingEntity) => SuccessActivityFillingState(activityFillingEntity: activityFillingEntity),
  );
}
Stream<MyCoursesState> eitherSuccessActivityMatchingEntityOrErrorState(
    Either<Failure,  ActivityMatchEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activityMatchingEntity) => SuccessActivityMatchingState(activityMatchEntity: activityMatchingEntity),
  );
}
Stream<MyCoursesState> eitherSuccessActivityLogicalEntityOrErrorState(
    Either<Failure,  ActiveLogicalEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activeLogicalEntity) => SuccessActiveLogicalState(activeLogicalEntity: activeLogicalEntity),
  );
}
Stream<MyCoursesState> eitherSuccessActivityCaseEventOrErrorState(
    Either<Failure,  ActivityCaseEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activityCaseEntity) => SuccessActivityCaseState(activityCaseEntity: activityCaseEntity),
  );
}
Stream<MyCoursesState> eitherSuccessAddFileOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessAddFileEntityState(statusCode: statusCode),
  );
}
Stream<MyCoursesState> eitherSuccessActivityQuizzEventOrErrorState(
    Either<Failure,  ActivityQuizzEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activityQuizzEntity) => SuccessActivityQuizzState(activityQuizzEntity: activityQuizzEntity),
  );
}
Stream<MyCoursesState> eitherSuccessAttendCaseEventOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessAttendCaseState(statusCode: statusCode),
  );
}
Stream<MyCoursesState> eitherSuccessActivityDecisionEventOrErrorState(
    Either<Failure,  ActivityDecisionEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (activityDecisionEntity) => SuccessActivityDecisionEntityState(activityDecisionEntity: activityDecisionEntity),
  );
}
Stream<MyCoursesState> eitherSuccessDeleteFileFromDBEventOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessDeleteFileFromDBState(statusCode: statusCode),
  );
}
Stream<MyCoursesState> eitherSuccessGetMyCoursesFromLocaleDBOrErrorState(
    Either<Failure,  List<MyCoursesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (myCoursesEntity) => SuccessGetMyCoursesFromLocaleDBState(
            myCoursesEntity: myCoursesEntity),
  );
}