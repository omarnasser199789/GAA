import 'dart:convert';
import '../../domain/entities/BookmarkEntity.dart';
import 'my_lecture_model.dart';

BookmarkModel bookmarkModelFromJson(String str) => BookmarkModel.fromJson(json.decode(str));

String bookmarkModelToJson(BookmarkModel data) => json.encode(data.toJson());

class BookmarkModel extends BookmarkEntity{
  BookmarkModel({
  required this.id,
  required this.userId,
  required this.videoId,
  required this.atTime,
  required this.note,
   this.video,
  required this.user,
  }):super(
    id: id,
    userId: userId,
    videoId: videoId,
    atTime: atTime,
    note: note,
    video: video,
    user: user,
  );

 final int id;
 final int userId;
 final int videoId;
 final int atTime;
 final String note;
 final FileClass ? video;
 final dynamic user;

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    id: json["id"],
    userId: json["userId"],
    videoId: json["videoId"],
    atTime: json["atTime"],
    note: json["note"],
    video: (json["video"]!=null)?FileClass.fromJson(json["video"]):null,
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "videoId": videoId,
    "atTime": atTime,
    "note": note,
    "video": video,
    "user": user,
  };
}
