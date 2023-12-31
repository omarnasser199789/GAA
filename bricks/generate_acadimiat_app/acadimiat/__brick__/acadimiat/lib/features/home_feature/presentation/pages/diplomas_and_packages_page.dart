import 'package:acadmiat/features/home_feature/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import '../../../../Theme/style.dart';
import '../../../../core/classes/constants.dart';
import '../../../../core/widgets/course_cart_widget.dart';
import 'course_content/pages/course_content_page.dart';
import 'package:measure_size/measure_size.dart';
import '../../domain/entities/latestp_entity.dart';
import 'courses_content_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiplomasAndPackagesPage extends StatefulWidget {
  const DiplomasAndPackagesPage({Key? key, required this.latestPEntity}) : super(key: key);
  final List<LatestPEntity> latestPEntity;

  @override
  State<DiplomasAndPackagesPage> createState() => _DiplomasAndPackagesPageState();
}

class _DiplomasAndPackagesPageState extends State<DiplomasAndPackagesPage> {
  Size itemSize = Size(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("الدبلومات والباقات",context,true,[
        GestureDetector(
          onTap: (){
            goTo(context, (context) =>  SearchPage());
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                "assets/svgs/search.svg",
                color:iconsColor,
              ),
            ),
          ),
        ),
        // CartWidget(),

      ],null),
      body:   GridView.builder(
          padding: const EdgeInsets.only(left: 17, right: 17,bottom: 17,top:17),
          gridDelegate:
           const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.75,//childAspectRatio,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17),
          itemCount: widget.latestPEntity.length,
          itemBuilder: (BuildContext ctx, index) {
            return MeasureSize(
              onChange: (size) {
                if (!mounted) {
                  return;
                }

                setState(() {
                  itemSize = size;
                });
              },
              child: GestureDetector(
                onTap: () {
                  ///Actually we tow tye of pages to show
                  ///one for course and diploma
                  ///and other for courses

                  ///1-for course and diploma
                  if (widget.latestPEntity[index].isCourse) {
                    goTo(context, (context) => CourseContentPage(
                      cardId: widget.latestPEntity[index].id,
                      productType: ProductType.course,
                      courseCover: widget.latestPEntity[index].image,

                    ));
                  }
                  ///2-for courses
                  else {
                    goTo(context, (context) => CoursesContentPage(cardId: widget.latestPEntity[index].id,courseCover: widget.latestPEntity[index].image,));
                  }
                },
                child: CourseCartWidget(
                  image: widget.latestPEntity[index].image,
                  title: widget.latestPEntity[index].header,
                  trainer: widget.latestPEntity[index].trainer,
                  newPrice: widget.latestPEntity[index].newPrice,
                  price: widget.latestPEntity[index].price,
                  isCourse: widget.latestPEntity[index].isCourse,
                  height: 94,
                  id: widget.latestPEntity[index].id,
                  productType: ProductType.course,
                ),
              ),
            );
          }),
    );
  }
}
