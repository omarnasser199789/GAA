import 'package:flutter/material.dart';

import 'features/my_courses_feature/domain/entities/my_course_entity.dart';

class Item {
  Item({required this.header,
    this.lectureId,
    this.myCourseEntity,
    required this.body,
    this.index,
    this.part,
    this.type,
    this.time,
    this.canTapOnHeader,
    this.startHere,this.isExpanded});
  Widget header;
  Widget body;
  bool ? startHere;
  bool ? isExpanded;
  bool ? canTapOnHeader;
  int ? lectureId;
  int ? part;
  int ? type;
  int ? index;
  double ? time;
  MyCourseEntity ? myCourseEntity;
}
