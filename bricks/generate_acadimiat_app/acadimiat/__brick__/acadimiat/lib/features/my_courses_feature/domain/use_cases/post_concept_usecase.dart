import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/concept_entity.dart';
import '../repositories/consultations_repository.dart';
import 'dart:convert';

class PostConceptUseCase implements UseCase< ConceptEntity, PostConceptParams> {
  final MyCoursesRepository repository;
  PostConceptUseCase({required this.repository});
  @override
  Future<Either<Failure,  ConceptEntity >> call(PostConceptParams params) {
    return repository.postConcept(params);
  }
}


PostConceptParams postConceptParamsFromJson(String str) => PostConceptParams.fromJson(json.decode(str));

String postConceptParamsToJson(PostConceptParams data) => json.encode(data.toJson());

class PostConceptParams {
  PostConceptParams({
  required  this.approved,
  required  this.attachment,
  required  this.concept,
  required  this.date,
  required  this.definition,
    this.fileId,
  required  this.glossaryId,
    this.id,
  required  this.isPublic,
  required  this.keywords,
  required  this.userId,
  });

  bool approved;
  String attachment;
  String concept;
  DateTime date;
  String definition;
  int ? fileId;
  int glossaryId;
  int ? id;
  String isPublic;
  String keywords;
  int userId;

  factory PostConceptParams.fromJson(Map<String, dynamic> json) => PostConceptParams(
    approved: json["approved"],
    attachment: json["attachment"],
    concept: json["concept"],
    date: DateTime.parse(json["date"]),
    definition: json["definition"],
    fileId: json["fileId"],
    glossaryId: json["glossaryId"],
    id: json["id"],
    isPublic: json["isPublic"],
    keywords: json["keywords"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "approved": approved,
    "attachment": attachment,
    "concept": concept,
    "date": date.toIso8601String(),
    "definition": definition,
    "fileId": fileId,
    "glossaryId": glossaryId,
    "id": id,
    "isPublic": isPublic,
    "keywords": keywords,
    "userId": userId,
  };
}

