import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../Theme/style.dart';
import '../../../../core/globals.dart';
import '../../../../core/util/assets_manager.dart';
import '../../../../item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {


  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(
        header: Text("ما هي ماستري أكاديمي؟",style: blackBoldTextStyle(context: context,fontSize: 12),),
        body:Text("تأسست ماستري أكاديمي للتدريب والتطوير في عام 2007 في المملكة المتحدة – بريطانيا، وتوسعت فروعها في كل من الأردن 2010 و ماليزيا 2017 لتقدم أعمالها وخدماتها .في كل من الشرق الأوسط وجنوب آسيا",
          style: blackBoldTextStyle(context: context,fontSize: 12,height: 2),),
      ),


      Item(
        header: Text("هل يتوجب علي الحضور بشكل دائم؟",style: blackBoldTextStyle(context: context,fontSize: 12),),
        body:Text("تأسست ماستري أكاديمي للتدريب والتطوير في عام 2007 في المملكة المتحدة – بريطانيا، وتوسعت فروعها في كل من الأردن 2010 و ماليزيا 2017 لتقدم أعمالها وخدماتها .في كل من الشرق الأوسط وجنوب آسيا",
          style: blackBoldTextStyle(context: context,fontSize: 12,height: 2),),
      ),

      Item(
        header: Text("ما هي الدورة التي أحتاجها؟",style: blackBoldTextStyle(context: context,fontSize: 12),),
        body:Text("تأسست ماستري أكاديمي للتدريب والتطوير في عام 2007 في المملكة المتحدة – بريطانيا، وتوسعت فروعها في كل من الأردن 2010 و ماليزيا 2017 لتقدم أعمالها وخدماتها .في كل من الشرق الأوسط وجنوب آسيا",
          style: blackBoldTextStyle(context: context,fontSize: 12,height: 2),),
      ),

      Item(
        header: Text("هل سأحصل على شهادة خبرة؟",style: blackBoldTextStyle(context: context,fontSize: 12),),
        body:Text("تأسست ماستري أكاديمي للتدريب والتطوير في عام 2007 في المملكة المتحدة – بريطانيا، وتوسعت فروعها في كل من الأردن 2010 و ماليزيا 2017 لتقدم أعمالها وخدماتها .في كل من الشرق الأوسط وجنوب آسيا",
          style: blackBoldTextStyle(context: context,fontSize: 12,height: 2),),
      ),



    ];
    return Scaffold(
      appBar:appBarWidget("المساعدة",context,true,null,null),
      body: SingleChildScrollView(
        child: Padding(
          padding: defaultPadding,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("الأسئلة العامة",style: blackBoldTextStyle(context: context,fontSize: 13,color:   hintTextColor),),
              ),

              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color:Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList.radio(
                      initialOpenPanelValue: 0,
                      elevation: 0,

                      children: items
                          .map((item) => ExpansionPanelRadio(
                          backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
                          canTapOnHeader: true,
                          value: item.header,
                          headerBuilder: (context, isExpanded) =>
                              ListTile(
                                title: item.header,
                              ),
                          body: ListTile(title: item.body)))
                          .toList(),
                      expandedHeaderPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10,left: 17,right: 17,bottom: 10),
                child: Text("الأسعار والدفع",style: blackBoldTextStyle(context: context,fontSize: 13,color:   hintTextColor),),
              ),

              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color:Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList.radio(
                      initialOpenPanelValue: 0,
                      elevation: 0,
                      children: items.map((item) => ExpansionPanelRadio(
                          backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
                          canTapOnHeader: true,
                          value: item.header,
                          headerBuilder: (context, isExpanded) =>
                              ListTile(title: item.header),
                          body: ListTile(title: item.body))).toList(),
                      expandedHeaderPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10,left: 17,right: 17,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: Text("للتواصل مع الدعم",style: blackBoldTextStyle(context: context,fontSize: 13),),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImgAssets.sms,
                          color: iconsColor,
                        ),
                        const SizedBox(width: 8,),
                        Text("timothy.banks@mail.com",style: blackBoldTextStyle(context: context,fontSize: 13,color: const Color.fromRGBO(47, 191, 252, 1)
                        ),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            ImgAssets.call,
                            color: iconsColor,
                          ),
                          const  SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("أرقام الطوارىء",style: blackBoldTextStyle(context: context,fontSize: 12),),
                              Padding(
                                padding: const EdgeInsets.only(top: 14,bottom: 11),
                                child: Text("+974 000 000 000",style: blackBoldTextStyle(context: context,fontSize: 12),),
                              ),
                              Text("+974 000 000 000",style: blackBoldTextStyle(context: context,fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
