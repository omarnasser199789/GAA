import 'package:equatable/equatable.dart';

import '../../data/models/add_new_note_model.dart';
class AddNewNoteEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  AddNewNoteEntity({
    required  this.id,
    required  this.userId,
    required  this.notes,
  });

  int id;
  int userId;
  List<Note> notes;
}