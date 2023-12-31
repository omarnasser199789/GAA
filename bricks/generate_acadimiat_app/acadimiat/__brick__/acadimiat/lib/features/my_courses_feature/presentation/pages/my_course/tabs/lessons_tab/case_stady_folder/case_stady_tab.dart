import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../data/models/my_course_model.dart';
import 'case_study_page.dart';

class CaseStudyTab extends StatefulWidget {
  const CaseStudyTab({Key? key,required this.caseStudy,required this.courseId}) : super(key: key);
  final List<CaseStudy> caseStudy;
  final int courseId;
  @override
  State<CaseStudyTab> createState() => _CaseStudyTabState();
}

class _CaseStudyTabState extends State<CaseStudyTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: ListView.builder(
            itemCount: widget.caseStudy.length,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(left:17,right: 17,top:10),
            child: GestureDetector(
              onTap: (){
             goTo(context, (context) => CaseStudyPage(caseStudy:widget.caseStudy[index], courseId: widget.courseId,));
              },
              child: Container(

                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                  child: Padding(
                padding: const EdgeInsets.only(top:10,bottom: 10,left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        if(widget.caseStudy[index].open==false)
                          Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromRGBO(18, 120, 237, 0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8,bottom: 8,left: 12,right: 12),
                              child: Text("حالة دراسية مغلقة",style: blackBoldTextStyle(fontSize: 11, context: context,color: Color.fromRGBO(18, 120, 237,1),
                              ),),
                            ),
                          ),
                        if(widget.caseStudy[index].open==true)
                          Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromRGBO(226, 155, 91, 0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8,bottom: 8,left: 12,right: 12),
                              child: Text("حالة دراسية مفتوحة",style: blackBoldTextStyle(fontSize: 11, context: context,color: Color.fromRGBO(226, 155, 91,1),
                              ),),
                            ),
                          ),

                        // if(widget.caseStudy[index].solution.answers.isNotEmpty)
                        // Padding(
                        //   padding: const EdgeInsets.only(top:10),
                        //   child: Row(
                        //     children: [
                        //       SvgPicture
                        //           .asset(
                        //         "assets/svgs/Icon feather-check-circle.svg",
                        //         color: percentIndicatorColor,
                        //       ),
                        //       SizedBox(
                        //         width:
                        //         7,
                        //       ),
                        //       Text(
                        //         "تم ارسال الحل",
                        //         style:
                        //         blackBoldTextStyle(fontSize: 11, context: context,color: percentIndicatorColor),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Text(widget.caseStudy[index].header,style: blackBoldTextStyle(fontSize: 12, height: 1.7,context: context),),
                    ),


                  ],
                ),
              )),
            ),
          );
        }),
      ),
    );
  }
}
