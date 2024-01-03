import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/globals.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool state = true;
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:appBarWidget(locale.notifications!,context,true,null,null),
      body:Padding(
        padding:defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Text(locale.emailNotifications!,style: blackBoldTextStyle(context: context,fontSize: 14),),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                        width: size.width*0.7,
                        // color: Colors.red,
                        child: Text(locale.trainingCoursesOffersPercentageOfProgressInTraining!,style: blackBoldTextStyle(context: context,fontSize: 13),)),

                    CupertinoSwitch(
                      value: state,
                      onChanged: (value) {
                        state = value;
                        setState(() {});
                      },
                    ),
                  ],),
                  Padding(
                    padding: const EdgeInsets.only(top: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(locale.advertisementsReceivedFromTheTrainer!,style: blackBoldTextStyle(context: context,fontSize: 13),),

                      CupertinoSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                          setState(() {});
                        },
                      ),
                    ],),
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(top: 11,bottom: 11),
              child: Text(locale.backgroundNotifications!,style: blackBoldTextStyle(context: context,fontSize: 14),),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: size.width*0.7,
                          // color: Colors.red,
                          child: Text(locale.currentCoursesYourProgressInLearning!,style: blackBoldTextStyle(context: context,fontSize: 13),)),

                      CupertinoSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                          setState(() {});
                        },
                      ),
                    ],),
                  Padding(
                    padding: const EdgeInsets.only(top: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale.advertisementsReceivedFromTheTrainer!,style: blackBoldTextStyle(context: context,fontSize: 13),),

                        CupertinoSwitch(
                          value: state,
                          onChanged: (value) {
                            state = value;
                            setState(() {});
                          },
                        ),
                      ],),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 29),
              child: Text(locale.remindYouToStudyAndLearn!,style: blackBoldTextStyle(context: context,fontSize: 13),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(locale.chooseTheReminderTime!,style: blackBoldTextStyle(context: context,fontSize: 11,color:   hintTextColor),),
            ),

          ],
        ),
      ),
    );
  }
}
