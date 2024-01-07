import 'package:equatable/equatable.dart';
class MyCertificatesEntity extends Equatable{

  const MyCertificatesEntity({
    required  this.id,
    required  this.courseId,
    required  this.course,
    required  this.userId,
    required  this.curriculaId,
    required  this.certificateName,
    required  this.image,
    required  this.courseName,
    required  this.curricula,
    required  this.certificates,
  });

  final int id;
  final int courseId;
  final dynamic course;
  final dynamic userId;
  final dynamic curriculaId;
  final String certificateName;
  final String image;
  final String courseName;
  final dynamic curricula;
  final dynamic certificates;

  @override
  List<Object?> get props => [id];
}