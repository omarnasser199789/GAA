import '../Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'exam_info_page.dart';


class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return        Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17,top: 45),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Container(
                height: 343,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12

                    )

                ),
                child: Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.only(top:90),
                      child: Text("10",style: blackBoldTextStyle(context: context,fontSize: 29),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("نتيجتك بالاختبار",style: blackBoldTextStyle(context: context,fontSize: 14),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 12,top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BoxInfo(size: size,svg:  "assets/svgs/Group 130312222222.svg",text:"عدد الأجوبة الصحيحة",title: "02",),
                          BoxInfo(size: size,svg:  "assets/svgs/Group 13031777.svg",text:"عدد الأجوبة الخاطئة",title: "04",),
                          BoxInfo(size: size,svg:  "assets/svgs/Group 13031.svg",text:"عدد محاولات التقديم",title: "01",),

                        ],
                      ),
                    )
                  ],
                ),

              ),
            ),
            SvgPicture.asset(
              "assets/svgs/answer.svg",
              width: 150,
            ),
          ],//
        ),
      ),
    );
  }
}



