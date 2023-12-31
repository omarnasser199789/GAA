// import 'package:acadmiat/features/profile_feature/presentation/pages/downloads_page_folder/widgets/download_quality_widget.dart';
//
// import '../../../../../../core/widgets/app_bar_widget.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../Locale/locale.dart';
// import '../../../../../Theme/style.dart';
// import '../../../../../add_new_card_page.dart';
// import '../../../../../core/globals.dart';
//
// import '../../../../../core/widgets/app_bar_widget.dart';
// import '../../../../../core/widgets/custom_botton.dart';
//
// class DownloadsPage extends StatefulWidget {
//   const DownloadsPage({Key? key}) : super(key: key);
//
//   @override
//   State<DownloadsPage> createState() => _DownloadsPageState();
// }
//
// class _DownloadsPageState extends State<DownloadsPage> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar:appBarWidget(locale.downloads!,context,true,null,null),
//       body: Padding(
//         padding:defaultPadding,
//         child: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                     onTap: (){
//                       showModalBottomSheet(
//                           context: context,
//                           backgroundColor: Colors.transparent,
//                           isScrollControlled: true,
//                           builder: (context) {
//                             return DownloadQualityWidget();
//                           });
//                     },
//                     child: Column(
//                       children: [
//                         Text(locale.downloadQuality!,style: blackBoldTextStyle(context: context,fontSize: 13),),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Text("${locale.medium!} 540P ",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),),
//                         ),
//                       ],
//                     )),
//
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40),
//                   child: Text(locale.deleteAllDownloads!,style: blackBoldTextStyle(context: context,fontSize: 13),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Text("51M ${locale.usedFrom!} 100G ${locale.free!}",style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),),
//                 ),
//
//
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
