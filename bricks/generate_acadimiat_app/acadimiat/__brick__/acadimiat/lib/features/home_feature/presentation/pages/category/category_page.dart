import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../search_page.dart';
import 'package:flutter_svg/svg.dart';
import '../home/widgets/training_courses_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key,required this.index,required this.categoryName,required this.id,required this.colors}) : super(key: key);
  final int index;
  final List<Color> colors;
  final String categoryName;
  final int id;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: appBarWidget(widget.categoryName,context,true,[
        GestureDetector(
          onTap: (){
            goTo(context, (context) =>  const SearchPage());
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 30,
              height: 30,
              // color: Colors.red,
              child: SvgPicture.asset(
                ImgAssets.share,
                color:iconsColor,
              ),
            ),
          ),
        ),
      ],null),
      body: TrainingCoursesWidget(title: locale.trainingCourses!,type: 3,categoryId: widget.id,isNew: false,categoryName:widget.categoryName),
    );
  }
}
