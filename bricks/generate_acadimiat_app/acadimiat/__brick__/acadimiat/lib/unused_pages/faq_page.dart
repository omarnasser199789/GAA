// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
//
//
// import 'package:flutter_svg/flutter_svg.dart';
//
// import 'features/home_feature/presentation/pages/course_content_page.dart';
//
// import 'package:url_launcher/url_launcher.dart';
// class FaqPage extends StatefulWidget {
//
//   const FaqPage({Key? key}) : super(key: key);
//
//   @override
//   State<FaqPage> createState() => _FaqPageState();
// }
// class Itemm{
//   Itemm({required this.header,required this.body});
// Widget header;
// Widget body;
//
// }
// class _FaqPageState extends State<FaqPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     List<Itemm> items=[
//       Itemm(header:Text(locale.whatIsMasterAcademy!,style: blackBoldTextStyle(context: context,fontSize: 13),),body: Text(locale.text!,style: blackBoldTextStyle(
//           fontSize: 12, height: 2, context:context,color: Theme.of(context).accentColor),),),
//       Itemm(header:Text(locale.whatIsMasterAcademy!,style: blackBoldTextStyle(context: context,fontSize: 13),),body: Text(locale.text!,style: blackBoldTextStyle(
//           fontSize: 12, height: 2, context:context,color: Theme.of(context).accentColor),),),
//       Itemm(header:Text(locale.whatIsMasterAcademy!,style: blackBoldTextStyle(context: context,fontSize: 13),),body: Text(locale.text!,style: blackBoldTextStyle(
//           fontSize: 12, height: 2, context:context,color: Theme.of(context).accentColor),),),
//       Itemm(header:Text(locale.whatIsMasterAcademy!,style: blackBoldTextStyle(context: context,fontSize: 13),),body: Text(locale.text!,style: blackBoldTextStyle(
//           fontSize: 12, height: 2, context:context,color: Theme.of(context).accentColor),),),
//
//     ];
//
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor.withOpacity(1),
//
//               boxShadow: [
//                 BoxShadow(
//                   color: Theme.of(context).canvasColor.withOpacity(0.01),
//                   spreadRadius: 1,
//                   blurRadius: 7,
//                   // offset: Offset(
//                   //     0, 0), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 17,right: 17,top: 15,bottom: 15),
//               child: GestureDetector(
//                 onTap: ()async{
//
//                   openwhatsapp();
//
//
//                 },
//
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(locale.toContactSupportAt!,style: blackBoldTextStyle(fontSize: 13, context: context),),
//
//                     Row(
//                       children: [
//                         Text("009647518107823",style: blackBoldTextStyle(fontSize: 13, context: context),),
//                         const SizedBox(width: 14,),
//                         SvgPicture.asset(
//                           "assets/svgs/whatsapp.svg",
//                         ),
//
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//            // Container(height: 1,width: double.infinity,color: Theme.of(context).cardColor,),
//
//            QuestionWidget(title: locale.generalQuestions!,),
//           SingleChildScrollView(//
//             child: ExpansionPanelList.radio(
//               initialOpenPanelValue: 0,
//               elevation: 0,
//               children: items.map((item)=>
//                   ExpansionPanelRadio(
//                       backgroundColor: Theme.of(context).cardColor.withOpacity(1),
//                       canTapOnHeader: true,
//
//                       value: item.header,
//                       headerBuilder: (context,isExpanded)=>ListTile(
//                         title:item.header
//                       ),
//                       body: ListTile(
//                         title:item.body
//                       )
//
//                   )
//
//
//               ).toList(),
//               expandedHeaderPadding: EdgeInsets.zero,
//             ),
//           ),
//           QuestionWidget(title: locale.pricesAndPayment!,),
//
//           SingleChildScrollView(//
//             child: ExpansionPanelList.radio(
//               initialOpenPanelValue: 0,
//               elevation: 0,
//               children: items.map((item)=>
//                   ExpansionPanelRadio(
//                       backgroundColor: Theme.of(context).cardColor.withOpacity(1),
//                       canTapOnHeader: true,
//
//                       value: item.header,
//                       headerBuilder: (context,isExpanded)=>ListTile(
//                           title:item.header
//                       ),
//                       body: ListTile(
//                           title:item.body
//                       )
//
//                   )
//
//
//               ).toList(),
//               expandedHeaderPadding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   openwhatsapp() async{
//     var whatsapp ="+9647518107823";
//     var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
//     var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("مرحبا سيدي ، لدي سؤال حول هذه الدورة")}";
//     if(Platform.isIOS){
//       // for iOS phone only
//       if( await canLaunch(whatappURL_ios)){
//         await launch(whatappURL_ios, forceSafariVC: false);
//       }else{
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("whatsapp no installed")));
//
//       }
//
//     }else{
//       // android , web
//       if( await canLaunch(whatsappURl_android)){
//         await launch(whatsappURl_android);
//       }else{
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: const Text("whatsapp no installed")));
//
//       }
//
//
//     }
//
//   }
// }
