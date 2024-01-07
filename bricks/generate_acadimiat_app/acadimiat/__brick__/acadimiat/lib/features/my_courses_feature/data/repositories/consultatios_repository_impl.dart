import 'package:acadmiat/features/my_courses_feature/domain/entities/BookmarkEntity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_case_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_decision_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_logical_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_match_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/activity_quizz_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/article_details_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/assignment_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/concept_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/course_case_study_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/discussion_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/files_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/my_course_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/my_lecture_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/my_quizz_info_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/sign_cookie_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/topic_reply_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_case_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_filling_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_match_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_quizz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/add_bookmark_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/add_comment_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/Assignment/get_assignment.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/case_study/activity_decision_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/case_study/attendcase_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/case_study/course_case_study_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_logical_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/post_concept_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/topic_reply_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/wiki/article_details_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/activity_filling_entity.dart';
import '../../domain/entities/my_courses_entity.dart';
import '../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../domain/use_cases/get_my_course/get_my_course_usecase.dart';
import '../data_sources/local_data_source/myCourses_local_data_source.dart';
import '../data_sources/remot_data_sourse/myCourses_remot_data_source.dart';
import '../models/files_model.dart';
import '../models/my_courses_model.dart';
import 'consultations_repository_functions.dart';

class MyCoursesRepositoryImpl implements MyCoursesRepository {

  final MyCoursesRemoteDataSource myCoursesRemoteDataSource;
  final MyCoursesLocalDataSource myCoursesLocalDataSource;

  ConsultationsRepositoryFunctions functions =
      ConsultationsRepositoryFunctions();

  MyCoursesRepositoryImpl({

    required this.myCoursesRemoteDataSource,
    required this.myCoursesLocalDataSource,
  });

  @override
  Future<Either<Failure,   List<MyCoursesEntity>   >> getMyCourses() async {

    return await functions.getConsultations(() {
      return myCoursesRemoteDataSource.getMyCourses();
    });
  }

  @override
  Future<Either<Failure, MyCourseEntity>> getMyCourse(GetMyCourseParams params) async {
    return await functions.convertToMyCourseEntity(() {
      return myCoursesRemoteDataSource.getMyCourse( params);
    });
  }

  @override
  Future<Either<Failure, SignCookieEntity>> getSignCookie() async{
    return await functions.convertToGetSignCookie(() {
      return myCoursesRemoteDataSource.getSignCookie();
    });
  }

  @override
  Future<Either<Failure, MyLectureEntity>> getMyLecture(MyLectureParams params) async {
    return await functions.convertToMyLectureEntity(() {
      return myCoursesRemoteDataSource.getMyLecture(params);
    });
  }

  @override
  Future<Either<Failure, DiscussionEntity>> getDiscussion(int lectureId) async {
    return await functions.convertToDiscussionEntity(() {
      return myCoursesRemoteDataSource.getDiscussion(lectureId);
    });
  }

  @override
  Future<Either<Failure, BookmarkEntity>> addBookmark(AddBookMarkParams params) async{
    return await functions.convertToBookmarkEntity(() {
      return myCoursesRemoteDataSource.addBookmark(params);
    });
  }

  @override
  Future<Either<Failure, int>> deleteBookmark(int bookmarkId) async{
    return await functions.convertToStatusCode(() {
      return myCoursesRemoteDataSource.deleteBookmark(bookmarkId);
    });
  }

  @override
  Future<Either<Failure, int>> addComment(AddCommentParams params) async {
    return await functions.convertToStatusCode(() {
      return myCoursesRemoteDataSource.addComment(params);
    });
  }

  @override
  Future<Either<Failure,  MyQuizizzEntity  >> getMyQuizizz(GetMyQuizezzParams params) async {

    return await functions.getMyQuizizz(() {
      return myCoursesRemoteDataSource.getMyQuizizz(params);
    });
  }

  @override
  Future<Either<Failure, int>> submitQuiz(SubmitQuizParams params)  async{
    return await functions.statusCode(() {
      return myCoursesRemoteDataSource.submitQuiz(params);
    });
  }


  @override
  Future<Either<Failure, MyQuizzInfoEntity>> getMyQuizizzInfo(GetMyQuizizzInfoParams params) async{
    return await functions.getMyQuizizzInfo(() {
      return myCoursesRemoteDataSource.getMyQuizizzInfo(params);
    });
  }

  @override
  Future<Either<Failure, AssignmentEntity>> getAssignment(GetAssignmentParams params) async{
    return await functions.getAssignment(() {

      return myCoursesRemoteDataSource.getAssignment(params);

    });
  }

  @override
  Future<Either<Failure, int>> postNewAssignment(PostNewAssignmentParams params)async {
    return await functions.convertToStatusCode(() {
      return myCoursesRemoteDataSource.postNewAssignment(params);

    });
  }

  @override
  Future<Either<Failure, ConceptEntity>> postConcept(PostConceptParams params)async {
    return await functions.convertToConceptEntity(() {
      return myCoursesRemoteDataSource.postConcept(params);

    });
  }

  @override
  Future<Either<Failure, int>> addFile(AddFileParams params) async{

    return await functions.statusCode(() {
      return myCoursesLocalDataSource.addFile(params);

    });
  }

  @override
  Future<Either<Failure, FilesEntity>> getFileByUrl(GetFileParams params)async {
    return await functions.convertToFilesEntity(() {
      return myCoursesLocalDataSource.getFileByUrl(params);

    });
  }

  @override
  Future<Either<Failure, TopicReplyEntity>> topicReply(TopicReplyParams params) async{
    return await functions.convertToTopicReplyEntity(() {
      return myCoursesRemoteDataSource.topicReply(params);

    });
  }

  @override
  Future<Either<Failure, CourseCaseStudyEntity>> courseCaseStudy(CourseCaseStudyParams params) async{
    return await functions.convertToCourseCaseStudyEntity(() {
      return myCoursesRemoteDataSource.courseCaseStudy(params);

    });
  }

  @override
  Future<Either<Failure, ArticleDetailsEntity>> articleDetails(ArticleDetailsParams params) async{
    return await functions.convertToArticleDetailsEntity(() {
      return myCoursesRemoteDataSource.articleDetails(params);

    });
  }

  @override
  Future<Either<Failure, ActivityFillingEntity>> activityFilling(ActivityFillingParams params) async{
    return await functions.convertToActivityFillingEntity(() {
      return myCoursesRemoteDataSource.activityFilling(params);
    });
  }

  @override
  Future<Either<Failure, ActivityMatchEntity>> activityMatch(ActivityMatchParams params) async{
    return await functions.convertToActivityMatchEntity(() {
      return myCoursesRemoteDataSource.activityMatch(params);
    });
  }

  @override
  Future<Either<Failure, ActiveLogicalEntity>> activityLogical(ActivityLogicalParams params) async{
    return await functions.convertToActiveLogicalEntity(() {
      return myCoursesRemoteDataSource.activityLogical(params);
    });
  }

  @override
  Future<Either<Failure, ActivityCaseEntity>> activityCase(ActivityCaseParams params) async{
    return await functions.convertToActivityCaseEntity(() {
      return myCoursesRemoteDataSource.activityCase(params);
    });
  }

  @override
  Future<Either<Failure, ActivityQuizzEntity>> activityQuizz(ActivityQuizzParams params)async {
    return await functions.convertToActivityQuizzEntity(() {
      return myCoursesRemoteDataSource.activityQuizz(params);
    });
  }

  @override
  Future<Either<Failure, int>> attendCase(AttendCaseParams params) async {
    return await functions.statusCode(() {
      return myCoursesRemoteDataSource.attendCase(params);
    });
  }

  @override
  Future<Either<Failure, ActivityDecisionEntity>> activityDecision(ActivityDecisionParams params) async {
    return await functions.convertToActivityDecisionEntity(() {
      return myCoursesRemoteDataSource.activityDecision(params);
    });
  }

  @override
  Future<Either<Failure, FilesEntity>> getAllFiles(String noParams) async {
    return await functions.convertToFilesEntity(() {
      return myCoursesLocalDataSource.getAllFiles(noParams);

    });
  }

  @override
  Future<Either<Failure, int>> deleteFile(FilesModel files) async {
    return await functions.statusCode(() {
      return myCoursesLocalDataSource.deleteFile(files);

    });
  }

  @override
  Future<Either<Failure, int>> deleteAllFiles(FilesModel files)async {
    return await functions.statusCode(() {
      return myCoursesLocalDataSource.deleteAllFiles(files);

    });
  }

  @override
  Future<Either<Failure, int>> updateMyCourses(List<MyCoursesModel> params) async {
    return await functions.statusCode(() {
      return myCoursesLocalDataSource.updateMyCourses(params);

    });
  }

  @override
  Future<Either<Failure, List<MyCoursesEntity>>> getMyCoursesFromLocalDb(String noParams) async {
    return await functions.getConsultations(() {
      return myCoursesLocalDataSource.getMyCoursesFromLocalDb(noParams);

    });
  }

}
