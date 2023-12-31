// import 'package:flutter/material.dart';
//
// import 'Theme/style.dart';
//
// import 'core/widgets/appBarType2.dart';
// import 'core/widgets/custom_botton.dart';
// import 'core/widgets/custom_text_field.dart';
// import 'discussion_by_id.dart';
// import 'package:flutter/services.dart';
//
// class OpenCaseStudyPage extends StatefulWidget {
//   const OpenCaseStudyPage({Key? key,required this.index}) : super(key: key);
//
//   final int index;
//   @override
//   State<OpenCaseStudyPage> createState() => _OpenCaseStudyPageState();
// }
//
// class _OpenCaseStudyPageState extends State<OpenCaseStudyPage> {
//   var val;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar:appBarWidget("مشروع (1) انشاء متجر الكتروني :"+ "3.1 القوائم المالية المستخدمة في التحليل المالي",context,true,null,null),
//
//       appBar:
//       appBarType2(title:  " القوائم المالية المستخدمة في التحليل المالي   القوائم المالية المستخدمة في التحليل المال",context:context),
//
//
//       body: Stack(
//
//         alignment: Alignment.bottomCenter,
//         children: [
//
//
//           TabBarWidget(),
//
//           Container(
//             color: Colors.white,
//             height: 83,
//             width: double.infinity,
//           ),
//           SafeArea(
//             child: Container(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               height: 83,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 17,right: 17,top: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//
//                     Hero(
//                       tag: "PaymentPageBTN${widget.index}",
//
//                       child: Material(
//                         child: Material(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           child: CustomButton(width: size.width*0.9,
//                             onTap: () {
//
//
//                             }, title: 'إرسال الحل',),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//
//
//         ],
//       ),
//     );
//   }
// }
//
// class TabBarWidget extends StatelessWidget {
//   const TabBarWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//
//       child:Flex(
//         direction: Axis.vertical,
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color:Theme.of(context).scaffoldBackgroundColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.04),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10,bottom: 10),
//               child: TabBar(
//                 // isScrollable: true,
//                 labelColor: Theme.of(context).primaryColor,
//                 unselectedLabelColor:Theme.of(context).canvasColor,
//                 padding:const EdgeInsets.only(left: 10,right: 10) ,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelStyle:  blackBoldTextStyle(context: context,fontSize: 11,),
//                 indicatorColor: Theme.of(context).primaryColor,
//                 // indicator: BoxDecoration(
//                 //
//                 //     borderRadius: BorderRadius.circular(7),
//                 //     color: Theme.of(context).primaryColor.withOpacity(0.1)),
//
//                 tabs: const [
//                   Tab(
//                     height: 30,
//
//                     child: Align(
//
//                       alignment: Alignment.center,
//                       child:Text("الحالة الدراسية"),
//                     ),
//                   ),
//                   Tab(
//                     height: 30,
//
//                     child: Align(
//                       alignment: Alignment.center,
//                       child:Text("التعليقات"),
//                     ),
//                   ),
//
//
//                 ],
//
//               ),
//             ),
//           ),
//            Flexible(
//             child: TabBarView(children: [
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 17,right: 17),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 19),
//                         child: Container(width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).cardColor,
//                             borderRadius: BorderRadius.circular(15),
//
//                           ),
//
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
//                             child: Column(
//                               children: [
//                                 Text("اذكر ما هي خطوات التخطيط التشغيلي مع ذكر مثال عملي على ذلك؟ما هي الإدارة بالأهاذكر ما هي خطوات التخطيط التشغيلي مع ذكر مثال عملي على ذلك؟ما هي الإدارة بالأهداف مع ضرب أمثلة على ذلك؟داف مع ضرب أمثلة على ذلك؟اذكر ما هي خطوات التخطيط التشغيلي مع ذكر مثال عملي على ذلك؟ما هي الإدارة بالأهاذكر ما هي خطوات التخطيط التشغيلي مع ذكر مثال عملي على ذلك؟ما هي الإدارة بالأهداف مع ضرب أمثلة على ذلك؟داف مع ضرب أمثلة على ذلك؟",
//
//                                   style:blackBoldTextStyle(
//                                       fontSize: 12, height: 2, context:context,color: Theme.of(context).accentColor),
//
//                                 ),
//
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 15,left: 30,right: 30),
//                                   child: CustomButton(
//                                       color: Theme.of(context).primaryColor.withOpacity(0.1),
//                                       textColor: Theme.of(context).primaryColor,
//                                       title: "قراءة المزيد", onTap: (){
//
//                                   }),
//                                 )
//                               ],
//                             ),
//                           ),
//
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 14),
//                         child: Text("الحل",style: blackBoldTextStyle(context: context,fontSize: 14),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12,bottom: 100),
//                         child: CustomTextField(title: '', hint: 'اكتب الحل هنا ... ',maxLines: 5,isPassword: false, onTap: () {  },),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//               DataContainer(),
//
//
//
//             ],),
//           ) ,
//         ],
//
//       ),
//
//     );
//   }
// }
//
