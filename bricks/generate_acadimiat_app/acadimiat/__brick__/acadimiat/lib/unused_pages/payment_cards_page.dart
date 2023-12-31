// import '../core/widgets/app_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
// import 'core/globals.dart';
//
//
//
// class PaymentCardsPage extends StatefulWidget {
//   const PaymentCardsPage({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentCardsPage> createState() => _PaymentCardsPageState();
// }
//
// class _PaymentCardsPageState extends State<PaymentCardsPage> {
//   var val;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar:appBarWidget(locale.paymentMeans!,context,true,null,null),
//       body: Padding(
//         padding:defaultPadding,
//         child: Column(
//           children: [
//
//
//            Container(
//              height: 500,
//              child: ListView.builder(
//                  itemCount: 2,
//                  padding: EdgeInsets.zero,
//                  itemBuilder: (context,index){
//
//                return  Padding(
//                  padding: const EdgeInsets.only(top: 15),
//                  child: Container(
//                    // height: 122,
//                    width: double.infinity,
//                    decoration: BoxDecoration(
//                        color:Theme.of(context).cardColor,
//                        borderRadius: BorderRadius.circular(15)
//                    ),
//                    child: Padding(
//                      padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: [
//
//
//
//
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              SvgPicture.asset(
//                                "assets/svgs/mastercard.svg",
//                              ),
//
//                              Text("amjad t.",style: blackBoldTextStyle(context: context,fontSize: 13),),
//
//                            ],
//                          ),
//
//                          Padding(
//                            padding: const EdgeInsets.only(top: 5),
//                            child: Text("2563 2563 2563 xxxx",style: blackBoldTextStyle(context: context,fontSize: 13),),
//                          ),
//
//                          Padding(
//                            padding: const EdgeInsets.only(top: 5,bottom: 10),
//                            child: Container(
//                              // color: Colors.red,
//                              width:size.width ,
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Row(
//                                    children: [
//                                      Radio(
//                                        fillColor: MaterialStateColor.resolveWith((states) => activeColor),
//                                        visualDensity: const VisualDensity(
//                                            horizontal: VisualDensity.minimumDensity,
//                                            vertical: VisualDensity.minimumDensity),
//                                        value: index,
//                                        groupValue: val,
//                                        onChanged: (value) {
//                                          setState(() {
//                                            val = value;
//
//                                          });
//                                        },
//                                        activeColor: Theme.of(context).primaryColor,
//                                      ),
//                                      if(index==val)
//                                        Text(locale.virtualPaymentCard!,style: blackBoldTextStyle(context: context,fontSize: 13),),
//                                      if(index!=val)
//                                      Padding(
//                                        padding: const EdgeInsets.only(left: 20,right: 20),
//                                        child: SvgPicture.asset(
//                                          "assets/svgs/deleteIcon.svg",
//                                          width: 20,
//                                        ),
//                                      ),
//
//                                    ],
//                                  ),
//
//
//
//
//                                  Text("expiry:05/24",style: blackBoldTextStyle(context: context,fontSize: 13),),
//
//                                ],
//                              ),
//                            ),
//                          ),
//
//
//
//
//
//                        ],
//                      ),
//                    ),
//                  ),
//                );
//
//              }),
//            )
//
//           ],
//         ),
//       ),
//     );
//   }
// }
