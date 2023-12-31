import 'package:acadmiat/features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

import '../entities/activity_quizz_entity.dart';
import '../repositories/consultations_repository.dart';

class ActivityQuizzUseCase implements UseCase<ActivityQuizzEntity, ActivityQuizzParams> {
  final MyCoursesRepository repository;
  ActivityQuizzUseCase({required this.repository});
  @override
  Future<Either<Failure, ActivityQuizzEntity>> call(ActivityQuizzParams params) {
    return repository.activityQuizz(params);
  }
}


class ActivityQuizzParams{
  QuizzParams quizzParams;
  String connectionId;
  ActivityQuizzParams({
    required this.quizzParams,
    required this.connectionId,
  });
}


QuizzParams activityQuizzParamsFromJson(String str) => QuizzParams.fromJson(json.decode(str));

String activityQuizzParamsToJson(QuizzParams data) => json.encode(data.toJson());

class QuizzParams {
  QuizzParams({
  required  this.userId,
  required  this.contentId,
  required  this.quizzId,
  required  this.attendedAt,
  required  this.finished,
  required  this.attendanceTable,
  });

  String userId;
  int contentId;
  int quizzId;
  DateTime attendedAt;
  bool finished;
  List<AttendanceTable> attendanceTable;

  factory QuizzParams.fromJson(Map<String, dynamic> json) => QuizzParams(
    userId: json["userId"],
    contentId: json["contentId"],
    quizzId: json["quizzId"],
    attendedAt: DateTime.parse(json["attendedAt"]),
    finished: json["finished"],
    attendanceTable: List<AttendanceTable>.from(json["attendanceTable"].map((x) => AttendanceTable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "contentId": contentId,
    "quizzId": quizzId,
    "attendedAt": attendedAt.toIso8601String(),
    "finished": finished,
    "attendanceTable": List<dynamic>.from(attendanceTable.map((x) => x.toJson())),
  };
}








