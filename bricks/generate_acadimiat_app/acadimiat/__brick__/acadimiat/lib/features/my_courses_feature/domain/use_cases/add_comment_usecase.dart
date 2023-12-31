import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/consultations_repository.dart';
import 'dart:convert';


class AddCommentUseCase implements UseCase< int, AddCommentParams> {
  final MyCoursesRepository repository;
  AddCommentUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(AddCommentParams bookmarkId) {
    return repository.addComment(bookmarkId);
  }
}




AddCommentParams addCommentParamsFromJson(String str) => AddCommentParams.fromJson(json.decode(str));

String addCommentParamsToJson(AddCommentParams data) => json.encode(data.toJson());

class AddCommentParams {
  AddCommentParams({
    this.id,
    this.discussionId,
  required  this.lectureId,
    this.trainerId,
  required  this.userId,
  required  this.message,
  required  this.isReplied,
    this.orginialId,
  required  this.addedDate,
  required  this.updateAt,
  });

  int ? id;
  int? discussionId;
  int lectureId;
  int  ? trainerId;
  int userId;
  String message;
  bool isReplied;
  int  ? orginialId;
  DateTime addedDate;
  DateTime updateAt;

  factory AddCommentParams.fromJson(Map<String, dynamic> json) => AddCommentParams(
    id: json["id"],
    discussionId: json["discussionId"],
    lectureId: json["lectureId"],
    trainerId: json["trainerId"],
    userId: json["userId"],
    message: json["message"],
    isReplied: json["isReplied"],
    orginialId: json["orginialId"],
    addedDate: DateTime.parse(json["addedDate"]),
    updateAt: DateTime.parse(json["updateAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "discussionId": discussionId,
    "lectureId": lectureId,
    "trainerId": trainerId,
    "userId": userId,
    "message": message,
    "isReplied": isReplied,
    "orginialId": orginialId,
    "addedDate": addedDate.toIso8601String(),
    "updateAt": updateAt.toIso8601String(),
  };
}
