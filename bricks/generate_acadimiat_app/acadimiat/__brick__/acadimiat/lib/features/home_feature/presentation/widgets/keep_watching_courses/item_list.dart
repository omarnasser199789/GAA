import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';

class ItemList extends StatefulWidget {
  ItemList({Key? key,this.enableBroadcast,this.courseId,this.total,required this.onTap, this.typeCourse, this.imageUrl,this.percent,this.header,this.trainer})
      : super(key: key);

  final Function () onTap;
  final bool? enableBroadcast;
  final String? typeCourse;
  final String? header;
  final String? imageUrl;
  final String? trainer;
  final int? percent;
  final int? courseId;
  final double? total;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;


    return Padding(
      padding: const EdgeInsets.only(left: 17),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 200,

          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 5,
                blurRadius: 12,
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110,
                child: Hero(
                  tag: widget.courseId.toString(),
                  child:
                  Stack(
                    children: [
                      CachedNetWorkImage(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        url: widget.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                      CachedNetWorkImage(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        url: widget.imageUrl,
                        boxFit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Text(widget.header.toString(),style: blackBoldTextStyle(fontSize: 12, context: context,height: lineSpace),),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                child: Column(
                  children: [
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("مكتملة",style: blackBoldTextStyle(fontSize: 11, context: context),),
                        Text("${widget.percent!}%",style: blackBoldTextStyle(fontSize: 11, context: context),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:5),
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        // width: 154,//size.width*0.4,
                        animation: true,
                        lineHeight: 8,
                        animationDuration: 1000,
                        barRadius: const Radius.circular(6),
                        percent: widget.percent!/100,
                        // center: Text("$percent"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: percentIndicatorColor,
                      ),
                    )
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
