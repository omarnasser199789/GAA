import 'package:flutter/material.dart';
import '../../../../domain/entities/my_consultancies_entity.dart';
import 'consultancy_item.dart';


class ConsultanciesList extends StatelessWidget {
  final List<MyConsultanciesEntity> consultanciesEntityList;

  const ConsultanciesList({
    super.key,
    required this.consultanciesEntityList,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200 * consultanciesEntityList.length / 1,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: consultanciesEntityList.length,
        itemBuilder: (context, index) {
          return ConsultancyItem(
            consultanciesEntity: consultanciesEntityList[index],
            size: size,
          );
        },
      ),
    );
  }
}