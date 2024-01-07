import 'package:flutter/material.dart';
import '../../../../../../../../Theme/style.dart';
import '../../../../../../../../core/functions.dart';

class NestedHeader extends StatefulWidget {
  const NestedHeader({super.key, this.startHere,
    required this.lessonNumber});
  final bool ? startHere;
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
         "${lessonsNumber(widget.lessonNumber)}:  ",
          style: blackBoldTextStyle(context: context,
              fontSize: 11, color:   hintTextColor),
        ),
      ],
    );
  }
}