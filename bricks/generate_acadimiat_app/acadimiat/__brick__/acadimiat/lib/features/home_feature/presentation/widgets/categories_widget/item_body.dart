import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';


class ItemBody extends StatelessWidget {
  const ItemBody({
    Key? key,
    required this.index,
    required this.image,
    required this.name,
    required this.categoryCourses,
  }) : super(key: key);
  final int index;
  final String image;
  final String name;
  final int categoryCourses;


  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors:
            (index%2!=0)? [
              Colors.deepPurple,
              Colors.orange,
            ]:
            [
              Theme.of(context).primaryColor,
              Colors.grey,
            ],
          )

      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [


            (image!="")?
            SizedBox(
                width: 40,
                height: 40,
                child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),url:image,)
            ):
            SvgPicture.asset(
              "assets/svgs/marketing.svg",
              color: Colors.white,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: blackBoldTextStyle(context: context,fontSize: 13,color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(top:8),
                    child: Text("$categoryCourses ${locale.course!}",style: blackBoldTextStyle(context: context,fontSize: 13,color: Colors.white),),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}