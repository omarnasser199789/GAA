import 'package:flutter/material.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../core/widgets/custom_botton.dart';

class Trail extends StatefulWidget {
   Trail({super.key,required this.price,required this.newPrice, required this.onTap,required this.loading, this.title});
  final double price;
  final double newPrice;
  final Function () onTap;
  final bool loading;
  final String? title;

  @override
  State<Trail> createState() => _TrailState();
}

class _TrailState extends State<Trail> {
  String currentPrice = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

     if(widget.newPrice==0){
       if(widget.price!=0){
         currentPrice = "${widget.price}\$";
       }else{
         currentPrice = "مجانا";
       }
     }else{
       currentPrice = "${widget.newPrice}\$";
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
                      loading: widget.loading,
                      title: widget.title?? "${locale.buyNow!} $currentPrice",onTap: widget.onTap,),
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