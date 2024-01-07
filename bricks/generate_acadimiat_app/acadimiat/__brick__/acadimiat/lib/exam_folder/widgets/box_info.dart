import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Theme/style.dart';

class BoxInfo extends StatelessWidget {
  const BoxInfo({
    Key? key,
    required this.size,
    required this.svg,
    required this.text,
    required this.title,
  }) : super(key: key);

  final Size size;

  final String svg;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119,
      width: size.width * 0.265,
      decoration: BoxDecoration(
        // color: Theme.of(context).cursorColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  svg,
                ),
              ),
              Text(
                title,
                style: blackBoldTextStyle(context: context, fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: blackBoldTextStyle(context: context, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}