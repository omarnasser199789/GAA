import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Theme/style.dart';
import '../globals.dart';

class DetailsBox extends StatefulWidget {
  const DetailsBox(
      {Key? key,
        required this.title,
        required this.desc,
        required this.svg,
        required this.onTap})
      : super(key: key);

  final String title;
  final String desc;
  final String svg;
  final Function() onTap;
  @override
  State<DetailsBox> createState() => _DetailsBoxState();
}

class _DetailsBoxState extends State<DetailsBox> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: size.width*0.25,
          // width: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Theme.of(context).cardColor
              // border: Border.all(
              //   width: 1,
              //   color: Colors.grey,
              // )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:15,bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    widget.svg,
                  ),
                ),
                Text(widget.title, style: blackBoldTextStyle(context: context,fontSize: 12,height: lineSpace),textAlign: TextAlign.center,),

                Text(widget.desc,
                    style: blackBoldTextStyle(context: context,
                        fontSize: 11, color:   hintTextColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}