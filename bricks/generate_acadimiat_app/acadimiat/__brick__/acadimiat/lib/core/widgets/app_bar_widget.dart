import 'package:acadmiat/core/widgets/back_button.dart';
import 'package:flutter/material.dart';
import '../../Theme/style.dart';

AppBar appBarWidget(String title,BuildContext context,bool backBtn,List<Widget>? actions ,Color ? color){
 return AppBar(

    title: Text(title,maxLines: 4,
      style: blackBoldTextStyle(context: context,fontSize: 15,height: 1.5),),
   backgroundColor:(color==null)? Theme.of(context).scaffoldBackgroundColor:color,
   elevation: 0,
   centerTitle:true,
   actions:actions,
   automaticallyImplyLeading: false,
    leading:((backBtn==true))?  BackButtonWidget():null,
  );
}



Future<dynamic> goTo(BuildContext context, WidgetBuilder builder) async {

  var res= await Navigator.push(
    context,
    MaterialPageRoute(builder:builder),
  );
  return res;
}