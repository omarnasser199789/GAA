// To parse this JSON data, do
//
//     final addNewNoteModel = addNewNoteModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/add_new_note_entity.dart';

AddNewNoteModel addNewNoteModelFromJson(String str) => AddNewNoteModel.fromJson(json.decode(str));

String addNewNoteModelToJson(AddNewNoteModel data) => json.encode(data.toJson());

class AddNewNoteModel  extends AddNewNoteEntity{
  AddNewNoteModel({
  required  this.id,
  required  this.userId,
  required  this.notes,
  }):super(
    id:id,
    userId:userId,
    notes:notes,
  );

 final int id;
 final int userId;
 final List<Note> notes;

  factory AddNewNoteModel.fromJson(Map<String, dynamic> json) => AddNewNoteModel(
    id: json["id"],
    userId: json["userId"],
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
  };
}

class Note {
  Note({
 required  this.id,
 required  this.bookId,
 required  this.notes,
 required  this.timeOnVideo,
 required  this.lectureId,
 required  this.lecture,
 required  this.createdAt,
  });

  int id;
  int bookId;
  String notes;
  dynamic timeOnVideo;
  dynamic lectureId;
  dynamic lecture;
  DateTime createdAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    bookId: json["bookId"],
    notes: json["notes"],
    timeOnVideo: json["timeOnVideo"],
    lectureId: json["lectureId"],
    lecture: json["lecture"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookId": bookId,
    "notes": notes,
    "timeOnVideo": timeOnVideo,
    "lectureId": lectureId,
    "lecture": lecture,
    "createdAt": createdAt.toIso8601String(),
  };
}
