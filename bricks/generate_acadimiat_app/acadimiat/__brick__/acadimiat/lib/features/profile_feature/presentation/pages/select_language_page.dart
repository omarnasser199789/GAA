

import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../Locale/language_cubit.dart';
import '../../../../../../../../Locale/locale.dart';

import '../../../../../../../../core/globals.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../Theme/style.dart';



class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({Key ?key}) : super(key: key);

  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  FocusNode focusNode = new FocusNode();

  late LanguageCubit _languageCubit;
  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    super.dispose();
  }

  var val ;
  bool theFirst = true;




  @override
  Widget build(BuildContext context) {
    var localee = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    if (theFirst == true) {
      focusNode.requestFocus();
      if(AppLocalizations.of(context)!.locale.toString()=='ar'){
        val=2;
      }else if(AppLocalizations.of(context)!.locale.toString()=='fa'){
        val=3;
      }
      else if(AppLocalizations.of(context)!.locale.toString()=='en'){
        val=4;
      }

      else{
        val=1;
      }

      theFirst = false;
    }







    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        selectedLanguage = getCurrentLanguage(locale);

        return Scaffold(

          appBar:appBarWidget(localee.language!,context,true,null,null),
          body:  Container(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(left: 17,right: 17,top: 20,bottom: 8),
                    child: Text(localee.chooseTheLanguageOfTheApplication!,style: blackBoldTextStyle(context: context,fontSize: 14),),
                  ),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_kr');
                        // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel');
                        // globalSH.setString(CHANNEL_NAME, "kulshi_channel_ar");
                        // FirebaseMessaging.instance.subscribeToTopic("kulshi_channel_ar");
                        val =2 ;

                        globalSH.setString(
                          CACHED_USER_LANGUAGE,
                          'ar',
                        );
                        _languageCubit.selectArabicLanguage();
                      });
                    },
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                            value: 2,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_kr');
                                // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel');
                                // globalSH.setString(CHANNEL_NAME, "kulshi_channel_ar");
                                // FirebaseMessaging.instance.subscribeToTopic("kulshi_channel_ar");
                                val = value;

                                globalSH.setString(
                                  CACHED_USER_LANGUAGE,
                                  'ar',
                                );
                                _languageCubit.selectArabicLanguage();
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text("العربية",style: blackBoldTextStyle(context: context,fontSize: 13),),

                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_ar');
                      // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_kr');
                      // globalSH.setString(CHANNEL_NAME, "kulshi_channel");
                      // FirebaseMessaging.instance.subscribeToTopic("kulshi_channel");
                      setState(() {
                        val = 4;
                      });
                      globalSH.setString(
                        CACHED_USER_LANGUAGE,
                        'en',
                      );
                      _languageCubit.selectEngLanguage();
                    },
                    child: Container(
                      color:Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                      child: Row(

                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                            value: 4,
                            groupValue: val,
                            onChanged: (value) {
                              // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_ar');
                              // FirebaseMessaging.instance.unsubscribeFromTopic('kulshi_channel_kr');
                              // globalSH.setString(CHANNEL_NAME, "kulshi_channel");
                              // FirebaseMessaging.instance.subscribeToTopic("kulshi_channel");
                              setState(() {
                                val = value;
                              });
                              globalSH.setString(
                                CACHED_USER_LANGUAGE,
                                'en',
                              );
                              _languageCubit.selectEngLanguage();
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text("English",style: blackBoldTextStyle(context: context,fontSize: 13),),

                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );

  }

}
