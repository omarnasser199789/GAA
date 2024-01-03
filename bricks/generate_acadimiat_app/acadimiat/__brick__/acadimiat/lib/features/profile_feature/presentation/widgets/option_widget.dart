
import 'package:flutter/material.dart';

import '../../../../Theme/style.dart';

class Option extends StatefulWidget {
  const Option({super.key,required this.text,required this.onTap});

  final String text;
  final Function () onTap;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),//scaffoldBackgroundColor//scaffoldBackgroundColor
        child: Padding(
          padding: const EdgeInsets.only(top: 12,bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text,style: blackBoldTextStyle(context: context,fontSize: 13),),
              const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
