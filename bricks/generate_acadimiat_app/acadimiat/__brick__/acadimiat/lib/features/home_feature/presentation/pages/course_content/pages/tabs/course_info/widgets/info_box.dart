import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../../../Theme/style.dart';

/// A widget that displays an information box with an icon (SVG) and text.
class InfoBox extends StatelessWidget {
  const InfoBox({
    Key? key,
    required this.svg, // The path to the SVG icon.
    required this.title, // The title text to display.
    this.body, // The optional body text to display.
    this.svgWidth, // The width of the SVG icon (optional).
  }) : super(key: key);

  final String svg; // The path to the SVG icon.
  final String title; // The title text to display.
  final String? body; // The optional body text to display.
  final double? svgWidth; // The width of the SVG icon (optional).

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
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: blackBoldTextStyle(context: context, fontSize: 12),
              ),
              if (body != null) // Display the body text if it's provided.
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(body!,
                    style: blackBoldTextStyle(context: context, fontSize: 10, color: hintTextColor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
