import 'package:flutter/material.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/util/assets_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/widgets/back_button.dart';
import 'package:share_plus/share_plus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.courseName,
  }) : super(key: key);

  final String courseName;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: BackButtonWidget(),
      actions: [
        SizedBox(width: 15),
        GestureDetector(
          onTap: (){
            String result = shareCourseText.replaceAll("####",courseName);
            result = result.replaceAll("***", "\n");
            Share.share(result);
          },
          child: SizedBox(
            width: 18,
            height: 18,
            child: SvgPicture.asset(
              ImgAssets.share,
              color: iconsColor,
            ),
          ),
        ),
        SizedBox(width: 25),
      ],
    );
  }
}