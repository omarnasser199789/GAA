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

 final int id;
 final int articleId;
 final int userId;
 final String header;
 final String body;
 final DateTime date;
 final bool isPublished;
 final dynamic user;
 final dynamic article;
}