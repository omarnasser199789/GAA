
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoadingVideoWidget extends StatelessWidget {
  const LoadingVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor,
      highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
      child: Container(
        width: double.infinity,
        height: size.height*0.36,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
