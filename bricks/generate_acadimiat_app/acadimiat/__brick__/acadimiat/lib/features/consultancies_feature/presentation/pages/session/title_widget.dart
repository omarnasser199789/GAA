import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../Theme/style.dart';
import '../../widgets/session_number.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.date,
    required this.numberOfSessions,
    required this.image,
    required this.consultancy,
    required this.consultant,
  });
  final DateTime date;
  final int numberOfSessions;
  final String image;
  final String consultancy;
  final String consultant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Jiffy(date).yMMMdjm,
                  style: blackBoldTextStyle(context: context, fontSize: 13),
                ),
                SessionNumber(
                  numberOfSessions: numberOfSessions,
                  type2: true,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CachedNetWorkImage(
                        borderRadius: BorderRadius.circular(10),
                        boxFit: BoxFit.fill,
                        url: image,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultancy,
                        style:
                        blackBoldTextStyle(context: context, fontSize: 13),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10),
                        child: Text(
                          consultant,
                          style:
                          blackBoldTextStyle(context: context, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}