import 'package:flutter/material.dart';

import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/price_widget.dart';
import 'package:acadmiat/core/widgets/cached_net_work_image.dart';
import '../../../../data/models/card_by_id_model.dart';
import '../pages/trainer_info_page.dart';

class QuickInformation extends StatelessWidget {
  const QuickInformation({super.key,
    required this.courseName,
    required this.courseDescription,
    required this.trainers,
    required this.currentPrice,
    required this.mainPrice
  });
  final String courseName;
  final String courseDescription;
  final double currentPrice;
  final double mainPrice;
  final List<Trainer> trainers;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width - 34,
                child: Text(
                  courseName,
                  style: blackBoldTextStyle(context: context, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width - 34,
                child: Text(
                  parseHtmlString(courseDescription),
                  style: blackRegularTextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
          child: PriceWidget(newPrice: currentPrice, price: mainPrice),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SizedBox(
            height: 90,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: trainers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        goTo(context, (context) => TrainerInfoPage(
                          index: index,
                          trainer: trainers[index],
                          image: trainers[index].trainerAvatar,
                        )); //
                      },
                      child: Column(
                        children: [
                          Hero(
                            tag: "TrainerHeroTag$index",
                            child: Container(
                                width: 50, height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2000),
                                  border: Border.all(width: 2, color: Theme.of(context).canvasColor.withOpacity(0.5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CachedNetWorkImage(borderRadius: BorderRadius.circular(200),
                                    url: trainers[index].trainerAvatar,boxFit: BoxFit.fill,),
                                )),
                          ),
                          const SizedBox(height: 8),
                          Text(trainers[index].trainerName,
                            style: blackBoldTextStyle(context: context, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
