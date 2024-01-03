import 'package:acadmiat/core/globals.dart';
import '../../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../activety_by_id_page.dart';
import '../../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';

class AssignmentsTab extends StatefulWidget {
  const AssignmentsTab({super.key,required this.assignments,required this.courseId});
 final  List<Assignment> assignments;
 final int courseId;
  @override
  State<AssignmentsTab> createState() => _AssignmentsTabState();
}

class _AssignmentsTabState extends State<AssignmentsTab> {

  @override
  Widget build(BuildContext context) {
    Jiffy.locale("ar");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: defaultPadding,
        child: ListView.builder(itemCount: widget.assignments.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: (){
                goTo(context, (context) => ActivityByPageId(
                  key: activityByPageIdKey,
                  fromDate: widget.assignments[index].fromDate,
                  toDate: widget.assignments[index].toDate,
                  assignmentId: widget.assignments[index].id,courseId: widget.courseId,));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 12,bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.assignments[index].assignemnet,style: blackBoldTextStyle(context: context,fontSize: 13,height: 1.5),),
                      Padding(
                        padding: const EdgeInsets.only(top:20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ImgAssets.vuesaxLinearCalendar,
                                  color: iconsColor,
                                ),

                                const SizedBox(width: 5,),
                                Text(
                                  Jiffy(widget.assignments[index].fromDate).MMMd,
                                  style: blackBoldTextStyle(fontSize: 11,context: context,color:iconsColor, ),),
                                const SizedBox(width: 5,),
                                Text("-",
                                  style: blackBoldTextStyle(fontSize: 11,context: context),),
                                const SizedBox(width: 5,),
                                Text(
                                  Jiffy(widget.assignments[index].toDate).yMMMd,
                                  style: blackBoldTextStyle(fontSize: 11,context: context,color:iconsColor),),
                              ],
                            ),
                            if(widget.assignments[index].isDone!=null)
                              (widget.assignments[index].isDone!)?
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImgAssets.iconFeatherCheckCircle,
                                    color: percentIndicatorColor,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text("تم ارسال الحل",style: blackBoldTextStyle(context: context,fontSize: 12,color: percentIndicatorColor),),
                                ],
                              ): Row(children: [
                                  SvgPicture.asset(
                                    ImgAssets.warning2,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text("الحل ناقص ",style: blackBoldTextStyle(context: context,fontSize: 12,color:Colors.red),),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


