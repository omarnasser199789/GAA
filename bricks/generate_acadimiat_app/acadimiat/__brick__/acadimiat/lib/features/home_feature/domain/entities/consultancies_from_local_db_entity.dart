
import 'package:equatable/equatable.dart';
class ConsultanciesFromLocalDbEntity extends Equatable {
  ConsultanciesFromLocalDbEntity({
    required  this.apiId,
    required  this.image,
    required  this.name,
    required  this.trainerName,
  });

 final int apiId;
 final String image;
 final String name;
 final String trainerName;

  @override
  List<Object?> get props => [apiId,image,name,trainerName];
}