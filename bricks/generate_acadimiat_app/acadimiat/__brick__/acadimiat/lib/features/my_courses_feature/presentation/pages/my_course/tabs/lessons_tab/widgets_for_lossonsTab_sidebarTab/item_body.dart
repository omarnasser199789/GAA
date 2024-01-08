import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/pages/slide_bar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../../../exam_folder/exam_info_page.dart';
import '../../../../../bloc/my_courses_bloc.dart';
import '../../../../../bloc/my_courses_event.dart';
import '../../../../../../../../item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemBody extends StatefulWidget {
  const ItemBody({super.key, required this.nestedList,required this.courseCover, this.fromSideBar});

  final List<Item> nestedList;
  final bool? fromSideBar;
  final String courseCover;

  @override
  State<ItemBody> createState() => _ItemBodyState();
}

int currentIndex=0;

class _ItemBodyState extends State<ItemBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: List<Widget>.generate(widget.nestedList.length,(index){
        return GestureDetector(
          onTap: () async {
            setState(() {});
            if(widget.nestedList[index].type==2) {
              goTo(context, (context) => ExamInfoPage(quizzId: widget.nestedList[index].lectureId!,));
            }
            else{
              EdgeInsets mediaQueryPadding =  MediaQuery.of(context).padding;
              if(widget.fromSideBar==null) {
                await showModalBottomSheet(
                    context: context,
                    backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                    isScrollControlled: true,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context, StateSetter _) {
                        return SizedBox(
                            height: size.height-mediaQueryPadding.top,
                            child: Material(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                child: SideBarLayout(
                                  courseCover: widget.courseCover,
                                  lectureId: widget.nestedList[index].lectureId!,
                                  myCourseEntity: widget.nestedList[index].myCourseEntity!,
                                  part: widget.nestedList[index].part!,
                                  index: widget.nestedList[index].index!,
                                  mediaQueryPadding: mediaQueryPadding,
                                )
                            ));
                      });
                    }).whenComplete(() {});
              }
              else {
                BlocProvider.of<MyCoursesBloc>(context).add(
                    LaunchNewVideoEvent(
                      courseCover: widget.courseCover,
                      lectureId: widget.nestedList[index].lectureId!,
                      myCourseEntity: widget.nestedList[index].myCourseEntity!,
                      part: widget.nestedList[index].part!,
                      index: widget.nestedList[index].index!,
                      mediaQueryPadding: mediaQueryPadding,
                    )
                );
              }
            }
          },
          child: Container(
            color: (currentIndex==widget.nestedList[index].lectureId)?Theme.of(context).primaryColor.withOpacity(0.2):  Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
            child: Column(
              children: [
               
                const SizedBox(height: 14),
                
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.nestedList[index].header,
                          widget.nestedList[index].body,
                        ],
                      ),

                      (widget.nestedList[index].myCourseEntity!.courseContents[widget.nestedList[index].part!].contents[widget.nestedList[index].index!].isDone)?
                      Container(
                        width: 65,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: percentIndicatorColor , borderRadius: BorderRadius.circular(12)),
                        child: Text("مكتمل",style: blackBoldTextStyle(fontSize: 11, context: context),),
                      ): Row(children: [
                        Directionality(
                          textDirection:
                          TextDirection.ltr,
                          child: Text(
                            formatedTime(time: widget.nestedList[index].time!.toInt()),
                            style: blackBoldTextStyle(
                                context: context, fontSize: 11),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 17,
                          height: 17,
                          child: SvgPicture.asset(
                            "assets/svgs/clock.svg",
                          ),
                        ),
                      ],)
                    ],
                  ),
                ),

                const SizedBox(height: 14),
                
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Theme.of(context).canvasColor.withOpacity(0.5),
                ),

              ],
            ),
          ),
        );
      }),
    );

  }
}
