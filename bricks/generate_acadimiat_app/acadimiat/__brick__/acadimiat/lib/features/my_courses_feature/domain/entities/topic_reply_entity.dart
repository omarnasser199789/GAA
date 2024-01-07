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

 final int id;
 final int topicId;
 final int userId;
 final String reply;
 final String attachment;
 final DateTime date;
 final dynamic user;
 final dynamic topic;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}