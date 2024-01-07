import 'package:acadmiat/exam_folder/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:acadmiat/features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../Theme/style.dart';

class ExamPageHeader extends StatelessWidget {
  const ExamPageHeader({Key? key, required this.myQuizizzEntity,required this.percent,required this.percentText,required this.quizzName}) : super(key: key);
  final MyQuizizzEntity myQuizizzEntity;
  final double percent;
  final String percentText;
  final String quizzName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor.withOpacity(0.5),
      height: (myQuizizzEntity.timeLimit!=0) ? 145: 114,

      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(myQuizizzEntity.timeLimit!=0)
                  TimerWidget(
                    myQuizizzEntity: myQuizizzEntity,
                  ),
                  if(myQuizizzEntity.timeLimit==0)
                  SizedBox(
                      width: size.width * 0.8,
                      child: Text(
                        quizzName,
                        style: blackBoldTextStyle(context: context, fontSize: 14, height: 1.5),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200)),
                    child:  CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      radius: 25.0,
                      lineWidth: 7.0,
                      percent: percent,
                      center: Text( percentText,
                        style: blackBoldTextStyle(context: context, fontSize: 11, color: Theme.of(context).canvasColor),
                      ),
                      progressColor:percentIndicatorColor,
                    ),
                  )

                ],
              ),
            ),

            if(myQuizizzEntity.timeLimit!=0)
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: size.width * 0.8,
                      child: Text(quizzName, style: blackBoldTextStyle(context: context, fontSize: 14, height: 1.5),)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
