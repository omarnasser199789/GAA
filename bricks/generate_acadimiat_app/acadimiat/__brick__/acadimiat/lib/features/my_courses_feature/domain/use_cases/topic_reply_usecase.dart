import 'package:acadmiat/features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'dart:convert';
import '../entities/topic_reply_entity.dart';

class TopicReplyUseCase implements UseCase<TopicReplyEntity, TopicReplyParams> {
  final MyCoursesRepository repository;
  TopicReplyUseCase({required this.repository});

  @override
  Future<Either<Failure, TopicReplyEntity>> call(TopicReplyParams params) {
    return repository.topicReply(params);
  }
}

TopicReplyParams topicReplyParamsFromJson(String str) => TopicReplyParams.fromJson(json.decode(str));

String topicReplyParamsToJson(TopicReplyParams data) => json.encode(data.toJson());

class TopicReplyParams {
  TopicReplyParams({
   this.id,
  required this.topicId,
  required this.userId,
  required this.reply,
  required this.attachment,
  required this.date,
  });

 final  int ? id;
 final  int topicId;
 final  int userId;
 final  String reply;
 final  String attachment;
 final  DateTime date;

  factory TopicReplyParams.fromJson(Map<String, dynamic> json) => TopicReplyParams(
    id: json["id"],
    topicId: json["topicId"],
    userId: json["userId"],
    reply: json["reply"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicId": topicId,
    "userId": userId,
    "reply": reply,
    "attachment": attachment,
    "date": date.toIso8601String(),
  };
}
