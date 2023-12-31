import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/activity_case_entity.dart';
import '../repositories/consultations_repository.dart';


class ActivityCaseUseCase implements UseCase<ActivityCaseEntity, ActivityCaseParams> {
  final MyCoursesRepository repository;
  ActivityCaseUseCase({required this.repository});
  @override
  Future<Either<Failure, ActivityCaseEntity>> call(ActivityCaseParams params) {
    return repository.activityCase(params);
  }
}


ActivityCaseParams activityCaseParamsFromJson(String str) => ActivityCaseParams.fromJson(json.decode(str));

String activityCaseParamsToJson(ActivityCaseParams data) => json.encode(data.toJson());

class ActivityCaseParams {
  ActivityCaseParams({
  required this.answerId,
  required this.caseId,
  required this.date,
  required this.email,
  required this.userId,
  });

  int answerId;
  int caseId;
  DateTime date;
  String email;
  int userId;

  factory ActivityCaseParams.fromJson(Map<String, dynamic> json) => ActivityCaseParams(
    answerId: json["answerId"],
    caseId: json["caseId"],
    date: DateTime.parse(json["date"]),
    email: json["email"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "answerId": answerId,
    "caseId": caseId,
    "date": date.toIso8601String(),
    "email": email,
    "userId": userId,
  };
}





