//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import 'Theme/style.dart';
//
// import 'core/widgets/app_bar_widget.dart';
// import 'core/widgets/custom_botton.dart';
// import 'features/my_courses_feature/presentation/pages/my_course/course_page.dart';
//
// class SuccessBox extends StatefulWidget {
//   const SuccessBox({Key? key,required this.title,required this.body1,required this.body2}) : super(key: key);
//
//   final String title;
//   final String body1;
//   final String body2;
//
//   @override
//   State<SuccessBox> createState() => _SuccessBoxState();
// }
//
// class _SuccessBoxState extends State<SuccessBox> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       color: Colors.black.withOpacity(0.15),
//       child: Padding(
//         padding:  EdgeInsets.only(
//           top: size.height*0.15,
//           bottom: size.height*0.15,
//           left:35,
//           right: 35,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color:Theme.of(context).scaffoldBackgroundColor,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Dialog(
//                 elevation: 0,
//
//                 insetPadding: EdgeInsets.zero,
//                 child: Scaffold(
//
//                   body: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Container(
//                             width: 60,
//                             child: Image(image: AssetImage("assets/gifs/done.gif"),)),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20,left: 40,right: 40),
//                         child: Text("تمت عملية الشراء بنجاح تمتع بتجربة نوعية",
//                             textAlign: TextAlign.center,
//                             style: blackBoldTextStyle(context: context,fontSize: 15,height: 1.5)
//                         ,),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top:20),
//                         child: Text("03 دورات",style: blackBoldTextStyle(context: context,fontSize: 15),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12,bottom: 33),
//                         child: Container(
//                           width: 150,
//                           alignment: Alignment.center,
//                           // color: Colors.red,
//                           child: Row(
//                             children: [
//                               Text("#CT256",style: blackRegularTextStyle(fontSize: 14),),
//                               const SizedBox(width: 10,),
//
//                               Text("رقم الطلب",style: blackBoldTextStyle(context: context,fontSize: 15),),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10,right: 10,),
//                             child: CustomButton(title: "ابدء بالتعلم", onTap: (){
//                               Navigator.pop(context,200);
//
//
//                             }),
//                           ),
//
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
//                             child: CustomButton(title: "إغلاق", onTap: (){
//                               Navigator.pop(context);
//
//                             },color: Colors.white.withOpacity(0.1),textColor: Theme.of(context).canvasColor,),
//                           ),
//
//
//
//                         ],
//                       ),
//
//
//
//
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }
