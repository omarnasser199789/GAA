import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import '../../../domain/entities/card_by_id_entity.dart';
import 'widgets/info_box.dart';

class CourseOverviewPage extends StatefulWidget {
  const CourseOverviewPage({Key? key, required this.cardByIdEntity}) : super(key: key);
  final CardByIdEntity cardByIdEntity;

  @override
  State<CourseOverviewPage> createState() => _CourseOverviewPageState();
}

class _CourseOverviewPageState extends State<CourseOverviewPage> {
  List<Widget> widgetList = [];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    String printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    String time = printDuration(Duration(seconds: widget.cardByIdEntity.videosLength));

    widgetList = [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: InfoBox(
          svg: ImgAssets.lessons1,
          title: "${widget.cardByIdEntity.numberOfUnites} ${locale.parts}",
          body: "عدد الأجزاء",
        ),
      ),
      InfoBox(
        svg: ImgAssets.clock,
        svgWidth: 20,
        title: '${time.split(":")[0]} ${locale.hour}'' ${time.split(":")[1]} ${locale.minute} ''${time.split(":")[2]} و${locale.second}',
        body: locale.videoDuration!,
      ),
      InfoBox(
        svg: ImgAssets.lessons,
        title: "${widget.cardByIdEntity.numberOfLectures} ${locale.tutorials}",
        body: "عدد المحاضرات",
      ),
      InfoBox(
        svg: ImgAssets.subscribe,
        title: locale.annualSubscription!,
        body: "مدة الاشتراك",
      ),

      for (var item in widget.cardByIdEntity.courseInfo)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                item.header,
                style: blackBoldTextStyle(fontSize: 15, context: context, color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: HtmlWidget(
                "<div style='background-color:${Theme.of(context).scaffoldBackgroundColor} !important; line-height:${lineSpace} ;font-family:${"taleeq-bold"} !important; font-size:${0.8}em !important' color:${Theme.of(context).canvasColor} !important'>${item.body.replaceAll("background-color", "").replaceAll("color", "").replaceAll("font-family", "")..replaceAll("font-size", "")}</div >",
                customWidgetBuilder: (element) {
                  if (element.attributes['background-color'] == 'bar') {
                    return Container(
                      width: 20,
                      height: 30,
                      color: Colors.red,
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
        ),

      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "الشهادة",
                  style: blackBoldTextStyle(fontSize: 15, context: context, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                width: size.width - 34,
                height: 200,
                child: CachedNetWorkImage(
                  borderRadius: BorderRadius.circular(0),
                  url: dotenv.env['imageCertificateUrl'],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 160),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList,
      ),
    );
  }
}
