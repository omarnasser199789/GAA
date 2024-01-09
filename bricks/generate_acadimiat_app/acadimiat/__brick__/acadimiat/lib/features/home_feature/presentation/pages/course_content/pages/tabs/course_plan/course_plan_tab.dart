import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../core/util/assets_manager.dart';
import '../../../../../../data/models/card_by_id_model.dart';
import '../../../../../../domain/entities/card_by_id_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/course_unit_body.dart';
import 'classes/course_unit_item.dart';

class CoursePlanTab extends StatefulWidget {
  const CoursePlanTab({
    Key? key,
    required this.cardByIdEntity,
  }) : super(key: key);

  final CardByIdEntity cardByIdEntity;

  @override
  State<CoursePlanTab> createState() => _CoursePlanTabState();
}

class _CoursePlanTabState extends State<CoursePlanTab> {
  late List<CourseUnitItem> items;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    items = [];
  }

  @override
  Widget build(BuildContext context) {
    /// Check if items have been initialized, and initialize them if not
    if (!initialized) {
      initializeItems();
      initialized = true; // Mark as initialized
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: ExpansionPanelList(
        elevation: 0,
        dividerColor: Theme.of(context).canvasColor.withOpacity(0.1),
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (index, isExpanded) {
          setState(() {
            items[index].isExpanded = !items[index].isExpanded;
          });
        },
        animationDuration: const Duration(milliseconds: 600),
        children: items.map<ExpansionPanel>((item) {
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (_, isExpanded) => item.header,
            body: item.body,
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }

  /// Method to initialize items list with course unit items
  void initializeItems() {
    items = widget.cardByIdEntity.courseUnits.map((unit) {
      return CourseUnitItem(
        header: buildHeader(unit), // Build the header for each item
        body: CourseUnitBody(materials: unit.materials),
        isExpanded: true,
      );
    }).toList();
  }

  /// Method to build the header for each course unit item
  Widget buildHeader(CourseUnit unit) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            unit.unitName,
            style: blackBoldTextStyle(fontSize: 13, context: context),
          ),
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
                SizedBox(width: size.width * 0.01),
                Text(
                  "${unit.materials.length} ${locale.tutorials}",
                  style: blackBoldTextStyle(context: context, fontSize: 11),
                ),
                SizedBox(width: size.width * 0.024),
                SizedBox(
                  width: 17,
                  height: 17,
                  child: SvgPicture.asset(
                    ImgAssets.clock,
                  ),
                ),
                SizedBox(width: size.width * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
