import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../Theme/style.dart';
import '../../../../../../../../core/functions.dart';
import '../../../../../../../../core/globals.dart';


class ItemHeader extends StatefulWidget {
  const ItemHeader({Key? key, required this.unitName, required this.padding, required this.width, this.partTime, this.tutorialsNumber,this.attempts

  }) : super(key: key);

  final String unitName;
  final int ? tutorialsNumber;
  final int ? attempts;
  final double ? partTime;
  final double  width;
  final EdgeInsetsGeometry padding;


  @override
  State<ItemHeader> createState() => _ItemHeaderState();
}

class _ItemHeaderState extends State<ItemHeader> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: widget.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width-widget.width,
                child: Text(
                 widget. unitName,
                  style: blackBoldTextStyle(context: context,fontSize: 13,height: lineSpace),
                ),
              ),
            ],
          ),
          if(widget.tutorialsNumber!=null)
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Row(
              children: [

                Container(
                  alignment: Alignment.center,
                  width: 17,
                  height: 17,
                  child: SvgPicture.asset(
                    "assets/svgs/lessons.svg",
                  ),
                ),
                SizedBox(
                  width: size.width*0.01,
                ),
                Text(
                  "${widget.tutorialsNumber} ${locale.tutorials}",
                  style: blackBoldTextStyle(context: context,fontSize: 11),
                ),
                 SizedBox(
                  width: size.width*0.024,
                ),
                SizedBox(
                  width: 17,
                  height: 17,
                  child: SvgPicture.asset(
                    "assets/svgs/clock.svg",
                  ),
                ),
                SizedBox(
                  width: size.width*0.01,
                ),
                // Container(
                //
                //   // width: size.width*0.278,
                //   // color: Colors.red,
                //   child: Text(
                //     "15${locale.h} ${locale.and} 30${locale.m}",
                //     // maxLines: 1,
                //     style: blackBoldTextStyle(context: context,fontSize: 11),
                //   ),//
                // ),
                Directionality(
                  textDirection:
                  TextDirection.ltr,
                  child: Text(
                    formatedTime(time: widget.partTime!.toInt()),
                    style: blackBoldTextStyle(
                        context: context, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),


          if(widget.attempts!=null)
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,right: 0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/question.svg",
                    color:iconsColor,
                  ),
                  SizedBox(width: 5,),
                  Text("عدد محاولات الاختبار:  ${widget.attempts}",
                    style: blackBoldTextStyle(context: context,fontSize: 13),
                  ),
                ],
              ),
            ),

        ],
      ),
    );
  }
}