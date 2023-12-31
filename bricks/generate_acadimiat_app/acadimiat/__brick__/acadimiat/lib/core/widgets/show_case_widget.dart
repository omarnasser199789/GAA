import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../globals.dart';
class ShowCaseView extends StatelessWidget {
  const ShowCaseView({Key? key,

    required this.globalKey,
    required this.child,
    required this.description,
    required this.title,
    required this.enable,
  }) : super(key: key);

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final bool enable;


  @override
  Widget build(BuildContext context) {




    return (enable==true)?
    Showcase(
      key: globalKey,
      title: title,
      description: description,
      titleTextStyle:blackBoldTextStyle(fontSize: 15, context: context,color: Colors.black),
      descTextStyle: blackBoldTextStyle(fontSize: 12, context: context,color: Colors.black),
      child: child):child;
  }
}
