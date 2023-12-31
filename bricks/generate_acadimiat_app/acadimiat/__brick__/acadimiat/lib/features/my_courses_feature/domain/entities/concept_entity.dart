import 'package:equatable/equatable.dart';
class ConceptEntity extends Equatable{
  ConceptEntity({
    required this.id,
    required this.glossaryId,
    required this.userId,
    required this.concept,
    required this.definition,
    required this.keywords,
    required this.attachment,
    required this.fileId,
    required this.date,
    required this.approved,
    required this.user,
    required this.glossary,
    required this.file,
  });

  int id;
  int glossaryId;
  int userId;
  String concept;
  String definition;
  String keywords;
  String attachment;
  dynamic fileId;
  DateTime date;
  bool approved;
  dynamic user;
  dynamic glossary;
  dynamic file;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}