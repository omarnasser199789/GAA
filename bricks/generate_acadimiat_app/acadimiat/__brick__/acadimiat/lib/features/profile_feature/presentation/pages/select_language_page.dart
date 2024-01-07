import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../Locale/language_cubit.dart';
import '../../../../../../../../Locale/locale.dart';
import '../../../../../../../../core/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Theme/style.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  SelectLanguagePageState createState() => SelectLanguagePageState();
}

class SelectLanguagePageState extends State<SelectLanguagePage> {
  FocusNode focusNode = FocusNode();
  late LanguageCubit _languageCubit;
  int? val ;
  bool theFirst = true;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

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
          body:  SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding:  const EdgeInsets.only(left: 17,right: 17,top: 20,bottom: 8),
                    child: Text(localee.chooseTheLanguageOfTheApplication!,style: blackBoldTextStyle(context: context,fontSize: 14),),
                  ),

                  _buildLanguageOption(localee, context, 'العربية', 'ar', 2),
                  _buildLanguageOption(localee, context, 'English', 'en', 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(AppLocalizations locale, BuildContext context, String text, String languageCode, int value,) {
    return GestureDetector(
      onTap: () {
        setState(() {
          val = value;
          globalSH.setString(CACHED_USER_LANGUAGE, languageCode);
          if (languageCode == 'ar') {
            _languageCubit.selectArabicLanguage();
          } else if (languageCode == 'en') {
            _languageCubit.selectEngLanguage();
          }
        });
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        child: Row(
          children: [
            Radio(
              fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
              value: value,
              groupValue: val,
              onChanged: (newValue) {
                setState(() {
                  val = newValue as int;
                  globalSH.setString(CACHED_USER_LANGUAGE, languageCode);
                  if (languageCode == 'ar') {
                    _languageCubit.selectArabicLanguage();
                  } else if (languageCode == 'en') {
                    _languageCubit.selectEngLanguage();
                  }
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
            Text(text, style: blackBoldTextStyle(context: context, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
