import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/authentication_feature/presentation/pages/login_page.dart';
class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 17,right: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: SvgPicture.asset(
                    "assets/logos/logo2.svg",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: size.height*0.28),
            child: CustomButton(title: "تسجيل الدخول",onTap: (){
              goTo(context, (context) => const LoginPage());
            },),
          )
        ],
      ),
    );
  }
}
