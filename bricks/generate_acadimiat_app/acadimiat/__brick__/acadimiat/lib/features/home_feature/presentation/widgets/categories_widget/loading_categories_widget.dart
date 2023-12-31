import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import 'category_item_list.dart';

class LoadingCategoriesWidget extends StatelessWidget {
  const LoadingCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    List<Widget> widgetList = [];

    for(int i=0; i<3;i++){
      widgetList.add(
          CategoryItemList(
            loading: true,
              index: i,
              categoryName: "****",
              categoryId: -1,
              image: "",
              categoryCourses:0
          ));
    }
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 8),
              child: Text(locale.categories!,style: blackBoldTextStyle(context: context,fontSize:15),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 17),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widgetList,
              ),
            ),

          ),
        ),
      ],
    );

  }
}

