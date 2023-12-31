import 'package:flutter/material.dart';

import '../../Theme/style.dart';

class QuestionNumber extends StatelessWidget {
  const QuestionNumber({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: blackBoldTextStyle(
            context: context,
            fontSize: 15,
            color: Theme.of(context).scaffoldBackgroundColor),
      ),
    );
  }
}