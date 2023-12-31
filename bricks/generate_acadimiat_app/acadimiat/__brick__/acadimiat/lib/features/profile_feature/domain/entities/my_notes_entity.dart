import 'package:equatable/equatable.dart';

import '../../data/models/my_notes_model.dart';
class MyNoteEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  MyNoteEntity({
    required  this.id,
    required  this.userId,
    required  this.notes,
  });

  int id;
  int userId;
  List<Note> notes;
}