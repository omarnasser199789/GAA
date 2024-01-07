import 'dart:convert';
import 'package:acadmiat/core/util/assets_manager.dart';
import 'package:advance_notification/advance_notification.dart';
import 'package:acadmiat/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import '../features/authentication_feature/data/data_sources/remot_data_sources/authenticate_remote_data_functions.dart';
import '../features/consultancies_feature/presentation/pages/book_consultation/custom_date.dart';
import 'error/failures.dart';
import 'package:html/parser.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'globals.dart';

List<int> loadMyCoursesList() {
  final jsonString = globalSH.getString(MY_COURSES_List);
  if (jsonString != null) {
    final intList = jsonDecode(jsonString).cast<int>();
    return intList;
  }
  return [];
}

bool coursePurchaseOrNot(int id)  {
  List<int> list=  loadMyCoursesList();
  for(var item in list){
    if(item==id){return false;}
  }
  return true;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if(value !=null){
    if (!regex.hasMatch(value))
      return 'يرجى ادخال بريد الكتروني صحيح مثال (example@gmail.com)';
    else
      return null;
  }else{
    return null;
  }

}

String? validatePhoneNumber(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if(value!=null){
    if (value.length == 0) {
      return 'رقم الهاتف مطلوب';
    } else if (!regExp.hasMatch(value)) {
      return 'يجب أن يتكون الرقم من (10) مثال (2222 222 222)';
    }
  }else{
    return null;
  }

  return null;
}

String lessonsNumber(int i){
  // if(i==0){return locale.firstLesson;}
  switch(i) {
    case 0: {
      return "الدرس الآول";
    }
    case 1: {
      return "الدرس الثاني";
    }
    case 2: {
      return "الدرس الثالث";
    }
    case 3: {
      return "الدرس الرابع";
    }
    case 4: {
      return "الدرس الخامس";
    }
    case 5: {
      return "الدرس السادس";
    }

    case 6: {
      return "الدرس السابع";
    }

    case 7: {
      return "الدرس الثامن";
    }

    case 8: {
      return "الدرس التاسع";
    }
    case 9: {
      return "الدرس العاشر";
    }
    case 10: {
      return "الدرس الحادي عشر";
    }

    case 11: {
      return "الدرس الثاني عشر";
    }

    case 12: {
      return "الدرس الثالث عشر";
    }

    case 13: {
      return "الدرس الرابع عشر";
    }



    case 14: {
      return "الدرس الخامس عشر";
    }


    case 15: {
      return "الدرس السادس عشر";
    }

    case 16: {
      return "الدرس السابع عشر";
    }
    case 17: {
      return "الدرس الثامن عشر";
    }

    case 18: {
      return "الدرس التاسع عشر";
    }

    case 19: {
      return "الدرس العشرون";
    }

    case 20: {
      return "الدرس الواحد والعشرون";
    }

    default: {
      return "${i+1}" ;
    }

  }
}

showMessage( { required String  message,required BuildContext context,Color ? bgColor}){
  WidgetsBinding.instance.addPostFrameCallback((_) {
    AdvanceSnackBar(
        message: message,
        mode: Mode.BASIC,
        textSize: 14,
        bgColor:(bgColor!=null)?bgColor: const Color.fromRGBO(59, 58, 58, 1.0))
        .show(context);
  });
}

bool isLoggedIn(){
  return (globalSH.getString(CACHED_JWT_TOKEN)!=null)?true:false;
}
Future<bool> isAuthorized() async {
  AuthenticateRemoteDataFunctions functions = AuthenticateRemoteDataFunctions();
  int statusCode = await functions.testRefreshToken();
  return statusCode==200?true:false;
}

bool isShowCase(){
  return (globalSH.getBool(iS_Show_Case)==null)?true:false;
}


int convertDateTimeToSecond( DateTime dateTime){
  return Duration(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second
  ).inSeconds;
}

int isFavOrNot(int id){

  for(int i=0 ;favEntity.length>i; i++){
    if(favEntity[i].apiId==id){
      if(favEntity[i].fav==1)return i;
    }
  }
  return -1;
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

Widget getLinkIcon({required String  fileName}){
  if (fileName.contains("github")) {
    return SvgPicture.asset( ImgAssets.ggithub,width: svgWidth,);
  }
  if (fileName.contains("google")) {
    return SvgPicture.asset( ImgAssets.googles,width: svgWidth,);
  }
  if (fileName.contains(".aws")) {
    return SvgPicture.asset(ImgAssets.aws,width: svgWidth,);
  }

  if (fileName.contains("drv.ms")) {
    return SvgPicture.asset(ImgAssets.onedrive,width: svgWidth,);
  }
  if (fileName.contains("onedrive")) {
    return SvgPicture.asset(ImgAssets.onedrive,width: svgWidth,);
  }
  return    SvgPicture.asset( ImgAssets.url,width: svgWidth,);
}

Widget getIcon({required String  fileName}){

  if (fileName.contains(".ppt")) {
    return SvgPicture.asset(ImgAssets.ppt,width: svgWidth,);
  }
  if (fileName.contains("q&A")) {
    return SvgPicture.asset(ImgAssets.qA,width: svgWidth,);
  }
  if (fileName.contains(".py")) {
    return SvgPicture.asset(ImgAssets.python,width: svgWidth,);
  }
  if (fileName.contains(".xls")) {
    return SvgPicture.asset(ImgAssets.xls,width: svgWidth,);
  }
  if (fileName.contains(".json")) {
    return SvgPicture.asset(ImgAssets.json,width: svgWidth,);
  }
  if (fileName.contains(".eps")) {
    return SvgPicture.asset(ImgAssets.eps,width: svgWidth,);
  }
  if (fileName.contains(".cs")) {
    return SvgPicture.asset(ImgAssets.cs,width: svgWidth,);
  }
  if (fileName.contains(".html")) {
    return SvgPicture.asset(ImgAssets.html,width: svgWidth,);
  }
  if (fileName.contains(".java")) {
    return SvgPicture.asset(ImgAssets.java,width: svgWidth,);
  }

  if (fileName.contains(".css")) {
    return SvgPicture.asset(ImgAssets.css,width: svgWidth,);
  }
  if (fileName.contains(".dart")) {
    return SvgPicture.asset(ImgAssets.dart,width: svgWidth,);
  }
  if (fileName.contains(".cpp")) {
    return SvgPicture.asset(ImgAssets.c__,width: svgWidth,);
  }
  if (fileName.contains(".ae")) {
    return SvgPicture.asset(ImgAssets.ae,width: svgWidth,);
  }

  if (fileName.contains(".pdf")) {
    return SvgPicture.asset( ImgAssets.pdf,width: svgWidth,);
  }
  if (fileName.contains(".jpg")) {
    return SvgPicture.asset( ImgAssets.jpg,width: svgWidth,);
  }
  if (fileName.contains(".png")) {
    return SvgPicture.asset(ImgAssets.png,width: svgWidth,);
  }
  if (fileName.contains(".sql")) {
    return SvgPicture.asset( ImgAssets.db,width: svgWidth,);
  }
  if (fileName.contains(".docx")) {
    return SvgPicture.asset( ImgAssets.doc,width: svgWidth,);
  }
  if (fileName.contains(".svg")) {
    return SvgPicture.asset( ImgAssets.scvg,width: svgWidth,);
  }
  if (fileName.contains("link")) {
    return SvgPicture.asset( ImgAssets.url,width: svgWidth,);
  }
  if (fileName.contains("live-line")) {
    return SvgPicture.asset( ImgAssets.zoom,width: svgWidth,);
  }
  if (fileName.contains("txt")) {
    return SvgPicture.asset( ImgAssets.txt,width: svgWidth,);
  }

  if (fileName.contains("github")) {
    return SvgPicture.asset(ImgAssets.github,width: svgWidth,);
  }

  return SvgPicture.asset( ImgAssets.default_,width: svgWidth,);

}

String formatDuration(Duration d) {
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final List<String> tokens = [];
  if (days != 0) {
    tokens.add('${days}');
  }
  if (tokens.isNotEmpty || hours != 0) {
    tokens.add('${hours}');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    tokens.add('${minutes}');
  }
  tokens.add('${seconds}');

  return tokens.join(':');
}

bool isLight(){

  if(globalSH.getString("ThemeMode")==null){
    return
      (SchedulerBinding.instance.window.platformBrightness==Brightness.light);
  }

  return
    (SchedulerBinding.instance.window.platformBrightness==Brightness.light)
        &&((globalSH.getString("ThemeMode")=="light"));
}

bool isEnglish(BuildContext context){
  // print(AppLocalizations.of(context)!.locale.toString());
  return AppLocalizations.of(context)!.locale.toString()=='en';
}

String arabicAlphabet(int index){
  List<String> alphabet=["ا","ب", "ت", "ث", "ج", "ح", "خ", "د", "ذ", "ر", "ز", "س", "ش", "ص", "ض", "ط", "ظ", "ع", "غ", "ف", "ق", "ك", "ل", "م", "ن", "ه", "و", "ي",];
  return alphabet[index];
}

formatedTime({required int time}) {
  int sec = time % 60;
  int min = (time / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "${minute}m : ${second}s";
}

int userId(){
  return int.parse(globalSH.getString(USER_ID)!)  ;
}

String userEmail(){
  return globalSH.getString(CUSTOMER_EMAIL)!  ;
}

CustomDate generateDates(List<int> weekdays, int numDays) {
  Jiffy.locale("ar");
  // Create a list to hold the generated dates
  List<String> dates = [];
  List<DateTime> dateTime = [];

  // Get the current date
  DateTime now = DateTime.now();
  var today = DateTime(now.year, now.month, now.day);

  // Iterate for the specified number of days
  for (var i = 0; i < numDays; i++) {
    // Check if the current day of the week is in the list of weekdays
    if (weekdays.contains(today.weekday)) {
      dates.add( Jiffy(today).yMMMMd);
      dateTime.add(today);
    }
    // Move to the next day
    today = today.add(const Duration(days: 1));
  }

  return CustomDate(date: dates, dateTime: dateTime);
}