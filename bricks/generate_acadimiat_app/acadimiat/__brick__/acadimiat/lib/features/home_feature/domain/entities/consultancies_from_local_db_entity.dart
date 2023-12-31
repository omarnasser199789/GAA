
import 'package:equatable/equatable.dart';
class ConsultanciesFromLocalDbEntity extends Equatable {
  ConsultanciesFromLocalDbEntity({
    required  this.apiId,
    required  this.image,
    required  this.name,
    required  this.trainerName,
  });

  int apiId;
  String image;
  String name;
  String trainerName;

  @override
  List<Object?> get props => [apiId,image,name,trainerName];
}