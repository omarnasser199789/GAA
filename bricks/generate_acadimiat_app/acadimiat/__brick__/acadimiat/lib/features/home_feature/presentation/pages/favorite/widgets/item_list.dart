import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../../core/widgets/price_widget.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key,
    required this.image,
    required this.name,
    required this.trainer,
    required this.oldPrice,
    required this.newPrice,
    required this.onFavTap,
    required this.apiId,
  }) : super(key: key);
  final String image;
  final String name;
  final String trainer;
  final double oldPrice;
  final double newPrice;
  final Function (dynamic) onFavTap;
  final int apiId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: 118,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 115-8,
                height: 115-8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: CachedNetWorkImage(
                  url:image,
                  boxFit: BoxFit.cover,
                  borderRadius:  const BorderRadius.all(Radius.circular(8)),),
              ),
            ),
            const SizedBox(width: 11,),
            Padding(
              padding: const EdgeInsets.only(top:8,bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                      height: 40,
                      width:size.width-174,
                      child: Text(name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,style: blackBoldTextStyle(context: context,fontSize: 13,height: 1.5),)),

                  Text(trainer,

                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: blackBoldTextStyle(context: context,fontSize: 13),
                  ),

                  SizedBox(
                    width:size.width-180,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceWidget(newPrice:newPrice,
                          price:oldPrice,),

                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FavoriteButton(
                              iconSize:30,
                              iconDisabledColor:Theme.of(context).primaryColor,
                              isFavorite: true,
                              valueChanged: onFavTap,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}