import 'package:flutter/material.dart';
import '../../../../Theme/style.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import 'package:shimmer/shimmer.dart';
class LoadingCoursesWidget extends StatelessWidget {
  const LoadingCoursesWidget(
      {super.key, required this.title,});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(top: 20, left: 18, right: 18, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: blackBoldTextStyle(context: context, fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          width: double.infinity,
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).cardColor,
                  highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 280,
                              height: 130,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  CachedNetWorkImage(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                    boxFit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 7, right: 7),
                              child: Text(
                                "************",
                                maxLines: 2,
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 7, right: 7),
                              child: Text(
                                "*************",
                                style: blackRegularTextStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}