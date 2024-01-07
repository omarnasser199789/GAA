import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/activity_match_entity.dart';
import '../repositories/consultations_repository.dart';

class ActivityMatchingUseCase implements UseCase< ActivityMatchEntity, ActivityMatchParams> {
  final MyCoursesRepository repository;
  ActivityMatchingUseCase({required this.repository});
  @override
  Future<Either<Failure, ActivityMatchEntity>> call(ActivityMatchParams params) {
    return repository.activityMatch(params);
  }
}

ActivityMatchParams activityMatchParamsFromJson(String str) => ActivityMatchParams.fromJson(json.decode(str));

String activityMatchParamsToJson(ActivityMatchParams data) => json.encode(data.toJson());

class ActivityMatchParams {
  ActivityMatchParams({
  required  this.userId,
  required  this.questionId,
  required  this.date,
  required  this.matched,
  });

  int userId;
  int questionId;
  DateTime date;
  List<Matched> matched;

  factory ActivityMatchParams.fromJson(Map<String, dynamic> json) => ActivityMatchParams(
    userId: json["userId"],
    questionId: json["questionId"],
    date: DateTime.parse(json["date"]),
    matched: List<Matched>.from(json["matched"].map((x) => Matched.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "questionId": questionId,
    "date": date.toIso8601String(),
    "matched": List<dynamic>.from(matched.map((x) => x.toJson())),
  };
}

class Matched {
  Matched({

  required  this.pairId,
  required  this.questionId,
  required  this.selectedId,
  });


  int pairId;
  int questionId;
  int selectedId;

  factory Matched.fromJson(Map<String, dynamic> json) => Matched(
    pairId: json["pairId"],
    questionId: json["questionId"],
    selectedId: json["selectedId"],
  );

  Map<String, dynamic> toJson() => {
    "pairId": pairId,
    "questionId": questionId,
    "selectedId": selectedId,
  };
}
