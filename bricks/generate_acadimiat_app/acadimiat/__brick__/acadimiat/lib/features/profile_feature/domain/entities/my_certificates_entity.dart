import 'package:equatable/equatable.dart';
class MyCertificatesEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  MyCertificatesEntity({
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

  int id;
  int courseId;
  dynamic course;
  dynamic userId;
  dynamic curriculaId;
  String certificateName;
  String image;
  String courseName;
  dynamic curricula;
  dynamic certificates;
}