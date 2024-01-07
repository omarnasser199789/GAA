import 'dart:convert';
import '../../domain/entities/concept_entity.dart';

ConceptModel conceptModelFromJson(String str) => ConceptModel.fromJson(json.decode(str));

String conceptModelToJson(ConceptModel data) => json.encode(data.toJson());

class ConceptModel  extends ConceptEntity{
  ConceptModel({
  required this.id,
  required this.glossaryId,
  required this.userId,
  required this.concept,
  required this.definition,
  required this.keywords,
  required this.attachment,
   this.fileId,
  required this.date,
  required this.approved,
   this.user,
   this.glossary,
   this.file,
  }):super(
    id:id,
    glossaryId:glossaryId,
    userId:userId,
    concept:concept,
    definition:definition,
    keywords:keywords,
    attachment:attachment,
    fileId:fileId,
    date:date,
    approved:approved,
    user:user,
    glossary:glossary,
    file:file,
  );

 final int id;
 final int glossaryId;
 final int userId;
 final String concept;
 final String definition;
 final String keywords;
 final String attachment;
 final dynamic fileId;
 final DateTime date;
 final bool approved;
 final dynamic user;
 final dynamic glossary;
 final dynamic file;

  factory ConceptModel.fromJson(Map<String, dynamic> json) => ConceptModel(
    id:( json["id"]!=null)? json["id"]:-1,
    glossaryId: (json["glossaryId"]!=null)?json["glossaryId"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    concept: (json["concept"]!=null)?json["concept"]:"",
    definition: (json["definition"]!=null)?json["definition"]:"",
    keywords:( json["keywords"]!=null)? json["keywords"]:"",
    attachment: (json["attachment"]!=null)?json["attachment"]:"",
    fileId: json["fileId"],
    date:(json["date"]!=null)? DateTime.parse(json["date"]):DateTime.now(),
    approved: (json["approved"]!=null)?json["approved"]:false,
    user: json["user"],
    glossary: json["glossary"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "glossaryId": glossaryId,
    "userId": userId,
    "concept": concept,
    "definition": definition,
    "keywords": keywords,
    "attachment": attachment,
    "fileId": fileId,
    "date": date.toIso8601String(),
    "approved": approved,
    "user": user,
    "glossary": glossary,
    "file": file,
  };
}
