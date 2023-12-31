import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_case_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_quizz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/files_model.dart';
import '../../data/models/my_courses_model.dart';
import '../entities/BookmarkEntity.dart';
import '../entities/activity_case_entity.dart';
import '../entities/activity_decision_entity.dart';
import '../entities/activity_filling_entity.dart';
import '../entities/activity_logical_entity.dart';
import '../entities/activity_match_entity.dart';
import '../entities/activity_quizz_entity.dart';
import '../entities/article_details_entity.dart';
import '../entities/assignment_entity.dart';
import '../entities/concept_entity.dart';
import '../entities/course_case_study_entity.dart';
import '../entities/discussion_entity.dart';
import '../entities/files_entity.dart';
import '../entities/my_course_entity.dart';
import '../entities/my_courses_entity.dart';
import '../entities/my_courses_from_local_db_entity.dart';
import '../entities/my_lecture_entity.dart';
import '../entities/my_quizz_info_entity.dart';
import '../entities/sign_cookie_entity.dart';
import '../entities/topic_reply_entity.dart';
import '../use_cases/Assignment/post_new_assignment_usecase.dart';
import '../use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../use_cases/activity_filling_usecase.dart';
import '../use_cases/activity_match_usecase.dart';
import '../use_cases/add_bookmark_usecase.dart';
import '../use_cases/add_comment_usecase.dart';
import '../use_cases/Assignment/get_assignment.dart';
import '../use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../use_cases/case_study/activity_decision_usecase.dart';
import '../use_cases/case_study/attendcase_usecase.dart';
import '../use_cases/case_study/course_case_study_usecase.dart';
import '../use_cases/get_my_course/get_my_course_usecase.dart';
import '../use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import '../use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import '../use_cases/activity_logical_usecase.dart';
import '../use_cases/local_db_usecase/update_mycourses_in_local_db_usecase.dart';
import '../use_cases/post_concept_usecase.dart';
import '../use_cases/submit_quiz_usecase.dart';
import '../use_cases/topic_reply_usecase.dart';
import '../use_cases/wiki/article_details_usecase.dart';


abstract class MyCoursesRepository{

  Future<Either<Failure, List<MyCoursesEntity>>> getMyCourses();
  Future<Either<Failure, SignCookieEntity>> getSignCookie();
  Future<Either<Failure,MyCourseEntity>> getMyCourse(GetMyCourseParams params);
  Future<Either<Failure,MyLectureEntity>> getMyLecture(MyLectureParams params);
  Future<Either<Failure,DiscussionEntity>> getDiscussion(int lectureId);
  Future<Either<Failure,BookmarkEntity>> addBookmark(AddBookMarkParams params);
  Future<Either<Failure,int>> deleteBookmark(int bookmarkId);
  Future<Either<Failure,int>> addComment(AddCommentParams params);
  Future<Either<Failure,MyQuizizzEntity>> getMyQuizizz(GetMyQuizezzParams params);
  Future<Either<Failure,int>> submitQuiz(SubmitQuizParams params);
  Future<Either<Failure,MyQuizzInfoEntity>> getMyQuizizzInfo(GetMyQuizizzInfoParams params);
  Future<Either<Failure,AssignmentEntity>> getAssignment(GetAssignmentParams params);
  Future<Either<Failure,int>> postNewAssignment(PostNewAssignmentParams params);
  Future<Either<Failure,ConceptEntity>> postConcept(PostConceptParams params);



  Future<Either<Failure,TopicReplyEntity>> topicReply(TopicReplyParams  params);
  Future<Either<Failure,CourseCaseStudyEntity>> courseCaseStudy(CourseCaseStudyParams params);
  Future<Either<Failure,ArticleDetailsEntity>> articleDetails(ArticleDetailsParams params);
  Future<Either<Failure,ActivityFillingEntity>> activityFilling(ActivityFillingParams params);
  Future<Either<Failure,ActivityMatchEntity>> activityMatch(ActivityMatchParams params);
  Future<Either<Failure,ActiveLogicalEntity>> activityLogical(ActivityLogicalParams params);
  Future<Either<Failure,ActivityCaseEntity>> activityCase(ActivityCaseParams params);
  Future<Either<Failure,ActivityQuizzEntity>> activityQuizz(ActivityQuizzParams params);
  Future<Either<Failure,int>> attendCase(AttendCaseParams params);
  Future<Either<Failure,ActivityDecisionEntity>> activityDecision(ActivityDecisionParams params);
  ///Local DB

  Future<Either<Failure,FilesEntity>> getFileByUrl(GetFileParams  params);
  Future<Either<Failure,FilesEntity>> getAllFiles(String  noParams);
  Future<Either<Failure,int>> deleteFile(FilesModel file);
  Future<Either<Failure,int>> deleteAllFiles(FilesModel files);
  Future<Either<Failure,int>> addFile(AddFileParams params);
  Future<Either<Failure,int>> updateMyCourses(List<MyCoursesModel> params);
  Future<Either<Failure,List<MyCoursesEntity>>> getMyCoursesFromLocalDb(String noParams);




}