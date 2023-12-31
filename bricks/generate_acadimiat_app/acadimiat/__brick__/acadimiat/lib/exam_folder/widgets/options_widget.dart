
import 'package:flutter/material.dart';

import '../../Theme/style.dart';


class OptionsWidget extends StatelessWidget {
  const OptionsWidget({Key? key,required this.body}) : super(key: key);
  final String body;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        SizedBox(width: 10,),

        Text(body,style: blackBoldTextStyle(context: context,fontSize: 13),)


      ],
    );
  }
}
