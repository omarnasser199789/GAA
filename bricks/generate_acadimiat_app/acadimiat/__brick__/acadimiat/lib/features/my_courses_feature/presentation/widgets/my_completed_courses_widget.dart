import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:percent_indicator/percent_indicator.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../pages/my_course/course_page/course_page.dart';


class MyCompletedCoursesWidget extends StatefulWidget {
  const MyCompletedCoursesWidget({Key? key}) : super(key: key);

  @override
  State<MyCompletedCoursesWidget> createState() => _MyCompletedCoursesWidgetState();
}

class _MyCompletedCoursesWidgetState extends State<MyCompletedCoursesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top:26,left: 17,right: 17,bottom: 100),
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  CoursePage(
                          courseId: 0,userId: userId(), imageUrl: '',
                        )),
                  );
                },
                child:   Container(
                  width: double.infinity,
                  height: 302,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 105,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            const CachedNetWorkImage(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),),

                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 6),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        "assets/svgs/vuesax-linear-calendar.svg",
                                      ),
                                      const SizedBox(width: 5,),
                                      Text("30 ${locale.june!} ،2022",style: whiteBoldTextStyle(13))

                                    ],),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 11,right: 11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("الميديا والرسم والتصميم",
                                style: blackBoldTextStyle(context: context,fontSize: 12,color:  hintTextColor),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("أساسيات الرسم بالماركر (للمعماري والمصمم الداخلي)",
                                style: blackBoldTextStyle(context: context,fontSize: 14),),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [


                                      SizedBox(
                                        width: 18,
                                        child: SvgPicture.asset(
                                          width:18,
                                          "assets/svgs/clock.svg",
                                        ),
                                      ),
                                      const SizedBox(width: 3,),
                                      Text("40 ${locale.hour}",style: blackBoldTextStyle(context: context,fontSize: 10,color: hintTextColor),),
                                    ],
                                  ),



                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 18,
                                        child: SvgPicture.asset(
                                          "assets/svgs/videoIcon.svg",
                                          width: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 3,),
                                      Text("60 ${locale.meeting}",style: blackBoldTextStyle(context: context,fontSize: 10,color: hintTextColor),),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Container(
                                        width: 18,
                                        child: SvgPicture.asset(
                                          "assets/svgs/medal-star.svg",
                                          width: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 3,),
                                      Text("3/3 شهادة (3) مستويات ",style: blackBoldTextStyle(context: context,fontSize: 10,color: hintTextColor),),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                width: size.width - 56,
                                animation: true,
                                lineHeight: 8,
                                animationDuration: 1000,
                                barRadius: const Radius.circular(20),
                                percent: 0.3,
                                // center: Text("80.0%"),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: percentIndicatorColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${locale.courseCompletionRate!}  30%",style: blackBoldTextStyle(context: context,fontSize: 10),),
                                  Text("${locale.meeting} 15/19",style: blackBoldTextStyle(context: context,fontSize: 10),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),)
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "أ.محمد عبد الفتاح",
                                            style: blackBoldTextStyle(context: context,fontSize: 13),
                                          ),
                                          Text(
                                            locale.marketingCoach!,
                                            style: blackRegularTextStyle(fontSize: 13),
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svgs/Icon feather-check-circle.svg",
                                      ),
                                      const SizedBox(width: 10,),
                                      Text(locale.rated!,style: blackBoldTextStyle(context: context,fontSize: 12,color: percentIndicatorColor),)

                                    ],
                                  ),


                                ],
                              ),
                            ),



                          ],
                        ),
                      ),

                    ],
                  ),

                ),
              ),
            );
          }),
    );
  }
}
