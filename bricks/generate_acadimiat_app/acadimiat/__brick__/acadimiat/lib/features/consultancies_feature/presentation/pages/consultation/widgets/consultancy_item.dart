import 'package:acadmiat/features/consultancies_feature/presentation/pages/session/session_page.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../domain/entities/my_consultancies_entity.dart';
import '../../../widgets/session_number.dart';

class ConsultancyItem extends StatelessWidget {
  final MyConsultanciesEntity consultanciesEntity;
  final Size size;

  const ConsultancyItem({
    super.key,
    required this.consultanciesEntity,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: CachedNetWorkImage(
                          borderRadius: BorderRadius.circular(10),
                          boxFit: BoxFit.fill,
                          url: consultanciesEntity.consultancyImage,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Jiffy(consultanciesEntity.date).yMMMdjm,
                            style: blackBoldTextStyle(context: context, fontSize: 11, color: hintTextColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: size.width - 170,
                              child: Text(
                                consultanciesEntity.consultancy,
                                style: blackBoldTextStyle(context: context, fontSize: 13),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              consultanciesEntity.consultant,
                              style: blackBoldTextStyle(context: context, fontSize: 12, color: hintTextColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SessionNumber(numberOfSessions: consultanciesEntity.numberOfSessions),
                    CustomButton(
                      title: 'متابعة',
                      width: 90,
                      height: 37,
                      borderRadius: 8,
                      onTap: () {
                        goTo(
                          context,
                              (context) => SessionPage(
                            consultationID: consultanciesEntity.id,
                            consultancy: consultanciesEntity.consultancy,
                            consultant: consultanciesEntity.consultant,
                            image: consultanciesEntity.consultancyImage,
                            date: consultanciesEntity.date,
                            numberOfSessions: consultanciesEntity.numberOfSessions,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}