import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/activity_decision_entity.dart';
import '../../repositories/consultations_repository.dart';
import 'dart:convert';

class ActivityDecisionUseCase implements UseCase< ActivityDecisionEntity, ActivityDecisionParams> {
  final MyCoursesRepository repository;
  ActivityDecisionUseCase({required this.repository});
  @override
  Future<Either<Failure, ActivityDecisionEntity>> call(ActivityDecisionParams params) {
    return repository.activityDecision(params);
  }
}

ActivityDecisionParams activityDecisionParamsFromJson(String str) => ActivityDecisionParams.fromJson(json.decode(str));

String activityDecisionParamsToJson(ActivityDecisionParams data) => json.encode(data.toJson());

class ActivityDecisionParams {
  ActivityDecisionParams({
  required  this.decisionId,
  required  this.opinion,
  required  this.email,
  required  this.userId,
  required  this.attendanceAt,
  required  this.repliedAt,
  });

 final int decisionId;
 final String opinion;
 final String email;
 final String userId;
 final DateTime attendanceAt;
 final DateTime repliedAt;

  factory ActivityDecisionParams.fromJson(Map<String, dynamic> json) => ActivityDecisionParams(
    decisionId: json["decisionId"],
    opinion: json["opinion"],
    email: json["email"],
    userId: json["userId"],
    attendanceAt: DateTime.parse(json["attendanceAt"]),
    repliedAt: DateTime.parse(json["repliedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "decisionId": decisionId,
    "opinion": opinion,
    "email": email,
    "userId": userId,
    "attendanceAt": attendanceAt.toIso8601String(),
    "repliedAt": repliedAt.toIso8601String(),
  };
}
