// import 'package:acadmiat/core/widgets/app_bar_widget.dart';
// import '../core/widgets/app_bar_widget.dart';
// import 'package:flutter/material.dart';
//
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
// import 'core/globals.dart';
//
// class PurchaseInvoicePage extends StatefulWidget {
//   const PurchaseInvoicePage({Key? key}) : super(key: key);
//
//   @override
//   State<PurchaseInvoicePage> createState() => _PurchaseInvoicePageState();
// }
//
// class _PurchaseInvoicePageState extends State<PurchaseInvoicePage> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar:appBarWidget(locale.purchaseInvoice!,context,true,null,null),
//       body: Padding(
//         padding: defaultPadding,
//         child:            Padding(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: ListView.builder(
//               itemCount: 7,
//               padding: EdgeInsets.zero,
//               itemBuilder: (context,index){return   Container(
//                 // color: Colors.red,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 17,),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 18,right: 18),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 17),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(locale.dialNumber!,style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),),
//                                     SizedBox(width: 20,),
//
//                                     Text("#order2",style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),),
//                                   ],
//                                 ),
//                                 Text("25.06.2022 10:00",style: blackBoldTextStyle(context: context,fontSize: 12,color:   hintTextColor),)
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 18),
//                             child: Text(locale.personalAdvice!,style: blackBoldTextStyle(context: context,fontSize: 10,color:   hintTextColor),),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5),
//                             child: Text(locale.basicsOfMarkerDrawing!,style: blackBoldTextStyle(context: context,fontSize: 10),),
//                           ),
//
//                           Padding(
//                             padding: const EdgeInsets.only(top:23,bottom: 28),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//
//                                 if(index%2!=0)
//                                 Container(
//
//                                     decoration: BoxDecoration(
//                                         color:  Color.fromRGBO(226, 155, 91, 0.1),
//                                         borderRadius: BorderRadius.circular(15)
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//                                       child: Text(locale.paid!,style: blackBoldTextStyle(context: context,fontSize: 11,color: Color.fromRGBO(226, 155, 91, 1)),),
//                                     )),
//
//                                 if(index%2==0)
//                                   Container(
//
//                                       decoration: BoxDecoration(
//                                           color:  percentIndicatorColor.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(15)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//                                         child: Text(locale.free!,style: blackBoldTextStyle(context: context,fontSize: 11,color:percentIndicatorColor),),
//                                       )),
//
//                                 Row(
//                                   children: [
//                                     Text("visa 2563",style: blackBoldTextStyle(context: context,fontSize: 11),),
//                                     SizedBox(width: 10,),
//                                     Text("700\$",style: blackBoldTextStyle(context: context,fontSize: 14),),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//
//
//
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );}),
//         ),
//       ),
//     );
//   }
// }
