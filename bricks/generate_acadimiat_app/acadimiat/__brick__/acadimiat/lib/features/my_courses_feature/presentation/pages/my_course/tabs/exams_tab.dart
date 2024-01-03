import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../../exam_folder/exam_info_page.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../data/models/my_course_model.dart';

class ExamsTab extends StatefulWidget {
  const ExamsTab({super.key,required this.quizz});
final  List<Quizz> quizz;
  @override
  State<ExamsTab> createState() => _ExamsTabState();
}

class _ExamsTabState extends State<ExamsTab> {
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: defaultPadding,
      child: ListView.builder(
          itemCount: widget.quizz.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if(widget.quizz[index].quizzName!="No Quizz") {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: (){
                    goTo(context, (context) => ExamInfoPage(quizzId: widget.quizz[index].quizzId));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme
                          .of(context)
                          .cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor.withOpacity(0.1), //Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 12, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.quizz[index].quizzName,
                                style: blackBoldTextStyle(context: context, fontSize: 13),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top:15),
                                child: Text(
                                  "عدد مرات المحاولة المسموحة :  ${widget.quizz[index].attempts}", style: blackBoldTextStyle(context: context, fontSize: 11),
                                ),
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            ImgAssets.question,
                            width: 35,
                            color:iconsColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }else{
              return Container();
            }
          }),
    );
  }
}
