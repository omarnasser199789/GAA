import 'package:flutter/material.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../core/widgets/custom_botton.dart';


class Trail extends StatelessWidget {
   Trail({Key? key,required this.orientation,required this.price,required this.newPrice, required this.onTap,required this.loading, this.title}) : super(key: key);
  final orientation;
  final double price;
  final double newPrice;
  final Function () onTap;
  final bool loading;
  final String? title;
  String currentPrice = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

     if(newPrice==0){
       if(price!=0){
         currentPrice = "$price\$";
       }else{
         currentPrice = "مجانا";
       }
     }else{
       currentPrice = "$newPrice\$";
     }

    return   Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        color: Theme.of(context).cardColor,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: size.width - 34 ,
                      loading: loading,
                      title: title?? "${locale.buyNow!} $currentPrice",onTap: onTap,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}