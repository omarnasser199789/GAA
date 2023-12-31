import 'package:equatable/equatable.dart';
class ArticleDetailsEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  ArticleDetailsEntity({
    required this.id,
    required this.articleId,
    required this.userId,
    required this.header,
    required this.body,
    required this.date,
    required this.isPublished,
    required this.user,
    required this.article,
  });

  int id;
  int articleId;
  int userId;
  String header;
  String body;
  DateTime date;
  bool isPublished;
  dynamic user;
  dynamic article;
}