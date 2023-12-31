// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import '../core/widgets/app_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'Locale/locale.dart';
// import 'Theme/style.dart';
//
// import 'core/globals.dart';
// import 'core/widgets/app_bar_widget.dart';
// import 'launch_page.dart';
//
// class ThemeAppPage extends StatefulWidget {
//   const ThemeAppPage({Key? key}) : super(key: key);
//
//   @override
//   State<ThemeAppPage> createState() => _ThemeAppPageState();
// }
//
// class _ThemeAppPageState extends State<ThemeAppPage> {
//   var val;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     var locale = AppLocalizations.of(context)!;
//
//     //
//     // if(LaunchPage.themeNotifier.value == ThemeMode.light){
//     // val=1;
//     // }else{
//     //   val=0;
//     // }
//
//
//     if (kDebugMode) {
//       print(globalSH.getString("ThemeMode"));
//     }
//
//     if( globalSH.getString("ThemeMode")==""){
//       val=0;
//     }else if(globalSH.getString("ThemeMode")=="dark"){
//       val=1;
//     }else if(globalSH.getString("ThemeMode")=="light"){
//       val=2;
//     }
//     return Scaffold(
//       appBar: appBarWidget(locale.darkMode!, context, true, null, null),
//       body: SizedBox(
//         height: size.height,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 17, right: 17, top: 20, bottom: 8),
//                 child: Text(
//                   locale.changeApplicationMode!,
//                   style: blackBoldTextStyle(context: context, fontSize: 14),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     val = 0;
//                     LaunchPage.themeNotifier.value = ThemeMode.system;
//                     globalSH.setString("ThemeMode", "");
//                   });
//                 },
//                 child: Container(
//                   color: Theme.of(context)
//                       .scaffoldBackgroundColor
//                       .withOpacity(0.1),
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Radio(
//                         fillColor: MaterialStateColor.resolveWith(
//                             (states) => Theme.of(context).primaryColor),
//                         value: 0,
//                         groupValue: val,
//                         onChanged: (value) {
//                           setState(() {
//                             val = value;
//                             LaunchPage.themeNotifier.value = ThemeMode.system;
//                             globalSH.setString("ThemeMode", "");
//                           });
//                         },
//                         activeColor: Theme.of(context).primaryColor,
//                       ),
//                       Text(
//                        locale.systemDefault!,
//                         style:
//                             blackBoldTextStyle(context: context, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     val = 1;
//                     LaunchPage.themeNotifier.value = ThemeMode.dark;
//                     globalSH.setString("ThemeMode", "dark");
//                   });
//                 },
//                 child: Container(
//                   color: Theme.of(context)
//                       .scaffoldBackgroundColor
//                       .withOpacity(0.1),
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Radio(
//                         fillColor: MaterialStateColor.resolveWith(
//                             (states) => Theme.of(context).primaryColor),
//                         value: 1,
//                         groupValue: val,
//                         onChanged: (value) {
//                           setState(() {
//                             val = value;
//
//                             LaunchPage.themeNotifier.value = ThemeMode.dark;
//                             globalSH.setString("ThemeMode", "dark");
//                           });
//                         },
//                         activeColor: Theme.of(context).primaryColor,
//                       ),
//                       Text(
//                         locale.run!,
//                         style:
//                             blackBoldTextStyle(context: context, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     val = 2;
//
//                     LaunchPage.themeNotifier.value = ThemeMode.light;
//                     globalSH.setString("ThemeMode", "light");
//                   });
//                 },
//                 child: Container(
//                   color: Theme.of(context)
//                       .scaffoldBackgroundColor
//                       .withOpacity(0.1),
//                   child: Row(
//                     children: [
//                       Radio(
//                         fillColor: MaterialStateColor.resolveWith(
//                             (states) => Theme.of(context).primaryColor),
//                         value: 2,
//                         groupValue: val,
//                         onChanged: (value) {
//                           setState(() {
//                             val = value;
//
//                             LaunchPage.themeNotifier.value = ThemeMode.light;
//                             globalSH.setString("ThemeMode", "light");
//                           });
//                         },
//                         activeColor: Theme.of(context).primaryColor,
//                       ),
//                       Text(
//                         locale.off!,
//                         style:
//                             blackBoldTextStyle(context: context, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
