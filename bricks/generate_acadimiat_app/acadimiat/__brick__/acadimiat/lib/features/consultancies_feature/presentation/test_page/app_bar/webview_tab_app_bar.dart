// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/browser_model.dart';
// import '../models/webview_model.dart';
// import '../webview_tab.dart';
//
// class WebViewTabAppBar extends StatefulWidget {
//
//
//   const WebViewTabAppBar({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewTabAppBar> createState() => _WebViewTabAppBarState();
// }
//
// class _WebViewTabAppBarState extends State<WebViewTabAppBar>
//     with SingleTickerProviderStateMixin {
//
//   bool firstOne=true;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Selector<WebViewModel, WebUri?>(
//         selector: (context, webViewModel) => webViewModel.url,
//         builder: (context, url, child) {
//
//           return Selector<WebViewModel, bool>(
//               selector: (context, webViewModel) => webViewModel.isIncognitoMode,
//               builder: (context, isIncognitoMode, child) {
//
//
//
//
//                 if(firstOne){
//                   firstOne=false;
//                   Future.delayed(const Duration(milliseconds: 1000), () {
//                     addNewTab(url: WebUri("https://conference.emasteryacademy.com/bigbluebutton/api/join?fullName=%D9%86%D9%88%D8%B1%20%D8%A7%D9%84%D8%AF%D9%8A%D9%86%20%D9%8A%D8%A7%D8%B3%D9%8A%D9%86&meetingID=WHO9FH00C1&password=5VA4BM5ZLR&checksum=f8c4068e4cf495bad33c891617e31fe296c36ecf"
//                     ));
//                   });
//                 }
//
//
//               return Container();
//
//               });
//         });
//
//
//   }
//
//
//
//
//
//
// }
