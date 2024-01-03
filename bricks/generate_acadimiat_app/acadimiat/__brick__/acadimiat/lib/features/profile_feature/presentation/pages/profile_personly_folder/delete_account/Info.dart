import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Theme/style.dart';

class Info extends StatelessWidget {
  const Info({super.key,required this.svg, required this.text});

  final String svg;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        children: [

          SvgPicture.asset(
            svg,
          ),
          const SizedBox(width: 13,),
          Text(text,style: blackBoldTextStyle(context: context,fontSize: 12),),
        ],
      ),
    );
  }
}
