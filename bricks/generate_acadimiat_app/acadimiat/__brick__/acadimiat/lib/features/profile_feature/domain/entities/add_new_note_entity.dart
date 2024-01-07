import 'package:equatable/equatable.dart';

import '../../data/models/add_new_note_model.dart';
class AddNewNoteEntity extends Equatable{

  const AddNewNoteEntity({
    required  this.id,
    required  this.userId,
    required  this.notes,
  });

  final int id;
  final int userId;
  final List<Note> notes;

  @override
  List<Object?> get props => [id];
}