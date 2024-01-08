import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/item_body.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/item_header.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/nested_body.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/widgets_for_lossonsTab_sidebarTab/nested_header.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../item.dart';
import '../../../../../../../splash_screen.dart';
import '../../../../../domain/entities/my_course_entity.dart';

class LessonsTab extends StatefulWidget {
  const LessonsTab(
      {super.key,
      required this.myCourseEntity,
      this.part,
      this.isVimeo,
     required   this.courseCover,
      this.currentVideoIndex});

  final MyCourseEntity myCourseEntity;
  final int? part;
  final bool? isVimeo;
  final int? currentVideoIndex;
  final String courseCover;

  @override
  State<LessonsTab> createState() => _LessonsTabState();
}

bool startHere = true;

class _LessonsTabState extends State<LessonsTab> {
  List<Item> items = [];

  @override
   void initState()  {
     super.initState();
     initConnection();
    items = [];
    for (int j = 0; widget.myCourseEntity.courseContents.length > j; j++) {
      List<Item> nestedList = [];
     double partTime=0;

      for (int i = 0; widget.myCourseEntity.courseContents[j].contents.length > i; i++) {
        if(widget.myCourseEntity.courseContents[j].contents[i].lectureContents.isNotEmpty) {
          partTime += widget.myCourseEntity.courseContents[j].contents[i].lectureContents[0].time;
        }
        nestedList.add(Item(
            header: NestedHeader(
              startHere: true,
              lessonNumber: i,
            ),
            body: NestedBody(name: widget.myCourseEntity.courseContents[j].contents[i].name, width: 130),
            time:(widget.myCourseEntity.courseContents[j].contents[i].lectureContents.isNotEmpty)?
            widget.myCourseEntity.courseContents[j].contents[i].lectureContents[0].time:0,
            isExpanded: !widget.myCourseEntity.courseContents[j].contents[i].isDone,
            type: widget.myCourseEntity.courseContents[j].contents[i].type,
            lectureId: widget.myCourseEntity.courseContents[j].contents[i].id,
            myCourseEntity: widget.myCourseEntity,
            index: i,
            part: j,
          ));
      }
      items.add(Item(
          header: ItemHeader(
            width: 104,
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            unitName: widget.myCourseEntity.courseContents[j].unitName,
            tutorialsNumber:
                widget.myCourseEntity.courseContents[j].contents.length,
            partTime:partTime,
          ),
          body: ItemBody(
            courseCover: widget.courseCover,
            nestedList: nestedList,
          ),
          isExpanded: !widget.myCourseEntity.courseContents[j].isDone,
        ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      dividerColor:Theme.of(context).canvasColor.withOpacity(0.1),
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (index, isExpanded) {
        setState(() {
          items[index].isExpanded = !items[index].isExpanded!;
        });
      },
      animationDuration: const Duration(milliseconds: 600),
      children: items.map((item) => ExpansionPanel(
        canTapOnHeader: (item.canTapOnHeader!=null)?item.canTapOnHeader!:true,
        headerBuilder: (_, isExpanded) => item.header,
        body: item.body,
        isExpanded: item.isExpanded!,
      ),
      ).toList(),
    );
  }
}
