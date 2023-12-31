import 'package:flutter/material.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../consultancies_feature/presentation/pages/consultation_by_id.dart';

class ConsultingListItem extends StatelessWidget {
  const ConsultingListItem({Key? key,required this.index,
    required this.consultantImage,
    required this.consultantName,
    required this.consultancyName,required this.id}) : super(key: key);
  final int index;
  final String consultancyName;
  final int id;
  final String consultantImage;
  final String consultantName;



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        goTo(context, (context) => ConsultationById(consultancyName:consultancyName, id: id, consultantImage:  consultantImage, consultantName: consultantName,));
      },
      child: SizedBox(
        width: 200,
        child: Stack(
          children: [
            CachedNetWorkImage(
                url: consultantImage,
                borderRadius: BorderRadius.circular(6), boxFit: BoxFit.cover
            ),
            Hero(
              tag: "consultantTag$index",
              child: CachedNetWorkImage(
                url: consultantImage,
                borderRadius: BorderRadius.circular(6), boxFit: BoxFit.contain
              ),
            ),
          ],
        ),
      ),
    );
  }
}