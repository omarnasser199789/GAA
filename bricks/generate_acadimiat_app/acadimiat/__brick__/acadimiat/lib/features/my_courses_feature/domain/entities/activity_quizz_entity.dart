import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ActivityQuizzEntity extends Equatable {
  final String lectureId;
  final String userId;
  final String courseId;

  const ActivityQuizzEntity({
    required this.lectureId,
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [lectureId, userId, courseId];
}

