import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../Theme/style.dart';


class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker({super.key,required this.times,required this.onSelectedItemChanged});
  final List<String> times;
  final  ValueChanged<int>? onSelectedItemChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:const EdgeInsets.only(left: 17,right: 17),
      child: SizedBox(
        width:double.infinity,
        height: size.height*0.2,
        child: CupertinoPicker(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          itemExtent: 32.0,
          onSelectedItemChanged: onSelectedItemChanged,
          children: List<Widget>.generate(times.length, (index) {
            final day = times[index];
            return Text(day,style: blackBoldTextStyle(fontSize: 14,context: context),);
          }),
        ),
      ),
    );
  }
}