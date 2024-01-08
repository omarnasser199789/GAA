import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/success_error/either_success_or_error.dart';
import '../../../../core/globals.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/use_cases/Assignment/get_assignment.dart';
import '../../domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import '../../domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/delete_all_files_from_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/delete_file_from_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../domain/use_cases/activity_case_usecase.dart';
import '../../domain/use_cases/activity_filling_usecase.dart';
import '../../domain/use_cases/activity_logical_usecase.dart';
import '../../domain/use_cases/activity_match_usecase.dart';
import '../../domain/use_cases/activity_quizz_usecase.dart';
import '../../domain/use_cases/case_study/activity_decision_usecase.dart';
import '../../domain/use_cases/case_study/attendcase_usecase.dart';
import '../../domain/use_cases/case_study/course_case_study_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_all_files_usecase.dart';
import '../../domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_my_courses_from_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_mycourses_in_local_db_usecase.dart';
import '../../domain/use_cases/post_concept_usecase.dart';
import '../../domain/use_cases/topic_reply_usecase.dart';
import '../../domain/use_cases/wiki/article_details_usecase.dart';
import '../pages/my_course/tabs/lessons_tab/pages/lecture_page.dart';
import '../../domain/use_cases/add_bookmark_usecase.dart';
import '../../domain/use_cases/add_comment_usecase.dart';
import '../../domain/use_cases/delete_bookmark_usecase.dart';
import '../../domain/use_cases/get_discussion_usecase.dart';
import '../../domain/use_cases/get_my_course/get_my_course_usecase.dart';
import '../../domain/use_cases/get_my_courses_usecase.dart';
import '../../domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import '../../domain/use_cases/sign_cookie_usecase.dart';
import 'bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final GetMyCoursesUseCase getMyCoursesUseCase;
  final GetMyCourseUseCase getMyCourseUseCase;
  final SignCookieUseCase signCookieUseCase;
  final MyLectureUseCase myLectureUseCase;
  final GetDiscussionUseCase getDiscussionUseCase;
  final AddBookmarkUseCase addBookmarkUseCase;
  final DeleteBookmarkUseCase deleteBookmarkUseCase;
  final AddCommentUseCase addCommentUseCase;
  final GetMyQuizizzUseCase getMyQuizizzUseCase;
  final SubmitQuizUseCase submitQuizUseCase;
  final GetMyQuizizzInfoUseCase getMyQuizizzInfoUseCase;
  final GetAssignmentUseCase getAssignmentUseCase;
  final PostNewAssignmentUseCase postNewAssignmentUseCase;
  final PostConceptUseCase postConceptUseCase;
  final AddFileInLocalDBUseCase addFileInLocalDBUseCase;
  final GetFileByUrlUseCase getFileByUrlUseCase;
  final TopicReplyUseCase topicReplyUseCase;
  final CourseCaseStudyUseCase courseCaseStudyUseCase;
  final ArticleDetailsUseCase articleDetailsUseCase;
  final ActivityFillingUseCase activityFillingUseCase;
  final ActivityMatchingUseCase activityMatchingUseCase;
  final ActivityLogicalUseCase activityLogicalUseCase;
  final ActivityCaseUseCase activityCaseUseCase;
  final ActivityQuizzUseCase activityQuizzUseCase;
  final AttendCaseUseCase attendCaseUseCase;
  final ActivityDecisionUseCase activityDecisionUseCase;
  final GetAllFilesUseCase getAllFilesUseCase;
  final DeleteFileFromLocalDBUseCase deleteFileFromLocalDBUseCase;
  final DeleteAllFilesFromLocalDBUseCase deleteAllFilesFromLocalDBUseCase;
  final UpdateMyCoursesInLocalDBUseCase updateMyCoursesInLocalDBUseCase;
  final GetMyCoursesFromLocaleDBUseCase getMyCoursesFromLocaleDBUseCase;

  MyCoursesBloc({
    required DeleteAllFilesFromLocalDBUseCase concreteDeleteAllFilesFromLocalDBUseCase,
    required DeleteFileFromLocalDBUseCase concreteDeleteFileFromLocalDBUseCase,
    required GetAllFilesUseCase concreteGetAllFilesUseCase,
    required ActivityDecisionUseCase concreteActivityDecisionUseCase,
    required ActivityQuizzUseCase concreteActivityQuizzUseCase,
    required AttendCaseUseCase concreteAttendCaseUseCase,
    required ActivityCaseUseCase concreteActivityCaseUseCase,
    required ActivityLogicalUseCase concreteActivityLogicalUseCase,
    required ActivityMatchingUseCase concreteActivityMatchingUseCase,
    required ArticleDetailsUseCase concreteArticleDetailsUseCase,
    required ActivityFillingUseCase concreteActivityFillingUseCase,
    required CourseCaseStudyUseCase concreteCourseCaseStudyUseCase,
    required TopicReplyUseCase concreteTopicReplyUseCase,
    required GetFileByUrlUseCase concreteGetFileByUrlUseCase,
    required AddFileInLocalDBUseCase concreteAddFileInLocalDBUseCase,
    required PostConceptUseCase concretePostConceptUseCase,
    required PostNewAssignmentUseCase concretePostNewAssignmentUseCase,
    required GetAssignmentUseCase concreteGetAssignmentUseCase,
    required GetMyQuizizzInfoUseCase concreteGetMyQuizizzInfoUseCase,
    required SubmitQuizUseCase concreteSubmitQuizUseCase,
    required GetMyQuizizzUseCase concreteGetMyQuizizzUseCase,
    required GetMyCoursesUseCase concreteGetMyCoursesUseCase,
    required GetMyCourseUseCase concreteGetMyCourseUseCase,
    required SignCookieUseCase concreteSignCookieUseCase,
    required MyLectureUseCase concreteMyLectureUseCase,
    required GetDiscussionUseCase concreteGetDiscussionUseCase,
    required AddBookmarkUseCase concreteAddBookmarkUseCase,
    required DeleteBookmarkUseCase concreteDeleteBookmarkUseCase,
    required AddCommentUseCase concreteAddCommentUseCase,
    required UpdateMyCoursesInLocalDBUseCase concreteUpdateMyCoursesInLocalDBUseCase,
    required GetMyCoursesFromLocaleDBUseCase concreteGetMyCoursesFromLocaleDBUseCase,
  })  : deleteAllFilesFromLocalDBUseCase = concreteDeleteAllFilesFromLocalDBUseCase,
        deleteFileFromLocalDBUseCase = concreteDeleteFileFromLocalDBUseCase,
        getAllFilesUseCase = concreteGetAllFilesUseCase,
        activityDecisionUseCase = concreteActivityDecisionUseCase,
        attendCaseUseCase = concreteAttendCaseUseCase,
        activityQuizzUseCase = concreteActivityQuizzUseCase,
        activityCaseUseCase = concreteActivityCaseUseCase,
        activityLogicalUseCase = concreteActivityLogicalUseCase,
        activityMatchingUseCase = concreteActivityMatchingUseCase,
        activityFillingUseCase = concreteActivityFillingUseCase,
        articleDetailsUseCase = concreteArticleDetailsUseCase,
        courseCaseStudyUseCase = concreteCourseCaseStudyUseCase,
        topicReplyUseCase = concreteTopicReplyUseCase,
        getFileByUrlUseCase = concreteGetFileByUrlUseCase,
        addFileInLocalDBUseCase = concreteAddFileInLocalDBUseCase,
        postConceptUseCase = concretePostConceptUseCase,
        postNewAssignmentUseCase = concretePostNewAssignmentUseCase,
        getAssignmentUseCase = concreteGetAssignmentUseCase,
        getMyQuizizzInfoUseCase = concreteGetMyQuizizzInfoUseCase,
        submitQuizUseCase = concreteSubmitQuizUseCase,
        getMyQuizizzUseCase = concreteGetMyQuizizzUseCase,
        getMyCoursesUseCase = concreteGetMyCoursesUseCase,
        getMyCourseUseCase = concreteGetMyCourseUseCase,
        signCookieUseCase = concreteSignCookieUseCase,
        myLectureUseCase = concreteMyLectureUseCase,
        getDiscussionUseCase = concreteGetDiscussionUseCase,
        addBookmarkUseCase = concreteAddBookmarkUseCase,
        deleteBookmarkUseCase = concreteDeleteBookmarkUseCase,
        addCommentUseCase = concreteAddCommentUseCase,
        updateMyCoursesInLocalDBUseCase = concreteUpdateMyCoursesInLocalDBUseCase,
        getMyCoursesFromLocaleDBUseCase = concreteGetMyCoursesFromLocaleDBUseCase,
        super(Empty());

  @override
   Stream<MyCoursesState> mapEventToState(MyCoursesEvent event) async* {

    if (event is GetMyCourses) {
      final failureOrSuccess = await getMyCoursesUseCase(NoParams());
      yield* eitherLoadedOrErrorState(failureOrSuccess);
    } else if (event is GetMyCourse) {
      final failureOrSuccess = await getMyCourseUseCase(event.getMyCourseParams);
      yield* eitherGetMyCourseOrErrorState(failureOrSuccess);
    } else if (event is GetSignCookie) {
      final failureOrSuccess = await signCookieUseCase("");
      yield* eitherSignCookieOrErrorState(failureOrSuccess);
    }
    else if (event is GetMyLecture) {
      final failureOrSuccess = await myLectureUseCase(event.myLectureParams);
      yield* eitherSuccessGetMyLectureOrErrorState(failureOrSuccess);
    }
    else if (event is InitVideo) {
      yield* eitherSuccessInitVideoOrErrorState();
    }else if(event is GetDiscussionEvent){
      final failureOrSuccess = await getDiscussionUseCase(event.lectureId);
      yield* eitherSuccessGetDiscussionEventOrErrorState(failureOrSuccess);
    }else if(event is AddBookmarkEvent){
      final failureOrSuccess = await addBookmarkUseCase(event.addBookMarkParams);
      yield* eitherSuccessAddBookmarkEventOrErrorState(failureOrSuccess);
    }else if(event is DeleteBookmarkEvent){
      final failureOrSuccess = await deleteBookmarkUseCase(event.bookmarkId);
      yield* eitherSuccessDeleteBookmarkEventOrErrorState(failureOrSuccess);
    }else if(event is AddCommentEvent){
      final failureOrSuccess = await addCommentUseCase(event.addCommentParams);
      yield* eitherSuccessAddCommentEventOrErrorState(failureOrSuccess);
    }else if(event is ResetEvent){
      yield Empty();//eitherSuccessResetEventOrErrorState();
    }

    else if (event is LaunchNewVideoEvent){
      yield Loading();
      await Future.delayed(const Duration(milliseconds: 100));
      yield LecturePage(
          key: lecturePageKey,
          lectureParams:LectureParams(
            part: event.part,
            courseCover: event.courseCover,
            index: event.index,
            myCourseEntity: event.myCourseEntity,
            lectureId: event.lectureId,
            mediaQueryPadding: event.mediaQueryPadding
        )

      );
    }
    if (event is GetMyQuizizz) {
      final failureOrSuccess = await getMyQuizizzUseCase(event.getMyQuizezzParams);
      yield* eitherSuccessGetMyQuizizzOrErrorState(failureOrSuccess);
    }

    if (event is SubmitQuizEvent) {
      final failureOrSuccess = await submitQuizUseCase(event.submitQuizParams);
      yield* eitherSuccessSubmitQuizOrErrorState(failureOrSuccess);
    }
    if (event is GetMyQuizizzInfoEvent) {
      yield Loading();
      final failureOrSuccess = await getMyQuizizzInfoUseCase(event.getMyQuizizzInfoParams);
      yield* eitherSuccessGetQuizizzInfoOrErrorState(failureOrSuccess);
    }
    if (event is GetAssignmentEvent) {
      yield Loading();
      final failureOrSuccess = await getAssignmentUseCase(event.getAssignmentParams);
      yield* eitherSuccessGetAssignmentOrErrorState(failureOrSuccess);
    }
    if (event is PostNewAssignmentEvent) {
      yield Loading();
      final failureOrSuccess = await postNewAssignmentUseCase(event.postNewAssignmentParams);
      yield* eitherSuccessPostNewAssignmentOrErrorState(failureOrSuccess);
    }

    if (event is PostConceptEvent) {
      yield Loading();
      final failureOrSuccess = await postConceptUseCase(event.params);
      yield* eitherSuccessPostCoceptOrErrorState(failureOrSuccess);
    }

    if (event is AddFileEvent) {
     await addFileInLocalDBUseCase(event.params);
    }
    if (event is GetFileByUrlEvent) {
      yield Loading();
      final failureOrSuccess = await getFileByUrlUseCase(event.params);
      yield* eitherSuccessGetFileOrErrorState(failureOrSuccess);
    }
    if (event is GetAllFilesEvent) {
      yield Loading();
      final failureOrSuccess = await getAllFilesUseCase("");
      yield* eitherSuccessGetFileOrErrorState(failureOrSuccess);
    }
    if (event is TopicReplyEvent) {
      yield Loading();
      final failureOrSuccess = await topicReplyUseCase(event.params);
      yield* eitherSuccessTopicReplyOrErrorState(failureOrSuccess);
    }
    if (event is CourseCaseStudyEvent) {
      yield Loading();
      final failureOrSuccess = await courseCaseStudyUseCase(event.params);
      yield* eitherSuccessCourseCaseStudyEntityOrErrorState(failureOrSuccess);
    }
    if (event is ArticleDetailsEvent) {
      yield Loading();
      final failureOrSuccess = await articleDetailsUseCase(event.params);
      yield* eitherSuccessArticleDetailsEntityOrErrorState(failureOrSuccess);
    }
    if (event is ActivityFillingEvent) {
      yield Loading();
      final failureOrSuccess = await activityFillingUseCase(event.params);
      yield* eitherSuccessActivityFillingEntityOrErrorState(failureOrSuccess);
    }
    if (event is ActivityMatchingEvent) {
      yield Loading();
      final failureOrSuccess = await activityMatchingUseCase(event.params);
      yield* eitherSuccessActivityMatchingEntityOrErrorState(failureOrSuccess);
    }

    if (event is ActivityLogicalEvent) {
      yield Loading();
      final failureOrSuccess = await activityLogicalUseCase(event.params);
      yield* eitherSuccessActivityLogicalEntityOrErrorState(failureOrSuccess);
    }

    if (event is ActivityCaseEvent) {
      yield Loading();
      final failureOrSuccess = await activityCaseUseCase(event.params);
      yield* eitherSuccessActivityCaseEventOrErrorState(failureOrSuccess);
    }

    if (event is ActivityQuizzEvent) {
      yield Loading();
      final failureOrSuccess = await activityQuizzUseCase(event.params);
      yield* eitherSuccessActivityQuizzEventOrErrorState(failureOrSuccess);
    }
    if (event is AttendCaseEvent) {
      yield Loading();
      final failureOrSuccess = await attendCaseUseCase(event.params);
      yield* eitherSuccessAttendCaseEventOrErrorState(failureOrSuccess);
    }
    if (event is ActivityDecisionEvent) {
      yield Loading();
      final failureOrSuccess = await activityDecisionUseCase(event.params);
      yield* eitherSuccessActivityDecisionEventOrErrorState(failureOrSuccess);
    }
    if (event is DeleteFileFromDBEvent) {
      yield Loading();
      final failureOrSuccess = await deleteFileFromLocalDBUseCase(event.files);
      yield* eitherSuccessDeleteFileFromDBEventOrErrorState(failureOrSuccess);
    }
    if (event is DeleteAllFilesFromDBEvent) {
      yield Loading();
      final failureOrSuccess = await deleteAllFilesFromLocalDBUseCase(event.files);
      yield* eitherSuccessDeleteFileFromDBEventOrErrorState(failureOrSuccess);
    }
    if(event is UpdateMyCoursesFromLocaleDBEvent){
      updateMyCoursesInLocalDBUseCase(event.params);
    }
    if (event is GetMyCoursesFromLocaleDBEvent) {
      yield Loading();
      final failureOrSuccess = await getMyCoursesFromLocaleDBUseCase("");
      yield* eitherSuccessGetMyCoursesFromLocaleDBOrErrorState(failureOrSuccess);
    }


  }
}
