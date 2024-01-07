
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

 final int id;
 final int userId;
 final int videoId;
 final int atTime;
 final String note;
 final FileClass ? video;
 final dynamic user;

}