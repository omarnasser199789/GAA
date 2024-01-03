import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../Theme/style.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarWidget("الشروط والأحكام",context,true,null,null),
      body: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17,top: 40),
        child: Text("تحدد هذه الشروط والأحكام ضوابط استخدام موقع emasteryacademy.com ، حيث يعد استخدام هذا الموقع قبولاً تاماً بكامل هذه الشروط والأحكام، فإن لم يكن المستخدم للموقع موافقاً عليها أو على أي جزء منها فيجب عليه الامتناع عن استخدام موقعنا الالكتروني."
          ,style:blackBoldTextStyle(context: context,fontSize: 11,height: 2) ,),
      ),
    );
  }
}
