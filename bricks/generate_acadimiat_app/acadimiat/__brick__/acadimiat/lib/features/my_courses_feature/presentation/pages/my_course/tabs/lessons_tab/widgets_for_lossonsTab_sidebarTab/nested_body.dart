import 'package:flutter/material.dart';
import '../../../../../../../../Theme/style.dart';

class NestedBody extends StatelessWidget {
  const NestedBody({Key? key , required this.width, required this.name}) : super(key: key);
  final String name;
  final double width;


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return   Padding(
      padding: const EdgeInsets.only(top:7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width-width,
            child: Text(
              overflow: TextOverflow.ellipsis,
              name,
              maxLines: 1,
              style: blackBoldTextStyle(context: context, fontSize: 11),
            ),
          ),

        ],
      ),
    );

  }
}
