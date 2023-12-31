import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../domain/entities/card_by_id_entity.dart' ;
import 'package:flutter_svg/flutter_svg.dart';
import 'body.dart';
import 'item.dart';

class CourseContentWidget extends StatefulWidget {
  const CourseContentWidget({Key? key, required this.cardByIdEntity}) : super(key: key);
 final CardByIdEntity cardByIdEntity;
  @override
  State<CourseContentWidget> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContentWidget> {
  List<Item> items = [];
  bool firstTime=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    if(firstTime) {
      items = [];
      firstTime=false;
      for (var item in widget.cardByIdEntity.courseUnits) {
        items.add(
          Item(header: Padding(
            padding: const EdgeInsets.only(top:10,left: 17,right: 17,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.unitName,
                  style: blackBoldTextStyle(fontSize: 13, context: context),),
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Row(
                    children: [

                      Container(
                        alignment: Alignment.center,
                        width: 17,
                        height: 17,
                        child: SvgPicture.asset(
                          "assets/svgs/lessons.svg",
                        ),
                      ),
                      SizedBox(width: size.width*0.01),
                      Text(
                        "${ item.materials.length} ${locale.tutorials}",
                        style: blackBoldTextStyle(context: context,fontSize: 11),
                      ),
                      SizedBox(width: size.width*0.024),
                      SizedBox(
                        width: 17,
                        height: 17,
                        child: SvgPicture.asset(
                          "assets/svgs/clock.svg",
                        ),
                      ),
                      SizedBox(width: size.width*0.01),

                    ],
                  ),
                ),
              ],
            ),
          ),
            body: Body(materials: item.materials),
            isExpanded: true,),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: ExpansionPanelList(
        elevation: 0,
        dividerColor:Theme.of(context).canvasColor.withOpacity(0.1),
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (index, isExpanded) {
          setState(() {
            items[index].isExpanded = !items[index].isExpanded;
            setState(() {});
          });
        },
        animationDuration: const Duration(milliseconds: 600),
        children: items.map(
              (item) => ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (_, isExpanded) => item.header,
                body: item.body,
                isExpanded: item.isExpanded,
          ),
        ).toList(),
      ),
    );
  }
}


