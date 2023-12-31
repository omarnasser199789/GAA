import 'package:acadmiat/Theme/style.dart';
import 'package:flutter/material.dart';
  
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../../../core/widgets/custom_botton.dart';

class AdsTab extends StatefulWidget {
  const AdsTab({Key? key}) : super(key: key);

  @override
  State<AdsTab> createState() => _AdsTabState();
}

class _AdsTabState extends State<AdsTab> {
  @override
  Widget build(BuildContext context) {
    
    var locale = AppLocalizations.of(context)!;
    return  Padding(
      padding:
      const EdgeInsets.only(left: 17, right: 17),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding:
              const EdgeInsets.only(top: 15),
              child: Container(
                // height: 116,
                decoration: BoxDecoration(
                  color:Theme.of(context).cardColor,
                  borderRadius:
                  BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,
                          3), // changes position of shadow
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 9, right: 9, top: 13),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          CustomButton(
                            title: locale.extension!,
                            onTap: () {},
                            width: 57,
                            borderRadius: 6,
                            height: 25,
                            fontSize: 12,
                            textColor:
                            Color.fromRGBO(38,
                                96, 164, 1),
                            color: Color.fromRGBO(
                                38, 96, 164, 0.1),
                          ),
                          SizedBox(
                              width: 40,
                              height: 40,
                              child:
                              CachedNetWorkImage(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10),
                              )),
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            top: 9),
                        child: Row(
                          children: [
                            Text(
                              "${locale.coach!}/د.أيمن السيد",
                              style:
                              blackBoldTextStyle(context: context,
                                  fontSize:
                                  12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            top: 5),
                        child: Text(
                          "سيتم تأجيل لقاء اليوم لساعة واحدة",
                          style:
                          blackBoldTextStyle(fontSize: 11, height: 2, context:context,

                              // color: Theme.of(context).accentColor
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(
                            top: 5,
                            bottom: 14),
                        child: Text(
                          "25.06.2022 10:00",
                          style:
                          blackBoldTextStyle(
                              fontSize: 11, height: 2, context:context,
                              // color: Theme.of(context).accentColor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
