import 'package:acadmiat/core/widgets/empty_state_widget.dart';

import '../../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../unused_pages/add_new_card_page.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../unused_pages/discussion_by_id.dart';
import '../../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';

import '../replies_page.dart';

class DiscussionsTab extends StatefulWidget {
  const DiscussionsTab({Key? key, required this.forum}) : super(key: key);
  final Forum forum;
  @override
  State<DiscussionsTab> createState() => _DiscussionsTabState();
}

class _DiscussionsTabState extends State<DiscussionsTab> {
  List<Widget> widgetList = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    Jiffy.locale("ar");
    var locale = AppLocalizations.of(context)!;

    Size size = MediaQuery.of(context).size;

    widgetList.clear();

    widgetList.add(Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 17, right: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3000),
                color: iconsColor.withOpacity(0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 10, bottom: 10),
                child: SvgPicture.asset(
                  "assets/svgs/noun-discussion.svg",
                  color: iconsColor,
                  width: 23,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.forum.forumName,
                  style: blackBoldTextStyle(fontSize: 13, context: context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                      width: size.width - 90,
                      child: Text(
                        widget.forum.description,
                        style: blackBoldTextStyle(
                            fontSize: 10, height: 1.7, context: context),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    ));

    widgetList.add(
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 17, right: 17),
          child: Row(
      children: [
        Container(width: 8,height: 8,decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(200)
        ),),
          const SizedBox(width: 5,),
          Text("مواضيع النقاش (${widget.forum.topics.length})",style: blackBoldTextStyle(fontSize: 12, context: context),),
      ],
    ),
        ));
    for (var item in widget.forum.topics) {
      widgetList.add(GestureDetector(
        onTap: (){
          goTo(context, (context) => RepliesPage(topic: item,));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 17, right: 17),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      item.topic,
                      style: blackBoldTextStyle(
                          fontSize: 11, height: 1.7, context: context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Jiffy(item.date).yMMMdjm,
                            style: blackBoldTextStyle(
                              fontSize: 11,
                              context: context,
                              color: iconsColor
                            ),
                          ),
                          // Text(
                          //   Jiffy(item.date).yMMMdjm,
                          //   style: blackBoldTextStyle(context: context, fontSize: 11,color: iconsColor),
                          // ),
                          Container(
                            // decoration: BoxDecoration(
                            //   border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                            //   borderRadius: BorderRadius.circular(8)
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 7),
                              child: Row(
                                children: [
                                  Text(

                                    "اضافة رد",
                                    style: blackBoldTextStyle(
                                        fontSize: 12, context: context),
                                  ),

                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svgs/comment  icon.svg",
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ));
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

      body: (widget.forum.topics.isNotEmpty)?SingleChildScrollView(
        child: Column(
          children: widgetList,
        ),
      ):const EmptyStateWidget(svg: "assets/svgs/discussion2.svg", text1: "لاتوجد مواضيع للنقاش"),
    );
  }
}
