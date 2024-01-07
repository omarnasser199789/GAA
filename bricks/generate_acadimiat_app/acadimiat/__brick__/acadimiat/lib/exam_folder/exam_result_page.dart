import 'package:acadmiat/exam_folder/widgets/box_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Theme/style.dart';
import '../core/widgets/app_bar_widget.dart';
import '../features/my_courses_feature/data/models/my_lecture_model.dart';
import 'exam_info_page.dart';
import 'package:jiffy/jiffy.dart';

class ExamResultPage extends StatefulWidget {
  const ExamResultPage({Key? key, required this.nestedContent})
      : super(key: key);

  final NestedContent nestedContent;
  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");
    String date = Jiffy( widget.nestedContent.activity.quizz!.attendanceTable[0].attendedAt).yMMMMd;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBarWidget(widget.nestedContent.activity.quizz!.name, context,
          true, null, Theme.of(context).cardColor),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 19, left: 19, right: 19),
                      child: Text(
                        "معلومات عامة عن الاختبار",
                        style:
                            blackBoldTextStyle(context: context, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19, right: 19, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 13, left: 19, right: 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "الوقت المسموح لتقديم الاختبار",
                                style: blackBoldTextStyle(context: context, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BoxInfo(
                                size: size,
                                svg: "assets/svgs/Group 130313333333.svg",
                                text: "عدد أسئلة الاختبار ",
                                title:
                                    "${widget.nestedContent.activity.quizz!.questions.length}",
                              ),
                              BoxInfo(
                                size: size,
                                svg: "assets/svgs/Group 130312222222.svg",
                                text: "عدد المحاولات المسموحة",
                                title: "${1}",
                              ),
                              BoxInfo(
                                size: size,
                                svg: "assets/svgs/Group 13031.svg",
                                text: "عدد محاولات التقديم",
                                title: "${1}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 19, left: 19, right: 19),
                          child: Text(
                            "سجل المحاولات السابقة",
                            style: blackBoldTextStyle(
                                context: context, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 19, right: 19, top: 20),
                      child: Container(
                          // height: 343,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 19),
                            child: SizedBox(
                              height: 85 * 1 / 1,
                              child: SizedBox(
                                height: 85,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text("المحاولة ${1}",
                                                  style: blackBoldTextStyle(fontSize: 13, context: context),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .only(
                                                    top: 4,
                                                    bottom:
                                                    10),
                                                child: Text(
                                                  date,
                                                  style: blackBoldTextStyle(fontSize: 11, context: context),
                                                ),
                                              ),
                                              (widget.nestedContent.activity.quizz!.attendanceTable[0].didPass)
                                                  ? Row(
                                                children: [
                                                  SvgPicture.asset("assets/svgs/Icon feather-check-circle.svg",
                                                    color: percentIndicatorColor,
                                                  ),
                                                  SizedBox(width: 7),
                                                  Text(
                                                    "لقد اجتزت الاختبار",
                                                    style:
                                                    blackBoldTextStyle(fontSize: 13, context: context,color: percentIndicatorColor),
                                                  ),
                                                ],
                                              )
                                                  : Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/svgs/warning-2.svg",
                                                      color: Colors.red),
                                                  SizedBox(
                                                    width:
                                                    7,
                                                  ),
                                                  Text(
                                                    "لم تقم باجتياز الاختبار",
                                                    style: blackBoldTextStyle(
                                                        fontSize: 13,
                                                        context: context,
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).scaffoldBackgroundColor,
                                                borderRadius: BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/svgs/group 3020.svg",
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        widget.nestedContent.activity.quizz!.attendanceTable[0].totalDegree.toInt().toString(),
                                                        style: blackBoldTextStyle(fontSize: 15, context: context),
                                                      ),
                                                      Text("الدرجة المستحقة",
                                                        style: blackBoldTextStyle(fontSize: 9, context: context),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
