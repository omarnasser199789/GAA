// import 'package:acadmiat/privacy_policy_page.dart';
// import 'package:acadmiat/select_custom_theme_page.dart';
// import 'package:acadmiat/select_language_page.dart';
// import 'package:acadmiat/terms_and_conditions_page.dart';
// import 'package:acadmiat/theme_app_page.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../Locale/locale.dart';
// import '../../../../core/globals.dart';
// import '../../../../core/widgets/app_bar_widget.dart';
// import 'my_info_page.dart';
// import '../widgets/option_widget.dart';
//
// class ApplicationSettingsPage extends StatefulWidget {
//   const ApplicationSettingsPage({Key? key}) : super(key: key);
//
//   @override
//   State<ApplicationSettingsPage> createState() => _ApplicationSettingsPageState();
// }
//
// class _ApplicationSettingsPageState extends State<ApplicationSettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar:appBarWidget(locale.applicationSettings!,context,true,null,null),
//       body: Padding(
//         padding: defaultPadding,
//         child: Column(children: [
//
//           Option(text: locale.language!, onTap: () {
//             goTo(context,(context)=> const SelectLanguagePage());
//           },),
//
//           // Option(text:locale.nightMode!, onTap: () {
//           //
//           //   goTo(context,(context)=> const ThemeAppPage());
//           // },),
//           // Option(text: locale.privacyPolicy!, onTap: () {
//           //
//           //
//           //   goTo(context,(context)=> const PrivacyPolicyPage());
//           // },),
//           //
//           // Option(text: locale.termsAndConditions!, onTap: () {
//           //
//           //   goTo(context,(context)=> const TermsAndConditionsPage());
//           // },),
//
//           // Option(text: "ثيم التطبيق", onTap: () {
//           //
//           //   goTo(context,(context)=>  SelectCustomThemePage());
//           // },),
//
//         ],),
//       ),
//     );
//   }
// }
