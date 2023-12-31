import 'package:equatable/equatable.dart';

import '../../data/models/discussion_model.dart';

class DiscussionEntity extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  DiscussionEntity({
    required  this.discussionId,
    required  this.lectureId,
    required  this.timeline,
  });

  int discussionId;
  int lectureId;
  List<Timeline> timeline;
}