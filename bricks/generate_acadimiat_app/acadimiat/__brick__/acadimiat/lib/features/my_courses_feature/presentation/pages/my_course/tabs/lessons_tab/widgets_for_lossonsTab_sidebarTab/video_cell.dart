import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../Theme/style.dart';

class VideoCell extends StatelessWidget {
  const VideoCell({Key? key,required this.fileName}) : super(key: key);

  final String fileName;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
   return Padding(
      padding: const EdgeInsets.only(
          left: 5, right: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(5),
            border: Border.all(
                color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(1),
                width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 13,
              top: 13,
              left: 17,
              right: 17),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svgs/video2.svg",
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                // color: Colors.red,
                width: size.width - 90,
                child: Text(fileName,
                  style: blackBoldTextStyle(
                      context: context,
                      fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
