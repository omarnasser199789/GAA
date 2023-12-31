// import 'package:acadmiat/core/classes/constants.dart';
// import 'package:acadmiat/core/widgets/app_bar_widget.dart';
// import 'package:acadmiat/features/authentication_feature/presentation/pages/login_page.dart';
// import 'package:acadmiat/features/cart_feature/domain/use_cases/enable_courses_usecase.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// import '../../Locale/locale.dart';
// import '../../features/cart_feature/presentation/bloc/my_cart_bloc.dart';
// import '../../features/cart_feature/presentation/bloc/my_cart_state.dart';
// import '../../features/cart_feature/presentation/bloc/my_courses_event.dart';
// import '../../features/cart_feature/presentation/success_payment_page.dart';
// import '../../injection_container.dart';
// import '../functions.dart';
// import '../globals.dart';
// import 'custom_botton.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PaymentButton extends StatelessWidget {
//    PaymentButton({Key? key,required  this.price,this.showPrice,this.width,required this.cartList}) : super(key: key);
//
//   final double price;
//   final bool ? showPrice;
//   final double ? width;
//   final List<Cart> cartList;
//
//   Map<String, dynamic> paymentIntent = {};
//    // SECRET_KEY="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";
//
//
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     Size size = MediaQuery.of(context).size;
//
//     return  BlocProvider(
//         create: (BuildContext context) => sl<MyCartBloc>(),
//         child:
//         BlocBuilder<MyCartBloc, MyCartState>(builder: (context, state) {
//           if (kDebugMode) {
//             print("PaymentButtonState:$state");
//           }
//           return CustomButton(
//             title:(showPrice!=null)?locale.buyNow!: locale.buyNow!+"   $price\$",
//             fontSize: 15,
//             onTap: ()  {
//               ///We only allow the purchase for the user who has logged in
//               if(isLoggedIn()) {
//                 /// If the cart price is 0, this means that the course is free, and there is no payment process.
//                 if(price==0){
//                   goTo(context, (context) =>  SuccessPaymentPage(
//                     // invoiceId: "", cartList: cartList,
//                   ));
//                 }
//                 else{
//                   try {
//                     makePayment(total: price, context: context);
//                   } catch (e) {
//                     if (kDebugMode) {
//                       print(e);
//                     }
//                   }
//                 }
//
//               }
//               ///If user not register yet, bring user to login page.
//               else{
//                 goTo(context, (context) => const LoginPage(from: FromXtoLogin.cartPage,));
//               }
//
//             },
//             width:(width==null) ?size.width * 0.65:width,
//           );
//         }));
//
//
//
//
//   }
//
//   Future<void> makePayment({required double total , required BuildContext context}) async {
//     try {
//       paymentIntent = await createPaymentIntent(total, 'USD');
//
//       //Payment Sheet
//       // await Stripe.instance.initPaymentSheet(
//       //     paymentSheetParameters: SetupPaymentSheetParameters(
//       //       appearance: PaymentSheetAppearance(colors: PaymentSheetAppearanceColors(
//       //         primary: Theme.of(context).primaryColor,
//       //       )),
//       //       paymentIntentClientSecret: paymentIntent['client_secret'],
//       //       applePay: const PaymentSheetApplePay(merchantCountryCode: '+971',),
//       //       // applePay: true,
//       //       // googlePay: true,
//       //       merchantDisplayName: 'Mastery Academy',
//       //     )).then((value){});
//
//       ///now finally display payment sheet
//       displayPaymentSheet(context);
//     } catch (e, s) {
//       if (kDebugMode) {
//         print('exception:$e$s');
//       }
//     }
//   }
//
//   displayPaymentSheet(context) async {
//
//     // try {
//     //  // await Stripe.instance.presentPaymentSheet(
//     //  //
//     //  //  ).then((value){
//     //  //    BlocProvider.of<MyCartBloc>(context)
//     //  //        .add(DeleteAllProductsFromCart());
//     //  //
//     //  //    String invoiceId=(paymentIntent["id"]!=null)?paymentIntent["id"]:"";
//     //  //    goTo(context, (context) =>  SuccessPaymentPage(
//     //  //      invoiceId: invoiceId, cartList: cartList,
//     //  //    ));
//     //  //
//     //  //    paymentIntent = {};
//     //  //
//     //  //  }).onError((error, stackTrace){
//     //  //    if (kDebugMode) {
//     //  //      print('Error is:--->$error $stackTrace');
//     //  //    }
//     //  //  });
//     //
//     //
//     // } on StripeException catch (e) {
//     //   if (kDebugMode) {
//     //     print('Error is:---> $e');
//     //   }
//     //   showDialog(
//     //       context: context,
//     //       builder: (_) => const AlertDialog(
//     //         content: Text("Cancelled "),
//     //       ));
//     // } catch (e) {
//     //   if (kDebugMode) {
//     //     print('$e');
//     //   }
//     // }
//   }
//
//
//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(double amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount':calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $SECRET_KEY',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       // ignore: avoid_print
//       print('Payment Intent Body->>> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       // ignore: avoid_print
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(double amount) {
//     final calculatedAmount = (int.parse("${(amount*100).round()}")) ;
//     return calculatedAmount.toString();
//   }
//
//   double calculateTheNewPrice({required double amount, required double newPrice, required double oldPrice}) {
//
//     // if (kDebugMode) {
//     //   print("oldPrice:$oldPrice");
//     //   print("newPrice:$newPrice");
//     //   print("amount:$amount");
//     //   print(oldPrice-(amount/100*oldPrice));
//     // }
//
//     if(newPrice!=0){
//       double nm=newPrice-(amount/100*newPrice);
//       return  double.parse(nm.toStringAsFixed(2));
//     }else{
//
//       double nm=oldPrice-(amount/100*oldPrice);
//       return  double.parse(nm.toStringAsFixed(2));
//
//     }
//
//   }
// }
