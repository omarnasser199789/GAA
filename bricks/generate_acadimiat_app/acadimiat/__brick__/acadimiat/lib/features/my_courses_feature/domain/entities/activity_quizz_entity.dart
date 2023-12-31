import 'package:equatable/equatable.dart';
class ActivityQuizzEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  ActivityQuizzEntity({
    required  this.lectureId,
    required  this.userId,
    required  this.courseId,
  });

  String lectureId;
  String userId;
  String courseId;

}