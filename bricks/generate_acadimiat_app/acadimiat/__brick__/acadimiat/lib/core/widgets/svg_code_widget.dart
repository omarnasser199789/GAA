import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgCodeWidget extends StatefulWidget {
  const SvgCodeWidget({Key? key, this.svg, this.code}) : super(key: key);
  final String? svg;
  final String? code;

  @override
  State<SvgCodeWidget> createState() => _SvgCodeWidgetState();
}

class _SvgCodeWidgetState extends State<SvgCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadSvgCode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting for the code to load
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return SvgPicture.string(snapshot.data!);
        } else {
          return Text('No SVG code available');
        }
      },
    );
  }

  Future<String> loadSvgCode() async {
    String code = widget.svg != null
        ? await rootBundle.loadString(widget.svg!)
        : widget.code!; // Use widget.code directly when widget.svg is null
    Color primaryColor = Theme.of(context).primaryColor;
    String hexColor =
    primaryColor.value.toRadixString(16).substring(2); // Remove the alpha value (ff) from the color value
    return code.replaceAll("ec5252", hexColor);
  }
}

