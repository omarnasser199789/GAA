//
// import 'package:flutter/material.dart';
//
// import 'Theme/style.dart';
// import 'core/globals.dart';
// import 'features/my_courses_feature/data/models/my_lecture_model.dart';
//
// class FileCell extends StatelessWidget {
//   const FileCell({Key? key,required this.onTap,required this.file,
//     required this.progress,
//     required this.index,required this.selectedItem,required this.loadingFile}) : super(key: key);
//
//   final Function () onTap ;
//   final FileClass file;
//   final double progress;
//   final int index;
//   final int selectedItem;
//   final bool loadingFile;
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.only(
//           left: 5, right: 5, top: 10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Theme
//                   .of(context)
//                   .cardColor,
//               borderRadius:
//               BorderRadius.circular(5),
//               border: Border.all(
//                   color: Theme
//                       .of(context)
//                       .cardColor,
//                   width: 1)),
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 bottom: 13,
//                 top: 13,
//                 left: 17,
//                 right: 17),
//             child: Row(//
//               children: [
//                 getIcon(fileName:file.fileName),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 SizedBox(
//                   // color: Colors.red,
//                   width: size.width - 120,
//                   child: Text(file.fileName,
//                     style:
//                     blackBoldTextStyle(
//                         context:
//                         context,
//                         fontSize: 11),
//                   ),
//                 ),
//
//                 ValueListenableBuilder(
//                     valueListenable:
//                     counterNotifier,
//                     builder: (context,
//                         value, _) {
//                       // if (index == selectedItem && progress != 0) {
//                         return Stack(
//                           alignment:
//                           Alignment
//                               .center,
//                           children: [
//                             Center(
//                               child:
//                               SizedBox(
//                                 width: 30,
//                                 height: 30,
//                                 child:
//                                 CircularProgressIndicator(
//                                   strokeWidth:
//                                   3,
//                                   value:
//                                   progress,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               (progress *
//                                   100)
//                                   .toString()
//                                   .split(
//                                   ".")[0],
//                               style: const TextStyle(
//                                   fontSize:
//                                   12),
//                             ),
//                           ],
//                         );
//                       // }
//                       // else
//                       // if (loadingFile &&
//                       //     index == selectedItem) {
//                       //   return SizedBox(
//                       //     width: 30,
//                       //     height: 30,
//                       //     child:
//                       //     CircularProgressIndicator(
//                       //       backgroundColor:
//                       //       Colors.grey,
//                       //       color:
//                       //       Theme
//                       //           .of(context)
//                       //           .primaryColor,
//                       //     ),
//                       //   );
//                       // } else {
//                       //   return Container();
//                       // }
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
