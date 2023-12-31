// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
//
// import 'Theme/style.dart';
//
// import 'core/widgets/app_bar_widget.dart';
// import 'core/widgets/custom_botton.dart';
// import 'exam_folder/exam_page.dart';
// import 'exam_folder/widgets/question_number.dart';
//
// class CloseCaseStudyPage extends StatefulWidget {
//   const CloseCaseStudyPage({Key? key,required this.index}) : super(key: key);
//
//   final int index;
//   @override
//   State<CloseCaseStudyPage> createState() => _CloseCaseStudyPageState();
// }
//
// class _CloseCaseStudyPageState extends State<CloseCaseStudyPage> {
//   var val;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     return Scaffold(
//       appBar:appBarWidget("",context,true,null,null),
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 17,right: 17),
//             child: Column(
//               children: [
//
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 14),
//                   child: Text("مشروع (1) انشاء متجر الكتروني :"+ "3.1 القوائم المالية المستخدمة في التحليل المالي",style: blackBoldTextStyle(context: context,fontSize: 14),),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 18),
//                   child: Container(
//
//                     // height: 347,
//
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(15),
//
//                     ),
//
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 23,bottom: 23,left: 12,right: 12),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 17),
//                             child: Row(
//                               children: [
//
//                                 const QuestionNumber(text: '01',),
//                                 const SizedBox(width: 9,),
//                                 SizedBox(
//                                     width: size.width*0.7,
//
//                                     child: Text("لا بد عند منح سلطات للمفوض تمكنه من أداء المهمة المفوضة له؟ ",style: blackBoldTextStyle(context: context,fontSize: 14,height: 1.5),)),
//                               ],
//                             ),
//                           ),
//
//
//                           Padding(
//                             padding:  EdgeInsets.only(
//                                 top: 15
//                             ),
//                             child: GestureDetector(
//                               onTap: (){
//                                 setState(() {
//
//                                   val =1 ;
//
//                                 });
//                               },
//                               child: Container(
//                                 decoration: selectDecoration,
//                                 child: Row(
//                                   children: [
//
//                                     Radio(
//                                       fillColor: MaterialStateColor.resolveWith((states) => activeColor),
//                                       value: 1,
//                                       groupValue: val,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           val = value;
//
//                                         });
//                                       },
//                                       activeColor: Theme.of(context).primaryColor,
//                                     ),
//                                     Text("القيام بإجراءات تصحيحية",style: blackBoldTextStyle(context: context,fontSize: 13),)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:  EdgeInsets.only(
//                               top: 15,
//                             ),
//                             child: GestureDetector(
//                               onTap: (){
//                                 setState(() {
//
//                                   val =2 ;
//
//                                 });
//                               },
//                               child: Container(
//                                 decoration: selectDecoration,
//                                 child: Row(
//                                   children: [
//
//                                     Radio(
//                                       fillColor: MaterialStateColor.resolveWith((states) => activeColor),
//                                       value: 2,
//                                       groupValue: val,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           val = value;
//
//                                         });
//                                       },
//                                       activeColor: Theme.of(context).primaryColor,
//                                     ),
//                                     Text("القيام بإجراءات تصحيحية",style: blackBoldTextStyle(context: context,fontSize: 13),)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:  EdgeInsets.only(
//                                 top: 15
//                             ),
//                             child: GestureDetector(
//                               onTap: (){
//                                 setState(() {
//
//                                   val =3 ;
//
//                                 });
//                               },
//                               child: Container(
//                                 decoration: selectDecoration,
//                                 child: Row(
//                                   children: [
//
//                                     Radio(
//                                       fillColor: MaterialStateColor.resolveWith((states) => activeColor),
//                                       value: 3,
//                                       groupValue: val,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           val = value;
//
//                                         });
//                                       },
//                                       activeColor: Theme.of(context).primaryColor,
//                                     ),
//                                     Text("القيام بإجراءات تصحيحية",style: blackBoldTextStyle(context: context,fontSize: 13),)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding:  EdgeInsets.only(
//                               top: 15,
//                             ),
//                             child: GestureDetector(
//                               onTap: (){
//                                 setState(() {
//
//                                   val =4 ;
//
//                                 });
//                               },
//                               child: Container(
//                                 decoration: selectDecoration,
//                                 child: Row(
//                                   children: [
//
//                                     Radio(
//                                       fillColor: MaterialStateColor.resolveWith((states) => activeColor),
//                                       value: 4,
//                                       groupValue: val,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           val = value;
//
//                                         });
//                                       },
//                                       activeColor: Theme.of(context).primaryColor,
//                                     ),
//                                     Text("القيام بإجراءات تصحيحية",style: blackBoldTextStyle(context: context,fontSize: 13),)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
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
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                         child: CustomButton(width: size.width*0.9,
//                           onTap: () {
//
//
//                           }, title: 'إرسال الحل',),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
