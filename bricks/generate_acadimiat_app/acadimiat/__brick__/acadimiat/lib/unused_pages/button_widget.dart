// import 'package:flutter/material.dart';
//
// import 'Theme/style.dart';
//
//
// class ButtonWidget extends StatefulWidget {
//   const ButtonWidget({Key? key,required this.title,required this.width}) : super(key: key);
//
//   final String title;
//   final double width;
//   @override
//   State<ButtonWidget> createState() => _ButtonWidgetState();
// }
//
// class _ButtonWidgetState extends State<ButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       width: widget.width,
//       height: 22,
//       decoration: BoxDecoration(
//         color:  const Color.fromRGBO(6, 177, 229, 1),
//         borderRadius: BorderRadius.circular(4),
//
//       ),
//       child:  Center(child: Text(widget.title,style: whiteBoldTextStyle(11))),
//
//     );
//   }
// }
