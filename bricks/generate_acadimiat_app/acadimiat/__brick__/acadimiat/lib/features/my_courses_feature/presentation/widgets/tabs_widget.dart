import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/classes/constants.dart';
import '../../domain/entities/my_lecture_entity.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key,required this.myLectureEntity});
  final MyLectureEntity myLectureEntity;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return  Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: TabBar(
        isScrollable: false,
        labelColor: Theme.of(context).primaryColor,
        dividerColor:Theme.of(context).cardColor,
        unselectedLabelColor: iconsColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: EdgeInsets.only(left: size.width * 0.048, right: size.width * 0.048),
        labelStyle: blackBoldTextStyle(context: context, fontSize: 11),
        indicator: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Theme.of(context).primaryColor.withOpacity(0.1)),
        tabs: [

          ///Lesson content tab always appears
          const Tab(
            height: 30,
            child: Align(
              alignment: Alignment.center,
              child: Text("محتوى الدرس"),
            ),
          ),

          ///Comments are only seen if the lecture content contains a video
          ///knowing that the content of the lecture is rearranged so that the video is the first
          ///item in the list  _____myLectureEntity.contents[0]_____
          if (myLectureEntity.contents[0].type == Constants.VIDEO)
            const Tab(
              height: 30,
              child: Align(
                alignment: Alignment.center,
                child: Text("التعليقات"),
              ),
            ),

          ///The notes tab appears only if the course contains a video
          if (myLectureEntity.contents[0].type == Constants.VIDEO)
            Tab(
              height: 30,
              child: Align(
                alignment: Alignment.center,
                child: Text(locale.notes!),
              ),
            ),

        ],
      ),
    );
  }
}
