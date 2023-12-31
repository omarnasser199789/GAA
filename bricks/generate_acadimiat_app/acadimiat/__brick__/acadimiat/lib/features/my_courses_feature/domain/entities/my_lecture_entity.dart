
import 'package:equatable/equatable.dart';

import '../../data/models/my_lecture_model.dart';

class MyLectureEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  MyLectureEntity({
    required this.materialId,
    required this.materialName,
    required this.unitId,
    required this.order,
    required this.materialLink,
    required this.materialLength,
    required this.isDone,
    required this.totalScore,
    required this.completitionDate,
    required this.currentVideo,
    required  this.discussion,
    required this.contents,
  });

  int materialId;
  String materialName;
  int unitId;
  int order;
  String materialLink;
  String materialLength;
  bool isDone;
  double totalScore;
  dynamic completitionDate;
  CurrentVideo  currentVideo;
  Discussion  discussion;
  List<NestedContent> contents;
}