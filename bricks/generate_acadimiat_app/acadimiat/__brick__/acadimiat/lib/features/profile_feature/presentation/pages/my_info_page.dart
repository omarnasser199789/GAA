// import 'package:acadmiat/features/profile_feature/presentation/widgets/option_widget.dart';
//
// import '../../../../../core/widgets/app_bar_widget.dart';
// import 'package:acadmiat/payment_cards_page.dart';
// import 'package:acadmiat/purchase_invoice_page.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../Locale/locale.dart';
// import '../../../../Theme/style.dart';
// import '../../../../core/globals.dart';
// import '../../../../core/widgets/app_bar_widget.dart';
// import 'profile_personly_folder/creare_new_password_page.dart';
// import 'profile_personly_folder/delete_account_page.dart';
// import 'profile_personly_folder/edit_personal_info_page.dart';
//
// class MyInfoPage extends StatefulWidget {
//   const MyInfoPage({Key? key}) : super(key: key);
//
//   @override
//   State<MyInfoPage> createState() => _MyInfoPageState();
// }
//
// class _MyInfoPageState extends State<MyInfoPage> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar:appBarWidget(locale.myInfo!,context,true,null,null),
//       body: Padding(
//         padding: defaultPadding,
//         child: Column(
//           children: [
//
//             Option(text: locale.paymentCards!, onTap: () {
//               goTo(context,(context)=> const PaymentCardsPage());
//             },),
//
//             Option(text: locale.purchaseInvoice!, onTap: () {
//               goTo(context,(context)=> const PurchaseInvoicePage());
//             },),
//
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
