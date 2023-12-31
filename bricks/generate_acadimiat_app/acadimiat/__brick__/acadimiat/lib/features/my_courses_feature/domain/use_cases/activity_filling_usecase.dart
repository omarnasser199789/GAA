import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/classes/word_type3.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/activity_filling_entity.dart';
import '../repositories/consultations_repository.dart';


class ActivityFillingUseCase implements UseCase<ActivityFillingEntity, ActivityFillingParams> {
  final MyCoursesRepository repository;
  ActivityFillingUseCase({required this.repository});
  @override
  Future<Either<Failure, ActivityFillingEntity>> call(ActivityFillingParams params) {
    return repository.activityFilling(params);
  }
}





ActivityFillingParams activityFillingParamsFromJson(String str) => ActivityFillingParams.fromJson(json.decode(str));

String activityFillingParamsToJson(ActivityFillingParams data) => json.encode(data.toJson());

class ActivityFillingParams {
  ActivityFillingParams({
  required  this.userId,
  required  this.questionId,
  required  this.date,
  required  this.words,
  });

  int userId;
  int questionId;
  DateTime date;
  List<WordType3> words;

  factory ActivityFillingParams.fromJson(Map<String, dynamic> json) => ActivityFillingParams(
    userId: json["userId"],
    questionId: json["questionId"],
    date: DateTime.parse(json["date"]),
    words: List<WordType3>.from(json["words"].map((x) => WordType3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "questionId": questionId,
    "date": date.toIso8601String(),
    "words": List<dynamic>.from(words.map((x) => x.toJson())),
  };
}


