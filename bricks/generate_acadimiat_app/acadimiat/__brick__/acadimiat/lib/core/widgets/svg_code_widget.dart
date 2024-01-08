import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Theme/theme_values.dart';

class SvgCodeWidget extends StatefulWidget {
  const SvgCodeWidget({Key? key, this.svg,this.code}) : super(key: key);
  final String ? svg;
  final String ? code;

  @override
  State<SvgCodeWidget> createState() => _SvgCodeWidgetState();
}

class _SvgCodeWidgetState extends State<SvgCodeWidget> {
  String svgCode="";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    String  code="";
    if(widget.svg!=null){
        code = await rootBundle.loadString(widget.svg!);
    }else{
      code=widget.code!;
    }
    Color primaryColor = Theme.of(context).primaryColor;
    String hexColor = primaryColor.value.toRadixString(16).substring(2); // Remove the alpha value (ff) from the color value
    svgCode=  code.replaceAll("ec5252",hexColor);
    if (!mounted) {
      return;
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(svgCode);
  }
}
