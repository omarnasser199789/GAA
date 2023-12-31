import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
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
import '../../domain/entities/my_courses_from_local_db_entity.dart';
import '../../domain/entities/my_lecture_entity.dart';
import '../../domain/entities/my_quizz_info_entity.dart';
import '../../domain/entities/sign_cookie_entity.dart';
import '../../domain/entities/topic_reply_entity.dart';

typedef Future<int> _StatusCodeInfoChooser();
typedef Future< List<MyCoursesFromLocalDbEntity>> _MyCoursesFromLocalDbEntity();
typedef Future<List<MyCoursesEntity>> _MyCoursesInfoChooser();
typedef Future<MyQuizzInfoEntity> _MyQuizzInfoEntityInfoChooser();
typedef Future<AssignmentEntity> _AssignmentEntityInfoChooser();
typedef Future<MyQuizizzEntity>  _MyQuizizzInfoChooser();
typedef Future<MyCourseEntity> _MyCourseInfoChooser();
typedef Future<SignCookieEntity> _SignCookieEntity();
typedef Future<MyLectureEntity> _MyLectureEntity();
typedef Future<DiscussionEntity> _DiscussionEntity();
typedef Future<BookmarkEntity> _BookmarkEntity();
typedef Future<ActivityMatchEntity> _ActivityMatchEntity();
typedef Future<int> _StatusCode();
typedef Future<ActiveLogicalEntity> _ActiveLogicalEntity();
typedef Future<ActivityCaseEntity> _ActivityCaseEntity();
typedef Future<ActivityQuizzEntity> _ActivityQuizzEntity();
typedef Future<ActivityDecisionEntity> _ActivityDecisionEntity();
typedef Future<ConceptEntity> _ConceptEntity();
typedef Future<FilesEntity> _FilesEntity();
typedef Future<ActivityFillingEntity> _ActivityFillingEntity();
typedef Future<TopicReplyEntity> _TopicReplyEntity();
typedef Future<CourseCaseStudyEntity> _CourseCaseStudyEntity();
typedef Future<ArticleDetailsEntity> _ArticleDetailsEntity();

class ConsultationsRepositoryFunctions {

  Future<Either<Failure, int>> addConsultation(
      _StatusCodeInfoChooser _statusCodeInfoChooser,
    // NetworkInfo networkInfo
  ) async {
    try {
      final remote = await _statusCodeInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, int>> statusCode(
      _StatusCodeInfoChooser _statusCodeInfoChooser,
      // NetworkInfo networkInfo
      ) async {
    try {
      final remote = await _statusCodeInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // Future<Either<Failure,List<MyCoursesEntity>>> myCoursesFromLocalDbEntity(
  //     _MyCoursesFromLocalDbEntity _myCoursesFromLocalDbEntity,
  //     ) async {
  //   try {
  //     final remote = await _myCoursesFromLocalDbEntity();
  //
  //     return Right(remote);
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

  Future<Either<Failure, List<MyCoursesEntity>>> getConsultations(
      _MyCoursesInfoChooser _myCoursesInfoChooser) async {
    try {
      final remote = await _myCoursesInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, MyQuizzInfoEntity>> getMyQuizizzInfo(
      _MyQuizzInfoEntityInfoChooser _myQuizzInfoEntityInfoChooser) async {
    try {
      final remote = await _myQuizzInfoEntityInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, AssignmentEntity>> getAssignment(
      _AssignmentEntityInfoChooser _assignmentEntityInfoChooser) async {
    try {
      final remote = await _assignmentEntityInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MyCourseEntity>> convertToMyCourseEntity(
    _MyCourseInfoChooser _myCourseInfoChooser,
  ) async {
    try {
      final remote = await _myCourseInfoChooser();
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SignCookieEntity>> convertToGetSignCookie(
      _SignCookieEntity _signCookieEntity,
  ) async {
    try {
      final remote = await _signCookieEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MyLectureEntity>> convertToMyLectureEntity(
      _MyLectureEntity _myLectureEntity,
      ) async {
    try {
      final remote = await _myLectureEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DiscussionEntity>> convertToDiscussionEntity(
      _DiscussionEntity _discussionEntity,
      ) async {
    try {
      final remote = await _discussionEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, BookmarkEntity>> convertToBookmarkEntity(
      _BookmarkEntity _bookmarkEntity,
      ) async {
    try {
      final remote = await _bookmarkEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ActivityMatchEntity>> convertToActivityMatchEntity(
      _ActivityMatchEntity _activityMatchEntity,
      ) async {
    try {
      final remote = await _activityMatchEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ActiveLogicalEntity>> convertToActiveLogicalEntity(
      _ActiveLogicalEntity _activeLogicalEntity,
      ) async {
    try {
      final remote = await _activeLogicalEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ActivityCaseEntity>> convertToActivityCaseEntity(
      _ActivityCaseEntity _activityCaseEntity,
      ) async {
    try {
      final remote = await _activityCaseEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ActivityQuizzEntity>> convertToActivityQuizzEntity(
      _ActivityQuizzEntity _activityCaseEntity,
      ) async {
    try {
      final remote = await _activityCaseEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ActivityDecisionEntity>> convertToActivityDecisionEntity(
      _ActivityDecisionEntity _activityDecisionEntity,
      ) async {
    try {
      final remote = await _activityDecisionEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }



  Future<Either<Failure, int>> convertToStatusCode(
      _StatusCode _statusCode,
      ) async {
    try {
      final remote = await _statusCode();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ActivityFillingEntity>> convertToActivityFillingEntity(
      _ActivityFillingEntity _activityFillingEntity,
      ) async {
    try {
      final remote = await _activityFillingEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ConceptEntity>> convertToConceptEntity(
      _ConceptEntity _conceptEntity,
      ) async {
    try {
      final remote = await _conceptEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, FilesEntity>> convertToFilesEntity(
      _FilesEntity _filesEntity,
      ) async {
    try {
      final remote = await _filesEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, TopicReplyEntity>> convertToTopicReplyEntity(
      _TopicReplyEntity _topicReplyEntity,
      ) async {
    try {
      final remote = await _topicReplyEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, CourseCaseStudyEntity>> convertToCourseCaseStudyEntity(
      _CourseCaseStudyEntity _courseCaseStudyEntity,
      ) async {
    try {
      final remote = await _courseCaseStudyEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ArticleDetailsEntity>> convertToArticleDetailsEntity(
      _ArticleDetailsEntity _articleDetailsEntity,
      ) async {
    try {
      final remote = await _articleDetailsEntity();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, MyQuizizzEntity>> getMyQuizizz(
      _MyQuizizzInfoChooser _myQuizizzInfoChooser) async {
    try {
      final remote = await _myQuizizzInfoChooser();

      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}


