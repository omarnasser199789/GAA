// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
// import 'core/widgets/app_bar_widget.dart';
//
// import 'core/widgets/custom_botton.dart';
// import 'core/widgets/custom_text_field.dart';
// // import 'package:flutter_credit_card/credit_card_brand.dart';
// // import 'package:flutter_credit_card/flutter_credit_card.dart';
// class AddNewCardPage extends StatefulWidget {
//   const AddNewCardPage({Key? key}) : super(key: key);
//
//   @override
//   State<AddNewCardPage> createState() => _AddNewCardPageState();
// }
//
// class _AddNewCardPageState extends State<AddNewCardPage> {
//   bool state = true;
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     border = OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.grey.withOpacity(0.7),
//         width: 2.0,
//       ),
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar:appBarWidget(locale.addANewCard!,context,true,null,null),
//       resizeToAvoidBottomInset: false,
//       body:  Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: size.height,
//             child: SingleChildScrollView(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//                   Padding(
//                     padding: const EdgeInsets.only(top:20,left: 17,right: 17,),
//                     child: Container(
//
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).canvasColor.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//
//
//                           height: 20,
//                           width: 190,
//                           // color: Colors.red,
//                           child: SvgPicture.asset(
//                             "assets/svgs/payment.svg",
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                   Padding(
//                     padding:  EdgeInsets.only(top:14,left: size.width*0.2,right:  size.width*0.2,),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           "assets/svgs/vuesax-outline-security-safe.svg",
//                         ),
//                         SizedBox(width: 3,),
//                         Text(locale.keepPaymentInformationConfidential!,style: blackBoldTextStyle(context: context,fontSize: 12),)
//                       ],
//                     ),
//                   ),
//
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(top:40,left: 17,right: 17),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top:26,left: 25,right: 25),
//                         child: Column(
//                           children: [
//
//                             CustomTextField(title: locale.cardNumber!, hint: '0000 0000 0000 0000', onTap: () {  },),
//                             CustomTextField(title: locale.cardHolderName!, hint:locale.enterName!, onTap: () {  },),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//
//                                 CustomTextField(title: locale.cardNumber!, hint: '0000 0000 0000 0000',width: size.width*0.37, onTap: () {  },),
//                                 CustomTextField(title: locale.cardHolderName!, hint: locale.enterName!,width: size.width*0.37, onTap: () {  },),
//
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top:30,bottom: 30),
//                               child: Row(
//                                 children: [
//                                   CupertinoSwitch(
//                                     value:state,
//                                     onChanged: (value){
//                                       state = value;
//                                       setState(() {
//
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(width: 20,),
//                                   Text(locale.saveAsDefaultCard!,style: blackBoldTextStyle(context: context,fontSize: 12),)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//            Container(
//           color:Theme.of(context).cardColor,
//           child: SafeArea(
//             child: Container(
//                 height: 83,
//                 width: size.width,
//                 color: Theme.of(context).cardColor,
//                 child:Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 40,right: 40),
//                       child: CustomButton(
//                         onTap: () {
//                           if (formKey.currentState!.validate()) {
//                             print('valid!');
//                           } else {
//                             print('invalid!');
//                           }
//
//                           // Navigator.pop(context);
//
//                         }, title: locale.cardVerification!,),
//                     ),
//                   ],
//                 )
//             ),
//           ),
//         ),
//         ],
//       ),
//
//     );
//
//   }
//   // void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//   //   setState(() {
//   //     cardNumber = creditCardModel!.cardNumber;
//   //     expiryDate = creditCardModel.expiryDate;
//   //     cardHolderName = creditCardModel.cardHolderName;
//   //     cvvCode = creditCardModel.cvvCode;
//   //     isCvvFocused = creditCardModel.isCvvFocused;
//   //   });
//   // }
// }
//
//
//
//
