import 'package:flutter/material.dart';
import '../../../../Theme/style.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/cached_net_work_image.dart';

class LoadingConsultationPage extends StatelessWidget {
  const LoadingConsultationPage({
    super.key,
    required this.id,
    required this.consultantImage,
    required this.consultantName,
  });

  final int id;
  final String consultantImage;
  final String consultantName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildConsultantInfo(context),
        _buildShimmerRow(context),
        _buildShimmerContainer(context, 100, 110),
        _buildShimmerContainer(context, 20, 110),
        _buildShimmerContainer(context, MediaQuery.of(context).size.height * 0.4, MediaQuery.of(context).size.width - 34),
      ],
    );
  }

  Widget _buildConsultantInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Hero(
                tag: "consultantTag$id",
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2000),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CachedNetWorkImage(
                      borderRadius: BorderRadius.circular(200),
                      boxFit: BoxFit.fill,
                      url: consultantImage,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                consultantName,
                style: blackBoldTextStyle(context: context, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
                (index) => Container(
              height: 100,
              width: 110,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(width: 1, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContainer(BuildContext context, double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
