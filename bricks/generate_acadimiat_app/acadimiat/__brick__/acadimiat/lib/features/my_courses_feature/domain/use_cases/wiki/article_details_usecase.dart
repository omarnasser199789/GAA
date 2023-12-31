import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/article_details_entity.dart';
import '../../repositories/consultations_repository.dart';
import 'dart:convert';


class ArticleDetailsUseCase implements UseCase< ArticleDetailsEntity, ArticleDetailsParams> {
  final MyCoursesRepository repository;
  ArticleDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, ArticleDetailsEntity>> call(ArticleDetailsParams params) {
    return repository.articleDetails(params);
  }
}


ArticleDetailsParams articleDetailsParamsFromJson(String str) => ArticleDetailsParams.fromJson(json.decode(str));

String articleDetailsParamsToJson(ArticleDetailsParams data) => json.encode(data.toJson());

class ArticleDetailsParams {
  ArticleDetailsParams({
    this.id,
   required this.articleId,
   required this.userId,
   required this.header,
   required this.body,
   required this.date,
   required this.isPublished,
  });

  int ? id;
  int articleId;
  int userId;
  String header;
  String body;
  DateTime date;
  bool isPublished;

  factory ArticleDetailsParams.fromJson(Map<String, dynamic> json) => ArticleDetailsParams(
    id: json["id"],
    articleId: json["articleId"],
    userId: json["userId"],
    header: json["header"],
    body: json["body"],
    date: DateTime.parse(json["date"]),
    isPublished: json["isPublished"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "articleId": articleId,
    "userId": userId,
    "header": header,
    "body": body,
    "date": date.toIso8601String(),
    "isPublished": isPublished,
  };
}


