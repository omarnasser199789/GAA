import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../Theme/style.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../../../core/functions.dart';
import '../../../../../../../core/util/assets_manager.dart';
import '../../../../../data/models/my_course_model.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.concept,});
  final Concept concept;
  @override
  Widget build(BuildContext context) {
    // return Text(title);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.3, color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(
                  concept.concept,
                  style: blackBoldTextStyle(context: context, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Text(
                  parseHtmlString(concept.definition),
                  style: blackBoldTextStyle(
                    fontSize: 12,
                    height: 2,
                    context: context,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color:Theme.of(context).canvasColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(200)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(ImgAssets.profileIcon),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          concept.addedBy,
                          style: blackBoldTextStyle(context: context, fontSize: 11),
                        ),
                      ],
                    ),
                    Text(
                      Jiffy(concept.date).yMMMdjm,
                      style: blackBoldTextStyle(context: context, fontSize: 11,color: iconsColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}