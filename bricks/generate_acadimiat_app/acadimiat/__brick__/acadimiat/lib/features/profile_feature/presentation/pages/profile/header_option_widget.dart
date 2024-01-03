import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Theme/style.dart';

class HeaderOptionWidget extends StatelessWidget {
  const HeaderOptionWidget(
      {super.key, required this.svg, required this.text, this.svgWidth});

  final String svg;
  final String text;
  final double? svgWidth;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, bottom: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                svg,
                color: iconsColor,
                width: svgWidth,
              ),
              const SizedBox(
                width: 9.2,
              ),
              Text(
                text,
                style: blackBoldTextStyle(fontSize: 13, context: context),
              ),
            ],
          ),
        ),
        Container(
          height: 0.2,
          width: double.infinity,
          color: Theme.of(context).canvasColor,
        ),
      ],
    );
  }
}