import 'package:flutter/material.dart';
import '../../../../../../../../../Theme/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key,required this.svg,required this.title , this.svgWidth, this.body});

  final String svg;
  final String title;
  final String  ? body;
  final double ? svgWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            svg,
            width: svgWidth,
          ),
          const SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: blackBoldTextStyle(context: context,fontSize: 12),),

              if(body!=null)
                Padding(
                  padding: const EdgeInsets.only(top:4),
                  child: Text(body!,style: blackBoldTextStyle(context: context,fontSize: 10,color: hintTextColor),),
                ),
            ],
          )
        ],
      ),
    );
  }
}
