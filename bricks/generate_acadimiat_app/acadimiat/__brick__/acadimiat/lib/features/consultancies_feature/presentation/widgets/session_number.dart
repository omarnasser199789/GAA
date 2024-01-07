import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Theme/style.dart';
import '../../../../core/util/assets_manager.dart';

class SessionNumber extends StatelessWidget {
  const SessionNumber({super.key,required this.numberOfSessions,this.type2});
  final int numberOfSessions;
  final bool? type2;

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        SvgPicture.asset(
          ImgAssets.question,
          color:iconsColor,
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$numberOfSessions جلسات",style: blackBoldTextStyle(context: context,fontSize: 12),),

            if(type2==null)
            Padding(
              padding: const EdgeInsets.only(top:5),
              child: Text("عدد الجلسات",style: blackBoldTextStyle(context: context,fontSize: 11,color:  hintTextColor),),
            ),
          ],
        ),
      ],
    );
  }
}
