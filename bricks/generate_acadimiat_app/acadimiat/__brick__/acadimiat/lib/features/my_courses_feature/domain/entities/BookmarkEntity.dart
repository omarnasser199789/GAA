
import 'package:equatable/equatable.dart';

import '../../data/models/my_lecture_model.dart';


class BookmarkEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

  BookmarkEntity({
    required this.id,
    required this.userId,
    required this.videoId,
    required this.atTime,
    required this.note,
     this.video,
    required this.user,
  });

  int id;
  int userId;
  int videoId;
  int atTime;
  String note;
  FileClass ? video;
  dynamic user;

}