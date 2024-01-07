import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../../../domain/entities/my_course_entity.dart';
import '../../../../../../../../../item.dart';
import 'package:rxdart/rxdart.dart';
import '../../widgets_for_lossonsTab_sidebarTab/item_body.dart';
import '../../widgets_for_lossonsTab_sidebarTab/item_header.dart';
import '../../widgets_for_lossonsTab_sidebarTab/nested_body.dart';
import '../../widgets_for_lossonsTab_sidebarTab/nested_header.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
    required this.courseCover,
    required this.myCourseEntity,

  }) : super(key: key);
  final MyCourseEntity myCourseEntity;
  final String courseCover;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;

  final _animationDuration = const Duration(milliseconds: 250);
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;

  List<Item> items = [];
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

    items = [];
    for (int j = 0; widget.myCourseEntity.courseContents.length > j; j++) {
      List<Item> nestedList = [];
      double partTime=0;

      for (int i = 0;
          widget.myCourseEntity.courseContents[j].contents.length > i;
          i++) {
        if(widget.myCourseEntity.courseContents[j].contents[i]
            .lectureContents.isNotEmpty) {
          partTime += widget.myCourseEntity.courseContents[j].contents[i]
              .lectureContents[0].time;

        }


        ///توليد القائمة الداخليه
        nestedList.add(Item(
          header: NestedHeader(
            startHere: true,
            lessonNumber: i,
          ),
          body: NestedBody(
            name: widget.myCourseEntity.courseContents[j].contents[i].name,
            width: 160,
          ),
          time:(widget.myCourseEntity.courseContents[j].contents[i].lectureContents.isNotEmpty)?
          widget.myCourseEntity.courseContents[j].contents[i].lectureContents[0].time:0,
          isExpanded:
              !widget.myCourseEntity.courseContents[j].contents[i].isDone,
          lectureId: widget.myCourseEntity.courseContents[j].contents[i].id,
          myCourseEntity: widget.myCourseEntity,
          index: i,
          part: j,
        ));
      }

      /// القائمة الخارجية
      items.add(
        Item(
          header: ItemHeader(
            width: 140,
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 0),
            unitName: widget.myCourseEntity.courseContents[j].unitName,
            tutorialsNumber:
                widget.myCourseEntity.courseContents[j].contents.length,
            partTime:partTime,
          ),
          body: ItemBody(
            fromSideBar: true,
            nestedList: nestedList,
            courseCover: widget.courseCover,
          ),
          isExpanded: !widget.myCourseEntity.courseContents[j].isDone,
        ),
      );
    }

  }


  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    // vimeoVideoWidgetKey.currentState!.stopVideo();
    // await Future.delayed(Duration(microseconds: 1000));
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {

      // vimeoVideoWidgetKey.currentState!.playVideo();
      // amazonVideoWidgetKey.currentState!.playVideo();
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {

      // vimeoVideoWidgetKey.currentState!.stopVideo();
      // amazonVideoWidgetKey.currentState!.stopVideo();
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSideBarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
            right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 30,
            child: Row(
              children: <Widget>[
                Align(
                  alignment:  Alignment(0, 0),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: AnimatedIcon(
                            progress: _animationController.view,
                            icon: AnimatedIcons.menu_close,
                            color: Theme.of(context).canvasColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    color: Theme.of(context).cardColor,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),//
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor, //
                                borderRadius: BorderRadius.circular(0)),
                            child: ExpansionPanelList(
                              elevation: 0,
                              expandedHeaderPadding: EdgeInsets.zero,
                              expansionCallback: (index, isExpanded) {
                                setState(() {
                                  items[index].isExpanded =
                                      !items[index].isExpanded!;
                                  setState(() {});
                                });
                              },
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              children: items
                                  .map(
                                    (item) => ExpansionPanel(
                                      canTapOnHeader: (item.canTapOnHeader!=null)?item.canTapOnHeader!:true,
                                      headerBuilder: (_, isExpanded) =>
                                          item.header,
                                      body: item.body,
                                      isExpanded: item.isExpanded!,
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
