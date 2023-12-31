import 'package:acadmiat/core/globals.dart';
import '../../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../activety_by_id_page.dart';
import '../../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';

class AssignmentsTab extends StatefulWidget {
  const AssignmentsTab({Key? key,required this.assignments,required this.courseId}) : super(key: key);
 final  List<Assignment> assignments;
 final int courseId;
  @override
  State<AssignmentsTab> createState() => _AssignmentsTabState();
}

class _AssignmentsTabState extends State<AssignmentsTab> {


  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
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


                // if(index%2!=0){   var rng = Random();
                // if(rng.nextInt(100)%2==0){
                //   goTo(context, (context) => CloseCaseStudyPage(index: index,));
                // }else{
                //   goTo(context, (context) => OpenCaseStudyPage(index: index,));
                // }
                //
                // }
                //
                // if(index%2==0){
                //
                //   goTo(context, (context) => ActivityByPageId(assignmentId: widget.assignments[index].id,courseId: widget.courseId,));
                // }
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
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.1),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(
                  //         0, 3), // changes position of shadow
                  //   ),
                  // ],
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
                                  "assets/svgs/vuesax-linear-calendar.svg",
                                  color: iconsColor,
                                ),

                                const SizedBox(width: 5,),
                                Text(
                                    // DateFormat("yyyy/MM/dd").format(widget.assignments[index].fromDate)
                                    Jiffy(widget.assignments[index].fromDate).MMMd
                                    ,
                                  style: blackBoldTextStyle(fontSize: 11,context: context,color:iconsColor, ),),
                                SizedBox(width: 5,),
                                Text("-",
                                  style: blackBoldTextStyle(fontSize: 11,context: context),),
                                SizedBox(width: 5,),
                                Text(
                                  // DateFormat("yyyy/MM/dd").format(widget.assignments[index].toDate)
                                  // Jiffy(widget.assignments[index].toDate).yMMMMd
                                  Jiffy(widget.assignments[index].toDate).yMMMd
                                  ,
                                  style: blackBoldTextStyle(fontSize: 11,context: context,color:iconsColor),),


                              ],
                            ),
                            if(widget.assignments[index].isDone!=null)
                              (widget.assignments[index].isDone!)?
                              Row(
                                children: [

                                  SvgPicture.asset(
                                    "assets/svgs/Icon feather-check-circle.svg",
                                    color: percentIndicatorColor,
                                  ),

                                  SizedBox(width: 5,),

                                  Text("تم ارسال الحل",style: blackBoldTextStyle(context: context,fontSize: 12,color: percentIndicatorColor),),
                                ],
                              ): Row(
                                children: [

                                  SvgPicture.asset(
                                    "assets/svgs/warning-2.svg",
                                    color: Colors.red,
                                  ),

                                  SizedBox(width: 5,),

                                  Text("الحل ناقص ",style: blackBoldTextStyle(context: context,fontSize: 12,color:Colors.red),),
                                ],
                              ),

                          ],
                        ),
                      ),

                      // if(index%2==0)
                      //   Hero(
                      //       tag: "PaymentPageBTN$index",
                      //     child: Material(
                      //         color:Theme.of(context).cardColor,
                      //         child: TitleContainer(title: locale.activity!,color: activeColor,))),
                      // if(index%2!=0)
                      //   Hero(
                      //       tag: "PaymentPageBTN$index",child:
                      //   Material(
                      //       color: Theme.of(context).cardColor,
                      //       child: TitleContainer(title:locale.caseStudy!,color: kMainColor,))),




                      //
                      // if(widget.assignments[index].notes!="")
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 14),
                      //       child: Text("ملاحظة:",style: blackBoldTextStyle(context: context,fontSize: 13,height: 1.5),),
                      //     ),
                      //     Text(
                      //       parseHtmlString(
                      //       widget.assignments[index].notes),style: blackBoldTextStyle(context: context,fontSize: 13,height: 1.5),),
                      //   ],
                      // ),

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


