import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../core/functions.dart';
import '../../../../../../../../../core/util/assets_manager.dart';
import '../../../../../../../data/models/card_by_id_model.dart'as m;
import 'package:flutter_svg/flutter_svg.dart';

/// A widget representing the body of a course unit
class CourseUnitBody extends StatefulWidget {
  const CourseUnitBody({
    Key? key,
    required this.materials,
  }) : super(key: key);

  final List<m.Material> materials;

  @override
  State<CourseUnitBody> createState() => _CourseUnitBodyState();
}

/// The state for the CourseUnitBody widget
class _CourseUnitBodyState extends State<CourseUnitBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (62 * widget.materials.length)/1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.materials.length,
        itemBuilder: (context, index) {
          /// Retrieve the material at the current index
          final material = widget.materials[index];
          /// Check if the material has contents
          final hasMaterialContents = material.materialContents.isNotEmpty;

          return Column(
            children: [
              const SizedBox(height: 14),
              /// Display the material information in a row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Display the lesson number and material name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${lessonsNumber(index)}:  ",
                          style: blackBoldTextStyle(
                            context: context,
                            fontSize: 11,
                            color: hintTextColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            material.materialName,
                            style: blackBoldTextStyle(
                              fontSize: 11,
                              context: context,
                            ),
                          ),
                        ),
                      ],
                    ),
                    /// If the material has contents, display the content length and clock icon
                    if (hasMaterialContents)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                formatedTime(
                                  time: material.materialContents[0].contentLength.toInt(),
                                ),
                                style: blackBoldTextStyle(
                                  context: context,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 17,
                              height: 17,
                              child: SvgPicture.asset(
                                ImgAssets.clock,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              /// Divider line between each material
              Container(
                width: double.infinity,
                height: 0.3,
                color: Theme.of(context).canvasColor.withOpacity(0.5),
              ),
            ],
          );
        },
      ),
    );
  }
}
