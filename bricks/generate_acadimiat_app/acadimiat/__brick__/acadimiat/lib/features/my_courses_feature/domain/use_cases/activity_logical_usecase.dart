import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/classes/word_type3.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/my_lecture_model.dart';
import '../entities/activity_filling_entity.dart';
import '../entities/activity_logical_entity.dart';
import '../repositories/consultations_repository.dart';


class ActivityLogicalUseCase implements UseCase<ActiveLogicalEntity, ActivityLogicalParams> {
  final MyCoursesRepository repository;
  ActivityLogicalUseCase({required this.repository});
  @override
  Future<Either<Failure, ActiveLogicalEntity>> call(ActivityLogicalParams params) {
    return repository.activityLogical(params);
  }
}


ActivityLogicalParams activityLogicalParamsFromJson(String str) => ActivityLogicalParams.fromJson(json.decode(str));

String activityLogicalParamsToJson(ActivityLogicalParams data) => json.encode(data.toJson());

class ActivityLogicalParams {
  ActivityLogicalParams({
  required this.userId,
  required this.questionId,
  required this.date,
  required this.orders,
  });

  int userId;
  int questionId;
  DateTime date;
  List<Order> orders;

  factory ActivityLogicalParams.fromJson(Map<String, dynamic> json) => ActivityLogicalParams(
    userId: json["userId"],
    questionId: json["questionId"],
    date: DateTime.parse(json["date"]),
    orders: List<Order>.from(json["orders"].map((x) => Sentence.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "questionId": questionId,
    "date": date.toIso8601String(),
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
  required  this.sentenceId,
  required  this.order,
  });

  int sentenceId;
  int order;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    sentenceId: json["sentenceId"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "sentenceId": sentenceId,
    "order": order,
  };
}



