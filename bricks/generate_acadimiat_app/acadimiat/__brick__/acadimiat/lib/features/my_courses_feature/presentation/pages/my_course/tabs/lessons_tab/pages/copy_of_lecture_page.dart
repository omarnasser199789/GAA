
//
// import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_cart_state.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:comment_tree/data/comment.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter/material.dart';
// import 'package:acadmiat/core/globals.dart';
// import 'package:flutter/foundation.dart';
// import '../../../../../../../../../../../../../injection_container.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:acadmiat/Theme/style.dart';
// import 'package:acadmiat/features/my_courses_feature/presentation/widgets/video_widget/vimeo_video.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../../../../../../../../Locale/locale.dart';
// import '../../../../../../../../core/widgets/back_button.dart';
// import '../../../../../../../../core/widgets/cached_net_work_image.dart';
// import '../../../../../../../../core/widgets/waiting_widget.dart';
// import '../../../../../../domain/entities/my_lecture_entity.dart';
// import '../../notes_tab.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';
// import 'package:measure_size/measure_size.dart';
// import '../../../../../../domain/entities/my_course_entity.dart';
// import '../../../../../../domain/use_cases/get_my_lecture_usecase.dart';
// import '../../../../../bloc/my_cart_bloc.dart';
// import '../../../../../bloc/my_courses_event.dart';
// import '../../../../../bloc/my_cart_state.dart';
// import '../../../../../widgets/add_comment_widget.dart';
// import '../../../../../widgets/discussion_widget.dart';
// import '../../../../../widgets/video_widget/amazon_video.dart';
//
// class LecturePage extends StatefulWidget with MyCoursesState {
//   const LecturePage(
//       {Key? key,
//       required this.part,
//       required this.index,
//       required this.myCourseEntity,
//         required this.courseCover,
//       required this.lectureId})
//       : super(key: key);
//
//   final int lectureId;
//   final MyCourseEntity myCourseEntity;
//   final int index;
//   final int part;
//   final String courseCover;
//   @override
//   State<LecturePage> createState() => LecturePageState();
// }
//
//
// class LecturePageState extends State<LecturePage> {
//   double heightWidget = 0;
//   bool loading = false;
//   double addCommentWidgetHeight =0;
//   late  MyLectureEntity myLectureEntity;
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: BlocProvider(
//           create: (BuildContext context) => sl<MyCoursesBloc>(),
//           child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
//               builder: (context, state) {
//                 if (state is Empty) {
//                   BlocProvider.of<MyCoursesBloc>(context).add(GetMyLecture(
//                       myLectureParams: MyLectureParams(
//                           userId: userId(), lectureId: widget.lectureId)));
//                 }
//                 if (state is SuccessGetMyLectureEntity) {
//                   myLectureEntity= state.myLectureEntity;
//
//                   return DefaultTabController(
//                     length:(myLectureEntity.contents[0].type==1)?
//                     (myLectureEntity.contents.length>1)? 3:2:1,
//                     child:NestedScrollView(
//                     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                           return <Widget>[
//
//
//                             SliverAppBar(
//                               pinned: true,
//                               forceElevated:false,
//                               collapsedHeight: kToolbarHeight,
//                               expandedHeight: 400, //30,
//                               elevation: 4, //0,
//                               backgroundColor: Theme.of(context).cardColor,
//                               floating: true,
//                               automaticallyImplyLeading: false,
//
//                               bottom: PreferredSize(
//                                 preferredSize: const Size.fromHeight(10),
//                                 child: Column(
//                                   children: [
//                                     if(myLectureEntity.contents[0].type!=1)
//                                       SafeArea(child: SizedBox(height: 20,)),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 10, bottom: 10, right: 10, left: 10),
//                                       child: TabBar(
//                                         isScrollable: false,
//                                         labelColor: Theme.of(context).primaryColor,
//                                         unselectedLabelColor: iconsColor,
//                                         indicatorSize: TabBarIndicatorSize.tab,
//                                         labelPadding: EdgeInsets.only(
//                                             left: size.width * 0.048,
//                                             right: size.width * 0.048),
//                                         labelStyle: blackBoldTextStyle(
//                                           context: context,
//                                           fontSize: 11 + zoomRatio,
//                                         ),
//                                         indicator: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(7),
//                                             color: Theme.of(context)
//                                                 .primaryColor
//                                                 .withOpacity(0.1)),
//                                         tabs: [
//                                           if(myLectureEntity.contents.length>1)
//                                             const Tab(
//                                               height: 30,
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text("محتوى الدرس"),
//                                               ),
//                                             ),
//                                           if(myLectureEntity.contents[0].type==1)
//                                             const Tab(
//                                               height: 30,
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text("التعليقات"),
//                                               ),
//                                             ),
//                                           if(myLectureEntity.contents[0].type==1)
//                                             Tab(
//                                               height: 30,
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(locale.notes!),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                               flexibleSpace: FlexibleSpaceBar(
//
//                                 background: Container(
//                                   color: Theme.of(context).scaffoldBackgroundColor,
//                                   child: SafeArea(
//
//                                     bottom: false,
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(top:30),
//                                           child: AppBar(
//                                             // title: Text("سلة المشتريات  (3)",style: blackBoldTextStyle(context: context,fontSize: 15),),
//                                             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                                             elevation: 0,
//                                             leading:
//                                              BackButtonWidget(
//                                                onTap: ()async{
//                                                  vimeoVideoWidgetKey.currentState!.stopVideo();
//                                                  await Future.delayed(Duration(microseconds: 1000));
//                                                  Navigator.pop(context);
//                                                },
//                                              ),
//                                             actions: [
//
//
//
//                                               GestureDetector(
//                                                 onTap: (){
//                                                   Share.share(
//                                                     // 'شاهد المنتج على كلشي اونلاين  https://kulshionline.com/product/${parentCategoryTitle.toLowerCase()}/$id '+
//                                                     // ' حمّل التطبيق من google app:'+ 'https://play.google.com/store/apps/details?id=com.lucid.testkulshi'+
//                                                     // 'حمّل التطبيق من App store:'+'https://apps.apple.com/us/app/kulshi-online/id1625655892'
//
//
//                                                       "watch--------- \n https://google.com  \n\n downloadTheAppFromGooglePlay \n https://play.google.com \n\n downloadTheAppFromAppStore\n https://apps.apple.com"
//                                                   );
//                                                 },
//                                                 child: SizedBox(
//                                                   width: 30,
//                                                   height: 30,
//                                                   child: SvgPicture.asset(
//                                                     "assets/svgs/share.svg",
//                                                     color:iconsColor,
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               const SizedBox(width: 15,),
//
//
//                                             ],
//
//                                           ),
//                                         ),
//
//                                         (myLectureEntity.contents[0].type==1)?
//                                         Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//
//                                             AmazonVideoWidget(
//                                               key: amazonVideoWidgetKey,
//                                               // videoUrl: state
//                                               //     .myLectureEntity
//                                               //     .contents[0]
//                                               //     .fileUrl, //widget.content.fileUrl,
//                                               videoUrl: myLectureEntity.currentVideo.url,
//                                               content: myLectureEntity.contents[0], //from my lecture
//                                               lectureId: widget.lectureId,
//                                               courseId: widget.myCourseEntity.id,
//                                               contentId: widget
//                                                   .myCourseEntity
//                                                   .courseContents[widget.part]
//                                                   .contents[widget.index]
//                                                   .lectureContents[0
//                                               // widget.contentIndex
//                                               ]
//                                                   .id,
//                                               lectureLogId: widget
//                                                   .myCourseEntity
//                                                   .courseRecord
//                                                   .unitsLog[widget.part]
//                                                   .lecturesLog[0]
//                                                   .id,
//                                             ),
//                                             VimeoVideoWidget(
//                                               key: vimeoVideoWidgetKey,
//                                               content: myLectureEntity.contents[0],
//                                               lectureId: widget.lectureId,
//                                               contentId: widget
//                                                   .myCourseEntity
//                                                   .courseContents[widget.part]
//                                                   .contents[widget.index]
//                                                   .lectureContents[0
//                                               // widget.contentIndex
//                                               ]
//                                                   .id,
//                                               courseId: widget.myCourseEntity.id,
//                                               lectureLogId: widget
//                                                   .myCourseEntity
//                                                   .courseRecord
//                                                   .unitsLog[widget.part]
//                                                   .lecturesLog[0]
//                                                   .id,
//                                             ),
//                                             Padding(//
//                                               padding: const EdgeInsets.only(left: 17,right: 17,top:10,bottom: 7),
//                                               child: Text(myLectureEntity.contents[0].file.fileName, style: blackBoldTextStyle(
//                                                   context: context,
//                                                   fontSize: 12),),
//                                             )
//                                           ],
//                                         ):Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//
//                                             SizedBox(
//                                               width: double.infinity,
//                                               height: 200,
//                                               child: CachedNetWorkImage(
//                                                 borderRadius:
//                                                 BorderRadius.circular(0),
//                                                 url: widget.courseCover,
//                                                 boxFit: BoxFit.fill,
//                                               ),
//                                             ),
//
//                                           ],
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//
//
//
//
//                           ];
//                     },
//                       body:  Container(
//                         height: size.height- heightWidget,
//                         child: TabBarView(
//
//                           children: [
//                             if(myLectureEntity.contents.length>1)
//                               ListView.builder(
//                                   itemCount: myLectureEntity.contents.length,
//                                   itemBuilder: (context, index) {
//                                     if (myLectureEntity.contents[index].type == 13 || myLectureEntity.contents[index].type == 3)
//                                     {
//                                       ///PDF
//                                       return Stack(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               // setState(() {
//                                               //   loading = true;
//                                               // });
//
//                                               PdftronFlutter.openDocument(myLectureEntity
//                                                   .contents[index]
//                                                   .fileUrl)
//                                                   .whenComplete(() {
//                                                 // setState(() {
//                                                 //   loading = false;
//                                                 // });
//                                               });
//                                               // setState(() {
//                                               //   loading = false;
//                                               // });
//                                             },
//                                             child: Container(
//                                               color: Theme.of(context).scaffoldBackgroundColor,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(
//                                                         bottom: 13,
//                                                         top: 13,
//                                                         left: 17,
//                                                         right: 17),
//                                                     child: Row(
//                                                       children: [
//                                                         SvgPicture.asset(
//                                                           "assets/svgs/pdf icon.svg",
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 8,
//                                                         ),
//                                                         Container(
//                                                           // color: Colors.red,
//                                                           width: size.width - 70,
//                                                           child: Text(
//                                                             state
//                                                                 .myLectureEntity
//                                                                 .contents[index]
//                                                                 .file
//                                                                 .fileName,
//                                                             style: blackBoldTextStyle(
//                                                                 context: context,
//                                                                 fontSize: 11),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     width: double.infinity,
//                                                     height: 0.3,
//                                                     color: Theme.of(context)
//                                                         .canvasColor
//                                                         .withOpacity(0.5),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           if(loading)
//                                             const WaitingWidget(),
//                                         ],
//                                       );
//                                     }
//                                     else if (myLectureEntity.contents[index].type == 9) {
//
//                                       return Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 bottom: 13,
//                                                 top: 13,
//                                                 left: 17,
//                                                 right: 17),
//                                             child: Row(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   "assets/svgs/consulting.svg",
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 8,
//                                                 ),
//                                                 Container(
//                                                   // color: Colors.red,
//                                                   width: size.width - 70,
//                                                   child: Text(
//                                                     myLectureEntity
//                                                         .contents[index].activity.title,
//                                                     style: blackBoldTextStyle(
//                                                         context: context,
//                                                         fontSize: 11),
//                                                   ),
//                                                 ),
//
//
//
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             width: double.infinity,
//                                             height: 0.3,
//                                             color: Theme.of(context)
//                                                 .canvasColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ],
//                                       );
//                                     }
//
//                                     else if (myLectureEntity.contents[index].type == 4) {
//
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(15),
//
//                                                 border: Border.all(width: 1,color: Theme.of(context).canvasColor.withOpacity(0.5))
//                                             ),
//
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               // child: Text(
//                                               //
//                                               //   parseHtmlString(myLectureEntity.contents[index].body),style: blackBoldTextStyle(fontSize: 12, context: context),
//                                               // ),
//
//
//                                               child:Linkify(
//                                                 onOpen: (link) async {
//                                                   if (await canLaunch(link.url)) {
//                                                     await launch(link.url);
//                                                   } else {
//                                                     throw 'Could not launch $link';
//                                                   }
//                                                 },
//                                                 text: parseHtmlString(myLectureEntity.contents[index].body),
//                                                 style: blackBoldTextStyle(fontSize: 13, context: context,height: 1.7,),
//                                                 linkStyle: blackBoldTextStyle(fontSize: 13, context: context,color: Colors.blue),
//                                               ),
//                                               // child: Linkify(
//                                               //   onOpen: (link) async {
//                                               //     if (await canLaunch(link.url)) {
//                                               //       await launch(link.url);
//                                               //     } else {
//                                               //       throw 'Could not launch $link';
//                                               //     }
//                                               //   },
//                                               //   text:parseHtmlString(myLectureEntity.contents[index].body),
//                                               //   //
//                                               //   style: TextStyle(color: Colors.yellow),
//                                               //   linkStyle: TextStyle(color: Colors.red),
//                                               // ),
//                                               // child: HtmlWidget(
//                                               //
//                                               //   myLectureEntity.contents[index].body,//.replaceAll("background-color", "background-color: 'red';"),
//                                               //
//                                               //   customWidgetBuilder: (element) {
//                                               //     if (element.attributes['background-color'] == 'bar') {
//                                               //       return Container(
//                                               //         width: 20,
//                                               //         height: 30,
//                                               //         color: Colors.red,
//                                               //       );
//                                               //
//                                               //     }
//                                               //
//                                               //     return null;
//                                               //   },
//                                               //
//                                               //
//                                               //   webView: true,
//                                               //
//                                               //
//                                               //
//                                               // ),
//
//
//                                             )),
//                                       );
//                                     }
//
//
//                                     ///نشاط تدريبي(true or false)
//                                     else if (myLectureEntity.contents[index].type == 5) {
//                                       return Text(myLectureEntity.contents[index].activity.title);
//
//                                     }
//                                     ///(توصيل)نشاط تدريبي
//                                     else if (myLectureEntity.contents[index].type == 10) {
//                                       return Text(myLectureEntity.contents[index].activity.title);
//
//                                     }
//                                     ///(توصيل)نشاط تدريبي
//                                     else if (myLectureEntity.contents[index].type == 8) {
//                                       return Text(myLectureEntity.contents[index].activity.caseStudy["caseHeader"].toString());
//
//                                     }
//                                     if(myLectureEntity.contents[index].type != 1) {
//                                       return Text(myLectureEntity.contents[index]
//                                           .type.toString());
//                                     }
//                                     return Container();
//                                   }),
//
//
//                             Stack(
//                               alignment: Alignment.bottomCenter,
//                               // mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding:  EdgeInsets.only(bottom: addCommentWidgetHeight),
//                                   child: DiscussionWidget(
//                                     key: discussionWidgetKey,
//                                     lectureId: widget.lectureId,
//                                   ),
//                                 ),
//
//
//                                 Container(
//                                   child: MeasureSize(
//                                       onChange: (Size newSize){
//                                         setState(() {
//                                           addCommentWidgetHeight=newSize.height;
//                                         });
//                                       },
//                                       child: AddCommentWidget(
//                                         lectureId: widget.lectureId,
//                                       )),
//                                 ),
//                               ],
//                             ),
//
//
//                             NotesTab(
//                               // bookmarks: myLectureEntity.currentVideo.bookmarks,
//                               isVimeo: (myLectureEntity.contents[0].file.isVimeo != null) ?myLectureEntity.contents[0].file.isVimeo : false,
//                               videoId: myLectureEntity.contents[0].file.id,
//                               key: bookMarksWidgetKey,
//                             ),
//                           ],
//                         ),
//                       ),),
//
//                   );
//                 }
//
//                 return Column(
//                   children: [
//                     Shimmer.fromColors(
//                       baseColor: Theme.of(context).cardColor,
//                       highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
//                       child: Container(
//                         width:double.infinity,
//                         height: 250,
//                         color: Colors.orange,
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(top:80),
//                       child: Shimmer.fromColors(
//                         baseColor: Theme.of(context).cardColor,
//                         highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 17,right: 17,top:17),
//                           child: CommentWidget(
//
//                             comments: [  Comment(
//                                 avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
//                                 userName: "  ",
//                                 content: " *************************************** "),
//                               Comment(
//                                   avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
//                                   userName: "  ",
//                                   content: " *************************************** "),
//
//                             ]
//
//                             ,hadeComment:
//                           Comment(
//                               avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
//                               userName: "********",
//                               content:"*********"),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               })),
//     );
//   }
// }
