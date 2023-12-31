import 'package:acadmiat/core/globals.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/widgets/back_button.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {Key? key,
        required this.heroTag,
        required this.imageUrl,
        required this.progress})
      : super(key: key);
  final String heroTag;
  final String imageUrl;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Hero(
                tag: heroTag,
                child:Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetWorkImage(borderRadius:BorderRadius.zero,url:imageUrl, boxFit: BoxFit.fill),
                    CachedNetWorkImage(borderRadius:BorderRadius.zero,url:imageUrl),
                  ],
                )
            ),
            Padding(
              padding: defaultPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                      duration: const Duration(milliseconds: 1500),
                      child: BackButtonWidget()),
                  FadeAnimation(
                    duration: const Duration(milliseconds: 1500),
                    child: Padding(padding: const EdgeInsets.only(bottom: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(200)),
                            child: CircularPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              radius: 30.0,
                              lineWidth: 7.0,
                              percent: progress / 100,
                              center: Text(
                                "$progress%",
                                style: blackBoldTextStyle(
                                    context: context,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              progressColor: percentIndicatorColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}