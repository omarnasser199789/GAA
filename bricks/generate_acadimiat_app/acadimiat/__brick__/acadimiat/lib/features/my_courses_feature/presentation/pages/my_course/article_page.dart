import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/core/widgets/empty_state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/my_course_model.dart';
import '../../../domain/use_cases/wiki/article_details_usecase.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';
import '../../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;
  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool allowAddIt=false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Jiffy.locale("ar");
   
    return  BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {
      if (kDebugMode) {
        print("State:$state");
      }
      if(state is SuccessArticleDetailsState){
        if(allowAddIt){
          allowAddIt=false;

        widget.article.details.add(

            Detail(
            detailId: state.articleDetailsEntity.articleId,
                header: state.articleDetailsEntity.header, addedBy: state.articleDetailsEntity.userId.toString(),
                date: state.articleDetailsEntity.date, body: state.articleDetailsEntity.body
            ));
          }
      }

      return Scaffold(
          appBar: appBarWidget("الموسوعة الحرة", context, true, null, null),
          floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () async {
                TextEditingController titleController =
                TextEditingController();
                TextEditingController definitionController =
                TextEditingController();
                TextEditingController keywordsController =
                TextEditingController();
                bool definitionEmpty=false;
                bool titleEmpty=false;
                final result = await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: StatefulBuilder(builder:
                            (BuildContext context, StateSetter mystate) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(left: 17, right: 17),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 3,
                                        color: Theme.of(context).canvasColor,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text("إضافة مقال جديد",
                                          style: blackBoldTextStyle(
                                              context: context,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                                CustomTextField(
                                  title: "عنوان المقال",
                                  hint:"أدخل عنوان المقال ",
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  titleColor: titleEmpty?Colors.red:null,
                                  onTap: () {},
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: CustomTextField(
                                    title: "نص المقال",
                                    hint: "أدخل نص المقال ",
                                    controller: definitionController,
                                    keyboardType: TextInputType.text,
                                    titleColor:definitionEmpty? Colors.red:null,
                                    maxLength: 250,
                                    maxLines: 5,
                                    onTap: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 25, left: 35, right: 35),
                                  child: SafeArea(
                                      child: CustomButton(
                                          title:"إضافة مقال",
                                          onTap: () {

                                            if(titleController.text != ""&&definitionController.text != "") {
                                              Navigator.pop(context, 200);
                                            }else  if (titleController.text == "") {
                                              mystate(() {
                                                titleEmpty=true;
                                              });
                                            }else{
                                              mystate(() {
                                                titleEmpty=false;
                                              });
                                            }
                                            if (definitionController.text == "") {
                                              mystate(() {
                                                definitionEmpty=true;
                                              });
                                            }else{
                                              mystate(() {
                                                definitionEmpty=false;
                                              });
                                            }
                                          })),
                                )
                              ],
                            ),
                          );
                        }),
                      );//
                    }).whenComplete(() {

                });

                if (result == 200) {
                  allowAddIt=true;

                  BlocProvider.of<MyCoursesBloc>(context).add(ArticleDetailsEvent(params:
                  ArticleDetailsParams(
                      articleId: widget.article.articleId,
                      userId: userId(),
                      body: definitionController.text, header:titleController.text, date: DateTime.now(),
                      isPublished: true)));

                }

              },
              backgroundColor: kMainColor,
              child: SvgPicture.asset(
                "assets/svgs/add.svg",
                color: Colors.white,
              ),
            ),
          ),
          //widget.article.articleName
          body:Padding(
            padding: const EdgeInsets.only(left: 17,right: 17),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all( 14),
                        child: Text(widget.article.articleName,style: blackBoldTextStyle(context: context, fontSize: 13,height: lineSpace),),
                      )),

                  if(widget.article.details.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Column(
                      children:List<Widget>.generate(widget.article.details.length, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.3, color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Text(
                                    widget.article.details[index].header,
                                    // glossary.concepts[index].concept,
                                    style: blackBoldTextStyle(context: context, fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 11),
                                  child: Text(
                                    parseHtmlString(widget.article.details[index].body),
                                    style: blackBoldTextStyle(
                                        fontSize: 12,
                                        height: 2,
                                        context: context,
                                        // color: Theme.of(context).accentColor
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: Container(
                                    width: double.infinity,
                                    height: 0.3,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color:Theme.of(context).canvasColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(200)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: SvgPicture.asset(
                                                "assets/svgs/profileIcon.svg",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            widget.article.details[index].addedBy,
                                            style: blackBoldTextStyle(
                                                context: context, fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        Jiffy(widget.article.details[index].date).yMMMdjm,
                                        style: blackBoldTextStyle(context: context, fontSize: 11),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )) ,
                    ),
                  ),


                  if(widget.article.details.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top:100),
                      child: EmptyStateWidget(svg: "assets/svgs/articles.svg", text1: "لا توجد مقالات!",text3: "قم باضافة اول مقال",),
                    )


                ],
              ),
            ),
          )







      );
        }));

  }
}
