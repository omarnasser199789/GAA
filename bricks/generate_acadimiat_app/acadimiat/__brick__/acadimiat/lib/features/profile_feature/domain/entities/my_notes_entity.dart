import 'package:equatable/equatable.dart';

import '../../data/models/my_notes_model.dart';

class MyNoteEntity extends Equatable{
  final int id;
  final int userId;
  final List<Note> notes;

  const MyNoteEntity({
    required  this.id,
    required  this.userId,
    required  this.notes,
  });

  @override
  List<Object?> get props => [id, userId, notes];
}