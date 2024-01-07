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

 final int id;
 final int glossaryId;
 final int userId;
 final String concept;
 final String definition;
 final String keywords;
 final String attachment;
 final dynamic fileId;
 final DateTime date;
 final bool approved;
 final dynamic user;
 final dynamic glossary;
 final dynamic file;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}