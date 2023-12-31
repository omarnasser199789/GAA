import 'package:equatable/equatable.dart';
class TopicReplyEntity extends Equatable{
  TopicReplyEntity({
    required this.id,
    required this.topicId,
    required this.userId,
    required this.reply,
    required this.attachment,
    required this.date,
    required this.user,
    required this.topic,
  });

  int id;
  int topicId;
  int userId;
  String reply;
  String attachment;
  DateTime date;
  dynamic user;
  dynamic topic;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}