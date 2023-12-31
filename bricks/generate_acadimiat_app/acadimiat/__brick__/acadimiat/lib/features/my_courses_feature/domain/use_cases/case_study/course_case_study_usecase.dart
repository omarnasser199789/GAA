import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/course_case_study_entity.dart';
import '../../repositories/consultations_repository.dart';
import 'dart:convert';

class CourseCaseStudyUseCase implements UseCase< CourseCaseStudyEntity, CourseCaseStudyParams> {
  final MyCoursesRepository repository;
  CourseCaseStudyUseCase({required this.repository});
  @override
  Future<Either<Failure, CourseCaseStudyEntity>> call(CourseCaseStudyParams params) {
    return repository.courseCaseStudy(params);
  }
}


CourseCaseStudyParams courseCaseStudyParamsFromJson(String str) => CourseCaseStudyParams.fromJson(json.decode(str));

String courseCaseStudyParamsToJson(CourseCaseStudyParams data) => json.encode(data.toJson());

class CourseCaseStudyParams {
  CourseCaseStudyParams({
  required  this.userId,
  required  this.courseId,
  required  this.forumId,
  });

  int userId;
  int courseId;
  int forumId;

  factory CourseCaseStudyParams.fromJson(Map<String, dynamic> json) => CourseCaseStudyParams(
    userId: json["userId"],
    courseId: json["courseId"],
    forumId: json["forumId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "courseId": courseId,
    "forumId": forumId,
  };
}
