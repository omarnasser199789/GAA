import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/globals.dart';
import 'header_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.heroTag, required this.imageUrl})
      : super(key: key);
  final String heroTag;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.35,
              child: HeaderWidget(
                heroTag: heroTag,
                imageUrl: imageUrl,
                progress: 0,
              ),
            ),
            Padding(
              padding: defaultPadding,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor:
                const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
                child: Container(
                  width: double.infinity,
                  height: size.height - 320,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}