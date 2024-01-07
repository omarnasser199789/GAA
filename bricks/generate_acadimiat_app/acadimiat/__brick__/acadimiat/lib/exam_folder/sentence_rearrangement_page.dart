import 'package:acadmiat/exam_folder/widgets/question_number.dart';
import '../Theme/style.dart';
import 'package:flutter/material.dart';

class SentenceRearrangementPage extends StatefulWidget {
  const SentenceRearrangementPage({Key? key}) : super(key: key);

  @override
  State<SentenceRearrangementPage> createState() => _SentenceRearrangementPageState();
}

class _SentenceRearrangementPageState extends State<SentenceRearrangementPage> {
  var val ;
  bool checkedValue =false ;
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: 650,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 17,right: 17,top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const QuestionNumber(text: '05',),
                  const SizedBox(width: 5,),
                    SizedBox(
                      width: size.width*0.8,
                      child: Text(": اعد ترتيب الجمل التالية بسحب الرقم للصندوق المناسب",style: blackBoldTextStyle(context: context,fontSize: 14),)),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 95,right: 95,top: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    IndicatorWidget(title: '01',),
                    IndicatorWidget(title: '02',),
                    IndicatorWidget(title: '03',),
                  ],
                ),
              ),

              const SizedBox(height: 30,),

              const InfoBox(text: "زيادة حجم المبيعات بنسية كبيره خلال الربع الأول من السنة المالية ",),
              const InfoBox(text: "زيادة حجم المبيعات بنسية كبيره خلال الربع"),
              const InfoBox(text: "زيادة حجم المبيعات بنسية كبيره السنة الأولى"),

            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorWidget extends StatefulWidget {
  const IndicatorWidget({Key? key,required this.title}) : super(key: key);

  final String title;
  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activeColor,
        borderRadius: BorderRadius.circular(size.width),
      ),
      child: Text(widget.title,style: blackBoldTextStyle(context: context,fontSize: 15,color: Colors.white),),
    );
  }
}

class InfoBox extends StatefulWidget {
  const InfoBox({Key? key,required this.text}) : super(key: key);

  final String text;

  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 275),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(widget.text,style: blackBoldTextStyle(fontSize: 12, context: context),),
        ),
      ),
    );
  }
}




