
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/activity_filling_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:acadmiat/features/profile_feature/data/models/my_assignments_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/globals.dart';
import '../../../domain/entities/activity_quizz_entity.dart';
import '../../../domain/entities/my_quizz_info_entity.dart';
import '../../../domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import '../../../domain/use_cases/activity_case_usecase.dart';
import '../../../domain/use_cases/activity_match_usecase.dart';
import '../../../domain/use_cases/activity_quizz_usecase.dart';
import '../../../domain/use_cases/add_bookmark_usecase.dart';
import '../../../domain/use_cases/add_comment_usecase.dart';
import '../../../domain/use_cases/Assignment/get_assignment.dart';
import '../../../domain/use_cases/case_study/activity_decision_usecase.dart';
import '../../../domain/use_cases/case_study/attendcase_usecase.dart';
import '../../../domain/use_cases/case_study/course_case_study_usecase.dart';
import '../../../domain/use_cases/get_my_course/get_my_course_usecase.dart';
import '../../../domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import '../../../domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import '../../../domain/use_cases/activity_logical_usecase.dart';
import '../../../domain/use_cases/post_concept_usecase.dart';
import '../../../domain/use_cases/submit_quiz_usecase.dart';
import '../../../domain/use_cases/topic_reply_usecase.dart';
import '../../../domain/use_cases/wiki/article_details_usecase.dart';
import '../../models/activity_case_model.dart';
import '../../models/activity_decision_mode.dart';
import '../../models/activity_filling_model.dart';
import '../../models/activity_logical_model.dart';
import '../../models/activity_match_model.dart';
import '../../models/activity_quizz_model.dart';
import '../../models/article_details_model.dart';
import '../../models/assignment_model.dart';
import '../../models/bookmark_model.dart';
import '../../models/concept_model.dart';
import '../../models/course_case_study_model.dart';
import '../../models/discussion_model.dart';
import '../../models/my_course_model.dart';
import '../../models/my_courses_model.dart';
import '../../models/my_lecture_model.dart';
import '../../models/my_quizz_info_model.dart';
import '../../models/myqizz_model.dart';
import '../../models/sign_cookie_model.dart';
import '../../models/topic_reply_model.dart';
import 'myCourses_remote_data_functions.dart';

abstract class MyCoursesRemoteDataSource {
  Future<List<MyCoursesModel>> getMyCourses();
  Future<MyCourseModel> getMyCourse(GetMyCourseParams params);
  Future<SignCookieModel> getSignCookie();
  Future<MyLectureModel> getMyLecture(MyLectureParams params);
  Future<DiscussionModel> getDiscussion(int lectureId);
  Future<BookmarkModel> addBookmark(AddBookMarkParams params);
  Future<int> deleteBookmark(int bookmarkId);
  Future<int> addComment(AddCommentParams params);
  Future<MyQuizizzEntity> getMyQuizizz(GetMyQuizezzParams params);
  Future<int> submitQuiz(SubmitQuizParams params);
  Future<MyQuizzInfoModel> getMyQuizizzInfo(GetMyQuizizzInfoParams params);
  Future<AssignmentModel> getAssignment(GetAssignmentParams params);
  Future<int> postNewAssignment(PostNewAssignmentParams params);
  Future<ConceptModel> postConcept(PostConceptParams params);
  Future<TopicReplyModel> topicReply(TopicReplyParams params);
  Future<CourseCaseStudyModel> courseCaseStudy(CourseCaseStudyParams params);
  Future<ArticleDetailsModel> articleDetails(ArticleDetailsParams params);
  Future<ActivityFillingModel> activityFilling(ActivityFillingParams params);
  Future<ActivityMatchModel> activityMatch(ActivityMatchParams params);
  Future<ActivityLogicalModel> activityLogical(ActivityLogicalParams params);
  Future<ActivityCaseModel> activityCase(ActivityCaseParams params);
  Future<ActivityQuizzEntity> activityQuizz(ActivityQuizzParams params);
  Future<int> attendCase(AttendCaseParams params);
  Future<ActivityDecisionModel> activityDecision(ActivityDecisionParams params);

}

class MyCoursesRemoteDataSourceImpl implements MyCoursesRemoteDataSource {
  final http.Client client;

  MyCoursesRemoteDataSourceImpl({required this.client});

  MyCoursesRemoteDataFunctions functions =
  MyCoursesRemoteDataFunctions();

  @override
  Future<List<MyCoursesModel>> getMyCourses() async{
    return functions.getMyCourses('$baseUrl/v1/mycourses');
  }

  @override
  Future<MyCourseModel> getMyCourse(GetMyCourseParams params) {
    return functions.getMyCourse('$baseUrl/v1/mycourse',params);
  }

  @override
  Future<SignCookieModel> getSignCookie() {
    return functions.getSignCookie('$baseUrl/v1/signcookie');
  }

  @override
  Future<MyLectureModel> getMyLecture(MyLectureParams params) {
    return functions.getMyLecture('$baseUrl/v1/mylecture',params);
  }

  @override
  Future<DiscussionModel> getDiscussion(int lectureId) {
    return functions.getDiscussion('$baseUrl/v1/disucssion/$lectureId');
  }

  @override
  Future<BookmarkModel> addBookmark(AddBookMarkParams params) {
    return functions.addBookmark('$baseUrl/v1/bookmark',params);
  }

  @override
  Future<int> deleteBookmark(int bookmarkId) {
    return functions.deleteBookmark('$baseUrl/v1/bookmark/$bookmarkId');
  }

  @override
  Future<int> addComment(AddCommentParams params) {
    return functions.addComment('$baseUrl/v1/comment',params);
  }

  @override
  Future<MyQuizizzModel> getMyQuizizz(GetMyQuizezzParams params) async {
    return functions.getMyQuizizz('$baseUrl/v1/myquizz',params);
  }

  @override
  Future<int> submitQuiz(SubmitQuizParams params) {
    return functions.submitQuiz('$baseUrl/v1/submitquizz/${params.connectionId}',params);
  }

  @override
  Future<MyQuizzInfoModel> getMyQuizizzInfo(GetMyQuizizzInfoParams params) {
    return functions.getMyQuizizzInfo('$baseUrl/v1/myquizzinfo',params);
  }

  @override
  Future<AssignmentModel> getAssignment(GetAssignmentParams params) {
    return functions.getAssignment('$baseUrl/v1/myassignmentslist',params);
  }

  @override
  Future<int> postNewAssignment(PostNewAssignmentParams params) {
    return functions.postNewAssignment('$baseUrl/v1/assignment',params);
  }

  @override
  Future<ConceptModel> postConcept(PostConceptParams params) {
    return functions.postConcept('$baseUrl/api/courses/concept/',params);
  }

  @override
  Future<TopicReplyModel> topicReply(TopicReplyParams params) {
    return functions.topicReply('$baseUrl/api/Courses/topicreply',params);
  }

  @override
  Future<CourseCaseStudyModel> courseCaseStudy(CourseCaseStudyParams params) {
    return functions.courseCaseStudy('$baseUrl/v1/coursecasestudy',params);
  }

  @override
  Future<ArticleDetailsModel> articleDetails(ArticleDetailsParams params) {
    return functions.articleDetails('$baseUrl/api/Courses/articledetails',params);
  }

  @override
  Future<ActivityFillingModel> activityFilling(ActivityFillingParams params) {
    return functions.activityFilling('$baseUrl/v1/activity_filling',params);
  }

  @override
  Future<ActivityMatchModel> activityMatch(ActivityMatchParams params) {
    return functions.activityMatch('$baseUrl/v1/activity_match',params);
  }

  @override
  Future<ActivityLogicalModel> activityLogical(ActivityLogicalParams params) {
    return functions.activityLogical('$baseUrl/v1/activity_logical',params);
  }

  @override
  Future<ActivityCaseModel> activityCase(ActivityCaseParams params) {
    return functions.activityCase('$baseUrl/v1/activity_case',params);
  }

  @override
  Future<ActivityQuizzModel> activityQuizz(ActivityQuizzParams params) {
    return functions.activityQuizz('$baseUrl/v1/activity_quizz/${params.connectionId}',params);
  }

  @override
  Future<int> attendCase(AttendCaseParams params) {
    return functions.attendCase('$baseUrl/v1/attendcase',params);
  }

  @override
  Future<ActivityDecisionModel> activityDecision(ActivityDecisionParams params) {
    return functions.activityDecision('$baseUrl/v1/activity_decision',params);
  }


}
