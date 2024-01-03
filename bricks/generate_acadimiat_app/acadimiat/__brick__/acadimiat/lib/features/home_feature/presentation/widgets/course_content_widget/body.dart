import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../data/models/card_by_id_model.dart'as m;
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  const Body({super.key,required this.materials});
  final List<m.Material> materials;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  62 * widget.materials.length / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      ),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.materials.length,
          itemBuilder: (context ,index){
            return Column(
              children: [
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17,right: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${lessonsNumber(index)}:  ",
                            style: blackBoldTextStyle(context: context,
                                fontSize: 11, color:   hintTextColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8),
                            child: Text(widget.materials[index].materialName,style: blackBoldTextStyle(fontSize: 11, context: context),),
                          ),

                        ],
                      ),
                      if(widget.materials[index].materialContents.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top:5),



                          child: Row(children: [

                            Directionality(
                              textDirection:
                              TextDirection.ltr,
                              child: Text(
                                formatedTime(time: widget.materials[index].materialContents[0].contentLength.toInt()),
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 11),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 17,
                              height: 17,
                              child: SvgPicture.asset(
                                  ImgAssets.clock,
                              ),
                            ),
                          ],),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: Theme.of(context).canvasColor.withOpacity(0.5),
                ),
              ],
            );
          }),
    );
  }
}