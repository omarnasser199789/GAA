import 'package:dartz/dartz.dart';
import 'dart:convert';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/add_new_note_entity.dart';
import '../../repositories/profile_repository.dart';


class AddNewNoteUseCase implements UseCase<AddNewNoteEntity, AddNewNoteParams> {
  final ProfileRepository repository;
  AddNewNoteUseCase({required this.repository});


  @override
  Future<Either<Failure, AddNewNoteEntity>> call(AddNewNoteParams params) {
    return repository.addNewNote(params);
  }
}




AddNewNoteParams addNewNoteParamsFromJson(String str) => AddNewNoteParams.fromJson(json.decode(str));

String addNewNoteParamsToJson(AddNewNoteParams data) => json.encode(data.toJson());

class AddNewNoteParams {
  AddNewNoteParams({
     this.id,
    required this.bookId,

  required  this.notes,
  required  this.createdAt,
  });

  int  bookId;
  int ? id;
  String notes;
  DateTime createdAt;

  factory AddNewNoteParams.fromJson(Map<String, dynamic> json) => AddNewNoteParams(
    id: json["id"],
    bookId: json["bookId"],
    notes: json["notes"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {

    "id": id,
    "bookId": bookId,
    "notes": notes,
    "createdAt": createdAt.toIso8601String(),
  };
}

