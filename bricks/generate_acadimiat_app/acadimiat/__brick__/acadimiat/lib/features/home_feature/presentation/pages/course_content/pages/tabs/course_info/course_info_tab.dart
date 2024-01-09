import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../Theme/style.dart';
import '../../../../../../../../core/globals.dart';
import '../../../../../../../../core/util/assets_manager.dart';
import '../../../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../../domain/entities/card_by_id_entity.dart';
import 'widgets/info_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class CourseInfoTab extends StatefulWidget {
  const CourseInfoTab({Key? key, required this.cardByIdEntity}) : super(key: key);
  final CardByIdEntity cardByIdEntity;

  @override
  State<CourseInfoTab> createState() => _CourseInfoTabState();
}

class _CourseInfoTabState extends State<CourseInfoTab> {
  List<Widget> widgetList =[];

  @override
  void initState() {
    super.initState();
  }

  // Method to build the list of widgets
  List<Widget> _buildWidgetList() {
    var locale = AppLocalizations.of(context)!;
    var videosLength = widget.cardByIdEntity.videosLength;
    var time = _printDuration(Duration(seconds: videosLength)); // Calculate time duration

    return [
      // Building InfoBox widgets
      _buildInfoBox(ImgAssets.lessons1, '${widget.cardByIdEntity.numberOfUnites} ${locale.parts}', 'عدد الأجزاء'),
      _buildInfoBox(ImgAssets.clock, time, locale.videoDuration!),
      _buildInfoBox(ImgAssets.lessons, '${widget.cardByIdEntity.numberOfLectures} ${locale.tutorials}', 'عدد المحاضرات'),
      _buildInfoBox(ImgAssets.subscribe, locale.annualSubscription!, 'مدة الاشتراك'),

      // Building CourseInfo widgets
      for (var item in widget.cardByIdEntity.courseInfo) _buildCourseInfo(item),

      // Building the certificate widget
      _buildCertificate(),

      const SizedBox(height: 160), // Adding a SizedBox for spacing
    ];
  }

  // Method to build individual InfoBox widgets
  Widget _buildInfoBox(String svg, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InfoBox(svg: svg, title: title, body: body),
    );
  }

  // Method to build individual CourseInfo widgets
  Widget _buildCourseInfo(dynamic item) {
    return Column(
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
            // Building HtmlWidget for course info
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
    );
  }

  // Method to build the certificate widget
  Widget _buildCertificate() {
    var size = MediaQuery.of(context).size;
    return Padding(
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
    );
  }

  // Method to print duration in HH:MM:SS format
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    widgetList =[];
    widgetList = _buildWidgetList(); // Initialize the widget list
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList, // Using the widgetList to build the UI
      ),
    );
  }
}
