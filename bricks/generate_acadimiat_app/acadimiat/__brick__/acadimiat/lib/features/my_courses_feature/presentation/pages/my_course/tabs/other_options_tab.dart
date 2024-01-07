import 'package:flutter/material.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../domain/entities/my_course_entity.dart';
import 'ads_tab.dart';
import 'lessons_tab/case_stady_folder/case_stady_tab.dart';
import 'certificates_tab.dart';
import 'discussions_tab.dart';
import 'glossary/glossary_tab.dart';
import 'wiki_tab.dart';

class OtherOptionsTab extends StatefulWidget {
  const OtherOptionsTab({super.key,
    required this.myCourseEntity,
    required this.offset});
  final MyCourseEntity myCourseEntity;
 final  double ? offset;
  @override
  State<OtherOptionsTab> createState() => _OtherOptionsTabState();
}

class _OtherOptionsTabState extends State<OtherOptionsTab> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    int length=6;
    if(widget.myCourseEntity.forum.forumName==""){
      length--;
    }
    if(widget.myCourseEntity.wiki.articles.isEmpty){
      length--;
    }

    return DefaultTabController(
      length: length,

      child:Flex(
        direction: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.04),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: TabBar(
                isScrollable: true,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: iconsColor,
                padding:const EdgeInsets.only(left: 10,right: 10) ,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle:  blackBoldTextStyle(context: context,fontSize: 11,),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Theme.of(context).primaryColor.withOpacity(0.1)),
                tabs:  [
                  if(widget.myCourseEntity.forum.forumName!="")
                  const Tab(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text("منتدى النقاشات",),
                    ),
                  ),

                  Tab(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text(locale.terminology!,),
                    ),
                  ),

                  const Tab(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text("الحالات الدراسية",),
                    ),
                  ),
                  if(widget.myCourseEntity.wiki.articles.isNotEmpty)
                  Tab(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text(locale.freeEncyclopedia!),
                    ),
                  ),

                  Tab(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child:Text(locale.ads!,),
                    ),
                  ),

                  Tab(
                    height: 30,

                    child: Align(
                      alignment: Alignment.center,
                      child:Text(locale.certificates!,),
                    ),
                  ),

                ],

              ),
            ),
          ),
            Flexible(
            child: TabBarView(children: [
              if(widget.myCourseEntity.forum.forumName!="")
              DiscussionsTab(forum: widget.myCourseEntity.forum,),

              GlossaryTab(glossary: widget.myCourseEntity.glossary,),
              CaseStudyTab(caseStudy: widget.myCourseEntity.caseStudy, courseId: widget.myCourseEntity.id,),
              if(widget.myCourseEntity.wiki.articles.isNotEmpty)
              SingleChildScrollView(child: WikiTab(wiki:widget.myCourseEntity.wiki)),
              const AdsTab(),
              const CertificatesTab(),
            ],),
          ) ,
        ],
      ),
    );
  }
}
