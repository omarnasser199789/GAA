import 'package:flutter/material.dart';
import '../../../Theme/style.dart';
import '../../../core/globals.dart';
import '../../../core/widgets/custom_botton.dart';
import '../../../nav_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPaymentPage extends StatefulWidget {
   SuccessPaymentPage({Key? key,}) : super(key: key);
  @override
  State<SuccessPaymentPage> createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
  bool loading=true;
  bool allowShowMsg=true;
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomCenter,
              children: [
                const SuccessGif(),
                Text("تمت عملية الشراء بنجاح تمتع",style: blackBoldTextStyle(fontSize: 13, context: context),),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top:10,bottom: 10),
              child: Text("بتجربة توعية",style: blackBoldTextStyle(fontSize: 13, context: context),),
            ),
            Text("رقم الطلب CT256#",style: blackBoldTextStyle(fontSize: 13, context: context),),

            Padding(
              padding: const EdgeInsets.only(top:50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: CustomButton(title: "ابدء بالتعلم",
                      width: size.width*0.7,
                      onTap:() {
                        page= 2;
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const NavPage()),
                                  (Route<dynamic> route) => false);
                        });
                      },),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}

class SuccessGif extends StatelessWidget {
  const SuccessGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/svgs/bg5.svg",
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: SvgPicture.asset(
            "assets/svgs/check3.svg",
          ),
        ),

      ],
    );
  }
}

