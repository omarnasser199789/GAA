import '../../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../article_page.dart';

class WikiTab extends StatefulWidget {
  const WikiTab({super.key,required this.wiki});
  final  Wiki wiki;

  @override
  State<WikiTab> createState() => _WikiTabState();
}

class _WikiTabState extends State<WikiTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");
    List<Widget> widgetList=[];
    for(var item in widget.wiki.articles){

      widgetList.add(Padding(
        padding: const EdgeInsets.only(top:10),
        child: GestureDetector(
          onTap: (){
            goTo(context, (context) => ArticlePage(article: item));
          },
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: size.width-54,
                            child: Text(item.articleName,style: blackBoldTextStyle(fontSize: 12, context: context),)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                          Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color:Theme.of(context).canvasColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SvgPicture.asset(
                                      ImgAssets.profileIcon,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                item.addedBy,
                                style: blackBoldTextStyle(context: context, fontSize: 11),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                Jiffy(item.date).yMMMdjm,
                                style: blackBoldTextStyle(fontSize: 11, context: context, color: iconsColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 17,right: 17),
      child: Column(children: widgetList,),
    );
  }
}
