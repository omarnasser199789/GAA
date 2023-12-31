import 'package:acadmiat/features/profile_feature/presentation/pages/performance_quality_page_folder/widgets/increase_font_widget.dart';

import '../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/globals.dart';

import '../../../../../core/widgets/app_bar_widget.dart';

class PerformanceQualityPage extends StatefulWidget {
  const PerformanceQualityPage({Key? key}) : super(key: key);

  @override
  State<PerformanceQualityPage> createState() => _PerformanceQualityPageState();
}

class _PerformanceQualityPageState extends State<PerformanceQualityPage> {
  bool state = true;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar:appBarWidget(locale.performanceQuality!,context,true,null,null),
      body: Padding(
        padding:defaultPadding,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.playTheAudioOfTheVideoInTheBackground!,style: blackBoldTextStyle(context: context,fontSize: 13),),
              CupertinoSwitch(
                value: state,
                onChanged: (value) {
                  state = value;
                  setState(() {});
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(locale.playTheAudioOfTheVideoInTheBackground!,style: blackBoldTextStyle(context: context,fontSize: 13),),
                    Text(locale.moveToNextContent!,style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),),

                  ],
                ),
                CupertinoSwitch(
                  value: state,
                  onChanged: (value) {
                    state = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),



          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) {
                    return IncreaseFontWidget();
                  });
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 19),
                  child: Text(locale.increaseFont!,style: blackBoldTextStyle(context: context,fontSize: 13),),
                ),
                Text(locale.medium!,style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),),

              ],
            ),
          ),
        
        ],),
      ),
    );
  }
}

