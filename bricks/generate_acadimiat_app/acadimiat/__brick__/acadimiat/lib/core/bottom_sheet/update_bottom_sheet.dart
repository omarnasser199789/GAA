import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Theme/style.dart';
import '../widgets/svg_code_widget.dart';

class UpdateBottomSheet extends StatelessWidget {
   const UpdateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.only(top: 12, left: 17, right: 17),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

               Row(children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:const SvgCodeWidget(svg: "assets/svgs/cancel.svg",)),
              ],),

              const SizedBox(height: 20,),

              const SvgCodeWidget(svg: "assets/svgs/login.svg",),

              const SizedBox(height: 20,),

              Text("حان الوقت للتحديث",style: blackBoldTextStyle(fontSize: 16, context: context),),

              const SizedBox(height: 20,),

              Text("آخبار حماسية! قمنا باصدار نسخة جديده كون اول من يحصل على التحديث الان",style: blackRegularTextStyle(fontSize: 14),textAlign: TextAlign.center,),

              const SizedBox(height: 20,),

              Row(
                children: [
                   Expanded(child: CustomButton(title: "حدث الان",
                  onTap: () async {
                    const url = 'https://apps.apple.com/us/app/mastery-academy/id1661460868';
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  )),
                  const SizedBox(width: 17,),

                  Expanded(child: CustomButton(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    title: "لاحقا",
                    color: Theme.of(context).cardColor,
                    textColor: Theme.of(context).primaryColor,
                    border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                  )),
                ],
              ),

              const SafeArea(child: SizedBox(height: 20,)),
            ],
          ),
        ),
      ),
    );
  }
}
