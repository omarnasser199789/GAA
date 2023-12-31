// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
// import 'core/widgets/appBarType2.dart';
// import 'core/widgets/custom_botton.dart';
// import 'package:comment_tree/data/comment.dart';
// import 'package:comment_tree/widgets/comment_tree_widget.dart';
// import 'package:comment_tree/widgets/tree_theme_data.dart';
// import 'core/widgets/custom_text_field.dart';
//
// class DiscussionById extends StatefulWidget {
//   const DiscussionById({Key? key}) : super(key: key);
//
//   @override
//   State<DiscussionById> createState() => _DiscussionByIdState();
// }
//
// class _DiscussionByIdState extends State<DiscussionById> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar:
//       // appBarWidget(
//       //     "ما هي الأهداف الاستراتيجية التي ستحققها لشركتك؟", context, true, null,null),
//
//       appBarType2(title:  "ما هي الأهداف الاستراتيجية التي ستحققها لشركتك؟",context:context),
//
//
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 10),
//         child: FloatingActionButton(
//           onPressed: () {
//             showModalBottomSheet(
//                 context: context,
//                 backgroundColor: Colors.transparent,
//                 isScrollControlled: true,
//                 builder: (context) {
//                   return Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       Container(
//                         height: size.height * 0.6,
//                         child: Material(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10)),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 17, right: 17),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 15),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           height: 3,
//                                           color: Theme.of(context).canvasColor,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 15),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(locale.addPostToDiscussion!,
//                                             style:
//                                                 blackBoldTextStyle(context: context,fontSize: 15)),
//                                       ],
//                                     ),
//                                   ),
//                                    Padding(
//                                      padding: const EdgeInsets.only(top:20),
//                                      child: CustomTextField(
//                                       title: '',
//                                       hint: locale.addToIndicateTrainer!,
//                                       // maxLength: 250,
//                                       maxLines: 10, onTap: () {  },
//                                   ),
//                                    ),
//                                 ],
//                               ),
//                             )),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             bottom: 25, left: 35, right: 35),
//                         child: SafeArea(
//                             child: CustomButton(
//                                 title: locale.addPostToDiscussion!,
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 })),
//                       )
//                     ],
//                   );
//                 });
//           },
//           backgroundColor: kMainColor,
//           child: SvgPicture.asset(
//             "assets/svgs/comment  icon.svg",
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 13),
//         child: DefaultTabController(
//           length: 3,
//           child: Flex(
//             direction: Axis.vertical,
//             children: [
//               TabBar(
//                 // isScrollable: true,
//                 labelColor: Theme.of(context).primaryColor,
//                 unselectedLabelColor: iconsColor,
//                 padding: EdgeInsets.only(left: 10, right: 10),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicatorWeight: 2.5,
//                 indicatorColor: Theme.of(context).primaryColor,
//
//                 labelStyle: blackBoldTextStyle(context: context,
//                   fontSize: 12,
//                 ),
//
//                 tabs:  [
//                   Tab(
//                     height: 30,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Text("${locale.all!} (233)"),
//                     ),
//                   ),
//                   Tab(
//                     height: 30,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Text("${locale.latest!} (233)"),
//                     ),
//                   ),
//                   Tab(
//                     height: 30,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Text("${locale.older!} (233)"),
//                     ),
//                   ),
//                 ],
//               ),
//                Flexible(
//                 child: TabBarView(
//                   children: [
//                     DataContainer(),
//                     DataContainer(),
//                     DataContainer(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DataContainer extends StatefulWidget {
//    DataContainer({Key? key}) : super(key: key);
//
//   @override
//   State<DataContainer> createState() => _DataContainerState();
// }
//
// class _DataContainerState extends State<DataContainer> {
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//
//       body: Container(
//         child: CommentTreeWidget<Comment, Comment>(
//           Comment(
//               avatar: 'null',
//               userName: 'null',
//               content: 'felangel made felangel/cubit_and_beyond public '),
//           [
//             Comment(
//                 avatar: 'null',
//                 userName: 'null',
//                 content: 'A Dart template generator which helps teams'),
//             Comment(
//                 avatar: 'null',
//                 userName: 'null',
//                 content:
//                 'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
//             Comment(
//                 avatar: 'null',
//                 userName: 'null',
//                 content: 'A Dart template generator which helps teams'),
//             Comment(
//                 avatar: 'null',
//                 userName: 'null',
//                 content:
//                 'A Dart template generator which helps teams generator which helps teams '),
//           ],
//           treeThemeData:
//           TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 3),
//           avatarRoot: (context, data) => const PreferredSize(
//             child: CircleAvatar(
//               radius: 18,
//               backgroundColor: Colors.grey,
//               backgroundImage: AssetImage('assets/avatar_2.png'),
//             ),
//             preferredSize: Size.fromRadius(18),
//           ),
//           avatarChild: (context, data) => const PreferredSize(
//             child: CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.grey,
//               backgroundImage: AssetImage('assets/avatar_1.png'),
//             ),
//             preferredSize: Size.fromRadius(12),
//           ),
//           contentChild: (context, data) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'dangngocduc',
//                         style:blackBoldTextStyle(fontSize: 14, context: context),
//                       ),
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       Text(
//                         '${data.content}',
//                         style:blackRegularTextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DefaultTextStyle(
//                   style: Theme.of(context).textTheme.caption!.copyWith(
//                       color: Colors.grey[700], fontWeight: FontWeight.bold),
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 4),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Text('Like'),
//                         SizedBox(
//                           width: 24,
//                         ),
//                         Text('Reply'),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             );
//           },
//           contentRoot: (context, data) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                   decoration: BoxDecoration(
//                       color:Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'dangngocduc',
//                         style: blackBoldTextStyle(fontSize: 14, context: context),
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Text(
//                         '${data.content}',
//                         style: blackRegularTextStyle(fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DefaultTextStyle(
//                   style: Theme.of(context).textTheme.caption!.copyWith(
//                       color: Colors.grey[700], fontWeight: FontWeight.bold),
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 4),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Text('Like'),
//                         SizedBox(
//                           width: 24,
//                         ),
//                         Text('Reply'),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       ),
//     );
//
//
//   }
// }
