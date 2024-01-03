import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor,
      highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
      child: Container(
        width: double.infinity,
        height:size.height*0.2,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}