import 'package:flutter/material.dart';
import '../../pages/category/category_page.dart';
import 'package:shimmer/shimmer.dart';
import 'item_body.dart';

class CategoryItemList extends StatelessWidget {
  const CategoryItemList({
    super.key,
    required this.index,
    required this.categoryName,
    required this.categoryId,
    required this.categoryCourses,
    required this.image,
    this.loading,
  });

  final int index;
  final String categoryName;
  final int categoryId;
  final int categoryCourses;
  final String image;
  final bool ? loading;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:"Category$index",
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GestureDetector(
          onTap: (){
            if(loading!=true){
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => CategoryPage(
                        index: index,
                        colors: (index%2!=0)? [Colors.deepPurple, Colors.orange,]:
                        [Theme.of(context).primaryColor, Colors.grey,],
                        categoryName:categoryName,
                        id: categoryId,)));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 17),
            child: (loading==true)? Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
              child: ItemBody(index: index, image: image, name: categoryName, categoryCourses: categoryCourses,),
            ):ItemBody(index: index, image: image, name: categoryName, categoryCourses: categoryCourses,),
          ),
        ),
      ),
    );
  }
}