
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Theme/style.dart';
class InfoBoxType2 extends StatefulWidget {
  const InfoBoxType2({Key? key,required this.title,required this.text,required this.svg,required this.onTap}) : super(key: key);

  final String title;
  final String text;
  final String svg;
  final Function () onTap;

  @override
  State<InfoBoxType2> createState() => _InfoBoxType2State();
}

class _InfoBoxType2State extends State<InfoBoxType2> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: size.width*0.21,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: Colors.red,
          color:  Theme.of(context).primaryColor.withOpacity(0.1),
        ),


        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.center,
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(200)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    widget.svg,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:10,bottom: 20),
              child: Text(widget.text,style: blackBoldTextStyle(context: context,fontSize: 10),),
            ),
          ],
        ),

      ),
    );
  }
}

