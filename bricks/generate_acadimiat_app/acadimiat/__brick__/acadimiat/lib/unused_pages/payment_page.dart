// import 'package:acadmiat/core/widgets/custom_botton.dart';
// import 'package:acadmiat/success_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
// import 'add_new_card_page.dart';
// import 'core/globals.dart';
// import 'core/widgets/app_bar_widget.dart';
//
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'features/my_courses_feature/presentation/pages/my_course/course_page.dart';
//
// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     Size size =MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: appBarWidget(locale.paying!,context,true,null,null),
//       body: SafeArea(
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             Container(
//               height: size.height,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 17,right: 17,top:14),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//
//
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 10),
//                         child: Text(locale.orderDetails!,style: blackBoldTextStyle(context: context,fontSize: 14),),
//                       ),
//                       Container(
//                         height: 86*5,
//
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Theme.of(context).cardColor,
//                         ),
//                         child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                             itemCount: 5,
//                             itemBuilder: (context,index){return
//                           Padding(
//                             padding: const EdgeInsets.only(left: 12,right: 12),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//
//
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(top: 12,),
//                                           child: SizedBox(
//                                             width: 60,
//                                             height: 60,
//                                             child: ClipRRect(
//                                               borderRadius:  BorderRadius.circular(10),
//                                               child: CachedNetworkImage(
//                                                   imageUrl: "https://i.redd.it/70zvc38gfxv71.jpg",
//                                                   imageBuilder: (context, imageProvider) =>
//                                                       Container(
//
//                                                         decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                             image: imageProvider,
//                                                             fit: BoxFit.fill,
//                                                             // colorFilter:
//                                                             // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//                                                           ),
//                                                         ),
//                                                       ),
//                                                   placeholder: (context, url) => Center(
//                                                     child: Shimmer.fromColors(
//                                                       baseColor: Colors.grey.shade300,
//                                                       highlightColor: Colors.grey.shade100,
//                                                       child: Container(
//                                                         color: Colors.white,
//                                                         child: const SizedBox(
//                                                           width: 50.0,
//                                                           height: 50.0,
//                                                           child:
//                                                           CircularProgressIndicator(
//                                                             color: Color.fromRGBO(78, 43, 121, 1),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   errorWidget: (context, url, error) =>
//                                                       Icon(Icons.network_cell_outlined)),
//                                             ),
//
//                                           ),
//                                         ),
//                                         SizedBox(width: 10),
//                                         Container(
//                                             width:  size.width*0.53,
//                                             child: Text(locale.markerDrawingBasics!,style: blackBoldTextStyle(context: context,fontSize: 11),)),
//                                       ],
//                                     ),
//
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 0),
//                                       child: Text("\$190",style: blackBoldTextStyle(context: context, fontSize: 18)),
//                                     ),
//
//                                   ],
//                                 ),
//                                 if(index!=2)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top:12),
//                                   child: Container(width: double.infinity,
//                                     height: 0.5,
//                                     color: Colors.grey,),
//                                 )
//                               ],
//                             ),
//                           );
//                         })
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 26),
//                         child: Row(
//                           children: [
//                             Text(locale.paymentMeans!,style: blackBoldTextStyle(context: context,fontSize: 14),),
//                           ],
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top:13,bottom: 230),
//                         child: Container(
//                           width: double.infinity,
//                           height: 168,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).cardColor,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child:
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top:20,left: 27,right: 27,),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 15,
//                                       width: 170,
//                                       // color: Colors.red,
//                                       child: SvgPicture.asset(
//                                         "assets/svgs/payment.svg",
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//
//                               Padding(
//                                 padding: const EdgeInsets.only(top:14,left: 27,right: 27,),
//                                 child: Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       "assets/svgs/vuesax-outline-security-safe.svg",
//                                     ),
//                                     SizedBox(width: 3,),
//                                     Text(locale.keepPaymentInformationConfidential!,style: blackBoldTextStyle(context: context,fontSize: 12),)
//                                   ],
//                                 ),
//                               ),
//
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 27,right: 27,top: 30),
//                                 child: GestureDetector(
//                                   onTap: (){
//
//
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => const AddNewCardPage()),
//                                     );
//                                   },
//                                   child: Container(
//                                     height: 44,
//
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       color: Color.fromRGBO(236, 82, 82, 0.15),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(locale.addANewCard!,style: blackBoldTextStyle(context: context,fontSize: 14,color:Color.fromRGBO(236, 82, 82, 1) ),),
//
//                                   ),
//                                 ),
//                               ),
//
//
//
//                             ],
//                           ),
//                         ),
//                       ),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(height: 215,color: Theme.of(context).cardColor,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 17,right: 17,top: 18),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(locale.price!,style: blackRegularTextStyle(fontSize: 13),),
//                       Text("250\$",style: blackBoldTextStyle(context: context,fontSize: 16),),
//                     ],
//                   ),
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(top:12,bottom: 13),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(locale.discountAmount!,style: blackRegularTextStyle(fontSize: 13),),
//                         Text("-120\$",style: blackBoldTextStyle(context: context,fontSize: 16,color: Colors.red),),
//                       ],
//                     ),
//                   ),
//                   Text("-------------------------------------------------------------------------------------------------------------------------------",
//                     maxLines: 1,style: TextStyle(
//                         color: Colors.grey.withOpacity(0.5)
//                     ),),
//                   Padding(
//                     padding: const EdgeInsets.only(top:12.5,bottom: 16),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(locale.totalRequest!,style: blackBoldTextStyle(context: context,fontSize: 13  ),),
//                           Text("150\$",style: blackBoldTextStyle(context: context,fontSize: 20),),
//                         ]
//                     ),
//                   ),
//
//
//                   // Container(
//                   //   height: 44,
//                   //   alignment: Alignment.center,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(22),
//                   //     color: Color.fromRGBO(236, 82, 82, 1),
//                   //   ),
//                   //   child: Text("تأكيد الدفع  150\$",style: blackBoldTextStyle(context: context,fontSize: 13,color: Colors.white),),
//                   //
//                   // ),
//
//                   Hero(
//                     tag: "PaymentPageBTN",
//                     child: Material(
//                       color: Theme.of(context).cardColor,
//                       child: CustomButton(title: "${locale.confirmPayment!}  150\$", onTap: (){
//
//                         showDialog(
//                             barrierColor: Color.fromRGBO(255, 255, 255, 0),
//                             context: context,
//                             builder: (BuildContext context) =>
//                              SuccessBox(
//                               title: locale.sendProcessCompletedSuccessfully!,
//                               body1: '',
//                               body2: '${locale.movementNumber!}25634',
//                             )).then((valueFromDialog) {
//                           if (valueFromDialog != null) {
//                             Navigator.pop(context);
//                           }
//                           if(valueFromDialog == 200){
//                              goTo(context, (context) =>  CoursePage(
//                                courseId: 0,userId: userId(), imageUrl: '',
//                              ));
//                           }
//                         });
//
//                       }),
//                     ),
//                   )
//
//
//                 ],
//               ),
//             ),
//
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
