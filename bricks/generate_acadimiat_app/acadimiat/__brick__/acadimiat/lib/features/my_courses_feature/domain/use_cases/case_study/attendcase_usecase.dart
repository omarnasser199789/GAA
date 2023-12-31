import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/course_case_study_entity.dart';
import '../../repositories/consultations_repository.dart';
import 'dart:convert';

class AttendCaseUseCase implements UseCase< int, AttendCaseParams> {
  final MyCoursesRepository repository;
  AttendCaseUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(AttendCaseParams params) {
    return repository.attendCase(params);
  }
}



AttendCaseParams attendCaseParamsFromJson(String str) => AttendCaseParams.fromJson(json.decode(str));

String attendCaseParamsToJson(AttendCaseParams data) => json.encode(data.toJson());

class AttendCaseParams {
  AttendCaseParams({
  required  this.caseId,
  required  this.userId,
  required  this.date,
    this.answer,
    this.answerId
  });

  int caseId;
  int userId;
  DateTime date;
  String ? answer;
  String ? answerId;

  factory AttendCaseParams.fromJson(Map<String, dynamic> json) => AttendCaseParams(
    caseId: json["caseId"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "caseId": caseId,
    "userId": userId,
    "date": date.toIso8601String(),
    // if(answer!=null)
    "answer": answer,
    "answerId": answerId,
  };
}

