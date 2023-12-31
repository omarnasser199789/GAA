import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/my_plans_entity.dart';
import '../../repositories/profile_repository.dart';
import 'dart:convert';

class PostMyPlanUseCase implements UseCase<int, PostMyPlanParams> {
  final ProfileRepository repository;
  PostMyPlanUseCase({required this.repository});


  @override
  Future<Either<Failure, int>> call(PostMyPlanParams params) {
    return repository.postMyPlan(params);
  }


}


PostMyPlanParams postMyPlanParamsFromJson(String str) => PostMyPlanParams.fromJson(json.decode(str));

String postMyPlanParamsToJson(PostMyPlanParams data) => json.encode(data.toJson());

class PostMyPlanParams {
  PostMyPlanParams({
  required  this.id,
  required  this.userId,
  required  this.type,
  required  this.fromDate,
  required  this.toDate,
  required  this.reminder,
  required  this.isCompleted,
  required  this.timePlan,
  });

  dynamic id;
  String userId;
  int type;
  DateTime fromDate;
  DateTime toDate;
  bool reminder;
  bool isCompleted;
  TimePlan timePlan;

  factory PostMyPlanParams.fromJson(Map<String, dynamic> json) => PostMyPlanParams(
    id: json["id"],
    userId: json["userId"],
    type: json["type"],
    fromDate: DateTime.parse(json["fromDate"]),
    toDate: DateTime.parse(json["toDate"]),
    reminder: json["reminder"],
    isCompleted: json["isCompleted"],
    timePlan: TimePlan.fromJson(json["timePlan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "type": type,
    "fromDate": fromDate.toIso8601String(),
    "toDate": toDate.toIso8601String(),
    "reminder": reminder,
    "isCompleted": isCompleted,
    "timePlan": timePlan.toJson(),
  };
}

class TimePlan {
  TimePlan({
  required  this.id,
  required  this.totalToAchieve,
  });

  dynamic id;
  int totalToAchieve;

  factory TimePlan.fromJson(Map<String, dynamic> json) => TimePlan(
    id: json["id"],
    totalToAchieve: json["totalToAchieve"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalToAchieve": totalToAchieve,
  };
}







