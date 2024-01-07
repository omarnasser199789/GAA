import 'package:flutter/material.dart';
import '../../Theme/style.dart';
import 'back_button.dart';


AppBar appBarType2( {required String title,required BuildContext context}){
  return AppBar(
    backgroundColor:Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,

    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Theme(
        data: Theme.of(context).copyWith(),
        child: Container(
          height: 48.0,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 17,right: 17),
            child: Text(
              title,
              maxLines: 4,
              style: blackBoldTextStyle(context: context,fontSize: 15,height: 1.5),),
          ),
        ),
      ),
    ),
    leading: BackButtonWidget(),
  );
}