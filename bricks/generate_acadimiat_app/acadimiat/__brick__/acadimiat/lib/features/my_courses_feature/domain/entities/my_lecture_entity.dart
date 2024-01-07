
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

 final int materialId;
 final String materialName;
 final int unitId;
 final int order;
 final String materialLink;
 final String materialLength;
 final bool isDone;
 final double totalScore;
 final dynamic completitionDate;
 final CurrentVideo  currentVideo;
 final Discussion  discussion;
 final List<NestedContent> contents;
}