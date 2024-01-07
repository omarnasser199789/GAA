import 'dart:convert';
import 'package:acadmiat/features/my_courses_feature/data/models/my_quizz_info_model.dart';
import 'package:acadmiat/features/my_courses_feature/data/models/myqizz_model.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/network/api_manager.dart';
import '../../../domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import '../../../domain/use_cases/activity_case_usecase.dart';
import '../../../domain/use_cases/activity_filling_usecase.dart';
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
import '../../models/sign_cookie_model.dart';
import 'dart:core';
import '../../models/topic_reply_model.dart';

class MyCoursesRemoteDataFunctions {
  Future<List<MyCoursesModel>> getMyCourses(String url) async {
    http.Response response = await ApiManager.post(url:url, body: jsonEncode({'sub': globalSH.getString(CUSTOMER_ID)!}));
    if (response.statusCode == 200) {
      return myCoursesModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }

  Future<MyCourseModel>  getMyCourse(String url, GetMyCourseParams params) async {
    Map<String, dynamic> data = {
      'userId': params.userId,
      'courseId': params.courseId,
    };
    http.Response response = await ApiManager.post(url:url, body: jsonEncode(data));
    if (response.statusCode == 200) {
      return MyCourseModelFromJson(response.body);
    }
    else if(response.statusCode == 500){
        throw ServerException();
    }
    else{
      throw ServerException();
    }
  }

////////////////////////////////
  Future<SignCookieModel> getSignCookie(String url) async {
    print(url);
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();
      final response = await client.get(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $JWT',
      }).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        await updateCookiee(response);

        var value = signCookieModelFromJson(response.body);
        return value;
            } else {
        throw ServerException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  Future<dynamic> updateCookiee(http.Response response) async {
    String allSetCookie = response.headers['set-cookie']!;
    var setCookies = allSetCookie.split(',');

    for (var setCookie in setCookies) {
      var cookies = setCookie.split(';');

      for (var cookie in cookies) {
        await setCookiess(cookie);
      }
    }

    headers['cookie'] = await _generateCookieHeader();
  }

  Future<dynamic> setCookiess(String rawCookie) async {
    if (rawCookie.isNotEmpty) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  Future<String> _generateCookieHeader() async {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) {
        cookie += ";";
      }
      cookie += "$key=${cookies[key]!}";
    }

    return cookie;
  }

  ///////////////////////////////////
  Future<MyLectureModel> getMyLecture(String url, MyLectureParams params) async {
    if (kDebugMode) {
      print(url);
    }
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    Map<String, dynamic> data = {
      'userId': params.userId,
      'lectureId': params.lectureId,
    };
    if (kDebugMode) {
      print(data);
    }
    try {
      JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();
      final response = await client
          .post(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer $JWT',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print("$data >>>> StatusCode${response.statusCode}");
      }
      if (response.statusCode == 200) {

        var value = myLectureModelFromJson(response.body);
        return value;
            } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  ///////////////////////////////////
  Future<DiscussionModel> getDiscussion(String url) async {
    if (kDebugMode) {
      print(url);
    }
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $JWT',
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        var value = discussionModelFromJson(response.body);
        return value;
            } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<BookmarkModel> addBookmark(
      String url, AddBookMarkParams params) async {
    if (kDebugMode) {
      print(url);
    }
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: addBookMarkParamsToJson(params) //jsonEncode(addBookMarkParamsToJson(params))
              )
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        var value = bookmarkModelFromJson(response.body);
        return value;
            } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<int> deleteBookmark(String url) async {
    if (kDebugMode) {
      print(url);
    }
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      final response = await client.delete(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $JWT',
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<int> addComment(String url, AddCommentParams params) async {
    if (kDebugMode) {
      print(url);
    }
    var client = http.Client();

    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: addCommentParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<MyQuizizzModel> getMyQuizizz(
      String url, GetMyQuizezzParams params) async {
    Map<String, dynamic> data = {
      'userId': params.userId,
      'lectureId': params.lectureId,
    };
    if (kDebugMode) {
      print(url);
    }


    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        return MyQuizizzModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<int> submitQuiz(String url, SubmitQuizParams params) async {
    if (kDebugMode) {
      print(url);
      print(SubmitQuizToJson(params.submitQuiz));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: SubmitQuizToJson(params.submitQuiz))
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<MyQuizzInfoModel> getMyQuizizzInfo(
      String url, GetMyQuizizzInfoParams params) async {
    Map<String, dynamic> data = {
      'userId': params.userId,
      'quizzId': params.quizzId,
    };
    if (kDebugMode) {
      print(url);
      print(data);
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));
      var models = myQuizzInfoModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<AssignmentModel> getAssignment(String url,GetAssignmentParams params) async {

    Map<String, dynamic> data = {
      'userId': params.userId,
      'courseId': params.courseId,
      'assignmentId': params.assignmentId,
    };

    if (kDebugMode) {
      debugPrint(url);
      print(data);
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));
      
      var models = AssignmentModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<ConceptModel> postConcept(String url,PostConceptParams params) async {

    if (kDebugMode) {
      print(url);
      print(postConceptParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: postConceptParamsToJson(params))
          .timeout(Duration(seconds: timeout));
  
      var models = conceptModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<TopicReplyModel> topicReply(String url,TopicReplyParams params) async {

    if (kDebugMode) {
      print(url);
      print(topicReplyParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: topicReplyParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      var models = topicReplyModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }


  Future<CourseCaseStudyModel> courseCaseStudy(String url,CourseCaseStudyParams params) async {

    if (kDebugMode) {
      print(url);
      print(courseCaseStudyParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: courseCaseStudyParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      
      var models = courseCaseStudyModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }
  Future<ArticleDetailsModel> articleDetails(String url,ArticleDetailsParams params) async {

    if (kDebugMode) {
      print(url);
      print(articleDetailsParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: articleDetailsParamsToJson(params))
          .timeout(Duration(seconds: timeout));
 
      var models = articleDetailsModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }
  Future<ActivityFillingModel> activityFilling(String url,ActivityFillingParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityFillingParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityFillingParamsToJson(params))
          .timeout(Duration(seconds: timeout));

      var models = activityFillingModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<ActivityMatchModel> activityMatch(String url,ActivityMatchParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityMatchParamsToJson(params));

    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityMatchParamsToJson(params))
          .timeout(Duration(seconds: timeout));


      var models = activityMatchModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<ActivityLogicalModel> activityLogical(String url,ActivityLogicalParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityLogicalParamsToJson(params));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityLogicalParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      print(response.body);

      var models = activityLogicalModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<ActivityCaseModel> activityCase(String url,ActivityCaseParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityCaseParamsToJson(params));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityCaseParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      print("dfjvnjkdfnvkdfn");
      print(response.body);

      var models = activityCaseModelFromJson(response.body);
      return models;
        } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  Future<ActivityQuizzModel> activityQuizz(String url,ActivityQuizzParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityQuizzParamsToJson(params.quizzParams));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityQuizzParamsToJson(params.quizzParams))
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.body);
      }

      var models = activityQuizzModelFromJson(response.body);
      return models;

    } catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      throw ServerException();
    }
  }
  Future<int> attendCase(String url,AttendCaseParams params) async {

    if (kDebugMode) {
      print(url);
      print(attendCaseParamsToJson(params));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: attendCaseParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.body);
      }

      // var models = activityQuizzModelFromJson(response.body);
      return 200;

    } catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      throw ServerException();
    }
  }

  Future<ActivityDecisionModel> activityDecision(String url,ActivityDecisionParams params) async {

    if (kDebugMode) {
      print(url);
      print(activityDecisionParamsToJson(params));
    }

    try {
      var client = http.Client();
      final response = await client
          .post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $JWT',
              },
              body: activityDecisionParamsToJson(params))
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.body);
      }

      var models = ActivityDecisionModelFromJson(response.body);
      return models;

    } catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      throw ServerException();
    }
  }

  Future<int> postNewAssignment(String url,PostNewAssignmentParams params) async {

    if (kDebugMode) {
      print(url);
    }



    Dio dio = Dio();

    try {


      List<int> imageData = params.file;
      var fileSize = imageData.length;
      if (kDebugMode) {
        print(fileSize);
      }
      if(fileSize>11000000){
        throw ServerException();
      }



      var formData = FormData.fromMap({
      "jsonData": "{'userId':'${params.userId}','assignmentId':${params.assignmentId}}",
        'file': MultipartFile(
            Stream.fromIterable(imageData.map((e) => [e])),
            fileSize, filename: params.fileName,
        ),
      });

      dio.options.headers['Authorization'] ='Bearer $JWT';
      dio.options.headers['Accept'] = 'application/json';
      dio.options.headers['Content-type'] = 'application/json';

      var response = await dio.post(url, data: formData,
        onSendProgress: (int sent, int total){
        counterNotifier.value="${(sent / total * 100).toStringAsFixed(0)}%";
      }
      );
      if (kDebugMode) {
        print("RESPONSE:$response");
      }
      if (response.statusCode == 200) {
        return 200;
      } else {
        return response.statusCode!;
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }

  }
}



