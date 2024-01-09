import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../core/util/assets_manager.dart';
import '../../../../../../domain/entities/card_by_id_entity.dart' ;
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/course_unit_body.dart';
import 'classes/course_unit_item.dart';

class CoursePlanTab extends StatefulWidget {
  const CoursePlanTab({super.key, required this.cardByIdEntity});
 final CardByIdEntity cardByIdEntity;
  @override
  State<CoursePlanTab> createState() => _CourseContentState();
}

class _CourseContentState extends State<CoursePlanTab> {
  List<CourseUnitItem> items = [];
  bool firstTime=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    if(firstTime) {
      items = [];
      firstTime=false;
      for (var unit in widget.cardByIdEntity.courseUnits) {
        items.add(CourseUnitItem(header: Padding(
            padding: const EdgeInsets.only(top:10,left: 17,right: 17,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.unitName,
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
                            ImgAssets.lessons,
                        ),
                      ),
                      SizedBox(width: size.width*0.01),
                      Text(
                        "${ unit.materials.length} ${locale.tutorials}",
                        style: blackBoldTextStyle(context: context,fontSize: 11),
                      ),
                      SizedBox(width: size.width*0.024),
                      SizedBox(
                        width: 17,
                        height: 17,
                        child: SvgPicture.asset(
                            ImgAssets.clock,
                        ),
                      ),
                      SizedBox(width: size.width*0.01),

                    ],
                  ),
                ),
              ],
            ),
          ), body: CourseUnitBody(materials: unit.materials),
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


