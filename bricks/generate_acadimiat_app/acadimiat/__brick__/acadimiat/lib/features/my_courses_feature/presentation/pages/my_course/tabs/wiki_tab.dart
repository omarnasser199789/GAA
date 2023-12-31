import '../../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../unused_pages/add_new_card_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../../item.dart';
import '../../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../article_page.dart';
class WikiTab extends StatefulWidget {
  const WikiTab({Key? key,required this.wiki}) : super(key: key);


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
                                    "assets/svgs/profileIcon.svg",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                item.addedBy,
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 11),
                              ),
                            ],
                          ),

                          Row(
                            children: [

                              Text(
                                Jiffy(item.date).yMMMdjm,
                                style: blackBoldTextStyle(
                                    fontSize: 11,
                                    context: context,
                                    color: iconsColor),
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




    // var locale = AppLocalizations.of(context)!;
    // Size size =MediaQuery.of(context).size;
    // List<Item> items = [
    //   Item( header:
    //   Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 9),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 SizedBox(
    //                     width: 40,
    //                     height: 40,
    //                     child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),)
    //                 ),
    //
    //                 SizedBox(width: 8,),
    //                 Text("د.سهل مهدي",style: blackBoldTextStyle(context: context,fontSize: 11),),
    //
    //               ],
    //             ),
    //
    //
    //             Text("25.06.2022 10:00",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),)
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top:9),
    //         child: Text("العمليات والإجراءات وتنظيم العمل",style: blackBoldTextStyle(context: context,fontSize: 12  ),),
    //       ),
    //       ReadMoreText(
    //         'أهلا بك هنا في دورة التجارة الالكترونية عبر الانستجرام، والتي تعد أول دورة الكترونية إحترافية متخصصة في إنشاء وتفعيل متجرك الالكتروني عبر تطبيق الانستجرام، وكيف تتفوق على المتاجر المنافسة.فهناك آلاف المتاجر العربية التي لم تستطع النجاح وتحويل الفرص إلى مال، قاموا بفتح صفحات ولكن فشلوا في استقطاب العملاء عبر الانستجرام! إنها ليست سحر أو خدعة حتى تنجح فإن مدربك الشخصي سهل مهدي خبير التسويق الالكتروني عبر وسائل التواصل الاجتماعي يضع بين يديك الأسرار العلمية والمهارات الفنية لتنجح بأسرع وقت ممكن.فقط ركز معنا في بناء متجرك والمحتوى التسويقي وطريقة عرض المنتجات وأهم طرق استهداف العملاء الذي يشترون.في هذه الدورة خطوة بخطوة ستكتشف أنك قادر على صناعة نجاح تجاري هائل عبر تطبيق يعد الأكثر نمواً اليوم والأكثر استخداماً للتجارة الالكتروني.',
    //         trimLines: 2,
    //         colorClickableText:
    //         Color.fromRGBO(6, 177, 229, 1),
    //         trimMode: TrimMode.Line,
    //         trimCollapsedText: locale.showMore!,
    //         trimExpandedText: locale.hide!,
    //         style: blackBoldTextStyle(fontSize: 11, height: 2, context:context,color: Theme.of(context).accentColor),
    //         moreStyle:
    //         blackBoldTextStyle(
    //             fontSize: 11, height: 2, context:context,color: Theme.of(context).accentColor),
    //       ),
    //
    //     ],
    //   ),body: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 13),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //
    //             Row(
    //               children: [
    //                 Container(
    //                   width: 20,
    //                   height: 20,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(200),
    //                     color: Colors.red
    //                   ),
    //                 ),
    //                 SizedBox(width: 8,),
    //                 Text(locale.topics!,style: blackBoldTextStyle(context: context,fontSize: 11),),
    //               ],
    //             ),
    //
    //             GestureDetector(
    //                 onTap: (){
    //                   showModalBottomSheet(
    //                       context: context,
    //                       backgroundColor: Colors.transparent,
    //                       isScrollControlled: true,
    //                       builder: (context) {
    //                         return Stack(
    //                           alignment: Alignment.bottomCenter,
    //                           children: [
    //                             Container(
    //                               height: size.height * 0.65,
    //                               child: Material(
    //                                   color: Theme.of(context).scaffoldBackgroundColor,
    //                                   borderRadius:
    //                                   BorderRadius.only(
    //                                       topLeft:
    //                                       Radius.circular(
    //                                           10),
    //                                       topRight:
    //                                       Radius.circular(
    //                                           10)),
    //                                   child: Padding(
    //                                     padding:
    //                                     const EdgeInsets.only(
    //                                         left: 17,
    //                                         right: 17),
    //                                     child: Column(
    //                                       children: [
    //                                         Padding(
    //                                           padding:
    //                                           const EdgeInsets
    //                                               .only(
    //                                               top: 15),
    //                                           child: Row(
    //                                             mainAxisAlignment:
    //                                             MainAxisAlignment
    //                                                 .center,
    //                                             children: [
    //                                               Container(
    //                                                 width: 50,
    //                                                 height: 3,
    //                                                 color: Theme.of(context).canvasColor,
    //                                               )
    //                                             ],
    //                                           ),
    //                                         ),
    //                                         Padding(
    //                                           padding:
    //                                           const EdgeInsets
    //                                               .only(
    //                                               top: 15),
    //                                           child: Row(
    //                                             mainAxisAlignment:
    //                                             MainAxisAlignment
    //                                                 .center,
    //                                             children: [
    //                                               Text(
    //                                                   locale.addANewArticle!,
    //                                                   style: blackBoldTextStyle(context: context,
    //                                                       fontSize:
    //                                                       15)),
    //                                             ],
    //                                           ),
    //                                         ),
    //
    //                                         Padding(
    //                                           padding: const EdgeInsets.only(top:15),
    //                                           child: CustomTextField(
    //                                             title: '',
    //                                             hint:
    //                                             locale.enterTheTextOfTheArticle!,
    //                                             maxLength: 250,
    //                                             maxLines: 8, onTap: () {  },
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   )),
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.only(
    //                                   bottom: 25,
    //                                   left: 35,
    //                                   right: 35),
    //                               child: SafeArea(
    //                                   child: CustomButton(
    //                                       title: locale.addANewArticle!,
    //                                       onTap: () {
    //                                         Navigator.pop(context);
    //                                       })),
    //                             )
    //                           ],
    //                         );
    //                       });
    //                 },
    //                 child: Text(locale.addANewArticle!,style: blackBoldTextStyle(context: context,fontSize: 11,color: Theme.of(context).primaryColor),)),
    //           ],
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SizedBox(width: 9,),
    //           Container(width: 1,color: Colors.grey,height: 200,),
    //           Row(  mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(width: 10,color: Colors.grey,height: 1,),
    //               Padding(
    //                 padding: const EdgeInsets.only(top:22),
    //                 child: Container(
    //                   width: 331,
    //
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(15),
    //                   // color: Theme.of(context).cursorColor,
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.withOpacity(0.07),
    //                       spreadRadius: 5,
    //                       blurRadius: 7,
    //
    //                     ),
    //                   ],
    //
    //                 ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 15,right: 15),
    //                     child: Column(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 15),
    //                           child: Text("التسويق الرقمي هو عملية ترويج وبيع المنتجات والخدمات من خلال الاستفادة من أساليب التسويق عبر الإنترنت مثل التسويق عبر وسائل التواصل الاجتماعي والتسويق عبر البحث",
    //                           style: blackBoldTextStyle(context: context,fontSize: 11),
    //                           ),
    //                         ),
    //
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 15),
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Row(
    //                                 children: [
    //                                   SizedBox(
    //                                       width: 40,
    //                                       height: 40,
    //                                       child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),)
    //                                   ),
    //
    //                                   SizedBox(width: 8,),
    //                                   Text("د.سهل مهدي",style: blackBoldTextStyle(context: context,fontSize: 11),),
    //
    //                                 ],
    //                               ),
    //                               Text("منذ 15 ${locale.hour}",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),)
    //
    //                             ],
    //                           ),
    //                         ),
    //                         const SizedBox(height: 11,),
    //                       ],
    //                     ),
    //                   ),
    //
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),),
    //
    //   Item( header: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 9),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 SizedBox(
    //                     width: 40,
    //                     height: 40,
    //                     child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),)
    //                 ),
    //
    //                 SizedBox(width: 8,),
    //                 Text("د.سهل مهدي",style: blackBoldTextStyle(context: context,fontSize: 11),),
    //
    //               ],
    //             ),
    //
    //
    //             Text("25.06.2022 10:00",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),)
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top:9),
    //         child: Text("العمليات والإجراءات وتنظيم العمل",style: blackBoldTextStyle(context: context,fontSize: 12  ),),
    //       ),
    //       ReadMoreText(
    //         'أهلا بك هنا في دورة التجارة الالكترونية عبر الانستجرام، والتي تعد أول دورة الكترونية إحترافية متخصصة في إنشاء وتفعيل متجرك الالكتروني عبر تطبيق الانستجرام، وكيف تتفوق على المتاجر المنافسة.فهناك آلاف المتاجر العربية التي لم تستطع النجاح وتحويل الفرص إلى مال، قاموا بفتح صفحات ولكن فشلوا في استقطاب العملاء عبر الانستجرام! إنها ليست سحر أو خدعة حتى تنجح فإن مدربك الشخصي سهل مهدي خبير التسويق الالكتروني عبر وسائل التواصل الاجتماعي يضع بين يديك الأسرار العلمية والمهارات الفنية لتنجح بأسرع وقت ممكن.فقط ركز معنا في بناء متجرك والمحتوى التسويقي وطريقة عرض المنتجات وأهم طرق استهداف العملاء الذي يشترون.في هذه الدورة خطوة بخطوة ستكتشف أنك قادر على صناعة نجاح تجاري هائل عبر تطبيق يعد الأكثر نمواً اليوم والأكثر استخداماً للتجارة الالكتروني.',
    //         trimLines: 2,
    //         colorClickableText:
    //         Color.fromRGBO(6, 177, 229, 1),
    //         trimMode: TrimMode.Line,
    //         trimCollapsedText: 'عرض المزيد',
    //         trimExpandedText: 'اخفاء',
    //         style: blackBoldTextStyle(
    //             fontSize: 11, height: 2, context:context,color: Theme.of(context).accentColor),
    //         moreStyle:
    //         blackBoldTextStyle(
    //             fontSize: 11, height: 2, context:context,color: Theme.of(context).accentColor),
    //       ),
    //
    //     ],
    //   ),
    //     body: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 13),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //
    //             Row(
    //               children: [
    //                 Container(
    //                   width: 20,
    //                   height: 20,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(200),
    //                       color: Colors.red
    //                   ),
    //                 ),
    //                 SizedBox(width: 8,),
    //                 Text("مواضيع",style: blackBoldTextStyle(context: context,fontSize: 11),),
    //               ],
    //             ),
    //
    //             GestureDetector(
    //                 onTap: (){
    //                   showModalBottomSheet(
    //                       context: context,
    //                       backgroundColor: Colors.transparent,
    //                       isScrollControlled: true,
    //                       builder: (context) {
    //                         return Stack(
    //                           alignment: Alignment.bottomCenter,
    //                           children: [
    //                             Container(
    //                               height: size.height * 0.65,
    //                               child: Material(
    //                                   color: Theme.of(context).scaffoldBackgroundColor,
    //                                   borderRadius:
    //                                   const BorderRadius.only(
    //                                       topLeft:
    //                                       Radius.circular(
    //                                           10),
    //                                       topRight:
    //                                       Radius.circular(
    //                                           10)),
    //                                   child: Padding(
    //                                     padding:
    //                                     const EdgeInsets.only(
    //                                         left: 17,
    //                                         right: 17),
    //                                     child: Column(
    //                                       children: [
    //                                         Padding(
    //                                           padding:
    //                                           const EdgeInsets
    //                                               .only(
    //                                               top: 15),
    //                                           child: Row(
    //                                             mainAxisAlignment:
    //                                             MainAxisAlignment
    //                                                 .center,
    //                                             children: [
    //                                               Container(
    //                                                 width: 50,
    //                                                 height: 3,
    //                                                 color: Theme.of(context).canvasColor,
    //                                               )
    //                                             ],
    //                                           ),
    //                                         ),
    //                                         Padding(
    //                                           padding:
    //                                           const EdgeInsets
    //                                               .only(
    //                                               top: 15),
    //                                           child: Row(
    //                                             mainAxisAlignment:
    //                                             MainAxisAlignment
    //                                                 .center,
    //                                             children: [
    //                                               Text(
    //                                                   "إضافة مقال جديد",
    //                                                   style: blackBoldTextStyle(context: context,
    //                                                       fontSize:
    //                                                       15)),
    //                                             ],
    //                                           ),
    //                                         ),
    //
    //                                         Padding(
    //                                           padding: const EdgeInsets.only(top: 30),
    //                                           child: CustomTextField(
    //                                             title: '',
    //                                             hint:
    //                                             'أدخل نص المقال ',
    //                                             onTap: () {  },
    //                                             maxLength: 250,
    //                                             maxLines: 5,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   )),
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.only(
    //                                   bottom: 25,
    //                                   left: 35,
    //                                   right: 35),
    //                               child: SafeArea(
    //                                   child: CustomButton(
    //                                       title: "إضافة مقال جديد",
    //                                       onTap: () {
    //                                         Navigator.pop(context);
    //                                       })),
    //                             )
    //                           ],
    //                         );
    //                       });
    //                 },
    //                 child: Text("إضافة مقال جديد",style: blackBoldTextStyle(context: context,fontSize: 11,color: Theme.of(context).primaryColor),)),
    //           ],
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SizedBox(width: 9,),
    //           Container(width: 1,color: Colors.grey,height: 200,),
    //           Row(  mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(width: 10,color: Colors.grey,height: 1,),
    //               Padding(
    //                 padding: const EdgeInsets.only(top:22),
    //                 child: Container(
    //                   width: 331,
    //
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(15),
    //                     // color: Theme.of(context).cursorColor
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 15,right: 15),
    //                     child: Column(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 15),
    //                           child: Text("التسويق الرقمي هو عملية ترويج وبيع المنتجات والخدمات من خلال الاستفادة من أساليب التسويق عبر الإنترنت مثل التسويق عبر وسائل التواصل الاجتماعي والتسويق عبر البحث",
    //                             style: blackBoldTextStyle(context: context,fontSize: 11),
    //                           ),
    //                         ),
    //
    //                         Padding(
    //                           padding: const EdgeInsets.only(top: 15),
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Row(
    //                                 children: [
    //                                   SizedBox(
    //                                       width: 40,
    //                                       height: 40,
    //                                       child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),)
    //                                   ),
    //
    //                                   SizedBox(width: 8,),
    //                                   Text("د.سهل مهدي",style: blackBoldTextStyle(context: context,fontSize: 11),),
    //
    //                                 ],
    //                               ),
    //                               Text("منذ 15 ساعة",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),)
    //                             ],
    //                           ),
    //                         ),
    //                         const SizedBox(height: 11,),
    //                       ],
    //                     ),
    //                   ),
    //
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),),
    //
    //
    // ];
    // return Column(
    //   children: [
    //     SingleChildScrollView(
    //       child: ExpansionPanelList.radio(
    //         initialOpenPanelValue: 0,
    //         elevation: 0,
    //
    //         children: items
    //             .map((item) => ExpansionPanelRadio(
    //             backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
    //             canTapOnHeader: true,
    //             value: item.header,
    //             headerBuilder: (context, isExpanded) =>
    //                 ListTile(
    //                   title: item.header,
    //                 ),
    //             body: ListTile(title: item.body)))
    //             .toList(),
    //         expandedHeaderPadding: EdgeInsets.zero,
    //       ),
    //     ),
    //   ],
    // );

  }
}
