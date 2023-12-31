import 'package:flutter/material.dart';

import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../Theme/style.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../core/globals.dart';


class NestedHeader extends StatefulWidget {
  const NestedHeader({Key? key, this.startHere,
    // required this.name,
    required this.lessonNumber}) : super(key: key);
  final bool ? startHere;
  // final String  name;
  final int lessonNumber;

  @override
  State<NestedHeader> createState() => _NestedHeaderState();
}

class _NestedHeaderState extends State<NestedHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
         lessonsNumber(widget.lessonNumber)+":  ",
          style: blackBoldTextStyle(context: context,
              fontSize: 11, color:   hintTextColor),
        ),

      ],
    );
  }
}