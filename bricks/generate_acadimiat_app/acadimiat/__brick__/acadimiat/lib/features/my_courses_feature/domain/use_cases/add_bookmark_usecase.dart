import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/BookmarkEntity.dart';
import '../entities/discussion_entity.dart';
import '../repositories/consultations_repository.dart';


class AddBookmarkUseCase implements UseCase< BookmarkEntity, AddBookMarkParams> {
  final MyCoursesRepository repository;
  AddBookmarkUseCase({required this.repository});
  @override
  Future<Either<Failure, BookmarkEntity>> call(AddBookMarkParams params) {
    return repository.addBookmark(params);
  }
}


AddBookMarkParams addBookMarkParamsFromJson(String str) => AddBookMarkParams.fromJson(json.decode(str));

String addBookMarkParamsToJson(AddBookMarkParams data) => json.encode(data.toJson());


class AddBookMarkParams {
  AddBookMarkParams({
    this.id,
  required  this.userId,
  required  this.videoId,
  required  this.atTime,
  required  this.note,
  });

  int ? id;
  int userId;
  int videoId;
  int atTime;
  String note;

  factory AddBookMarkParams.fromJson(Map<String, dynamic> json) => AddBookMarkParams(
    id: json["id"],
    userId: json["userId"],
    videoId: json["videoId"],
    atTime: json["atTime"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "videoId": videoId,
    "atTime": atTime,
    "note": note,
  };
}
