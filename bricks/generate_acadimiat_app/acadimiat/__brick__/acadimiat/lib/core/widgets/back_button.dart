import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
   BackButtonWidget({Key? key,this.padding,this.onTap}) : super(key: key);
  final    EdgeInsetsGeometry ? padding;

 final Function () ? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap==null)? () {
        Navigator.pop(context,400);
      }:onTap,
      child: Padding(
        padding: (padding==null)? const EdgeInsets.all(8.0):padding!,
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
             color: Theme.of(context).cardColor.withOpacity(1),
            borderRadius: BorderRadius.circular(200),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).canvasColor.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child:  Icon(
            Icons.arrow_back_ios_outlined,
            color: iconsColor
          ),
        ),
      ),
    );
  }
}
