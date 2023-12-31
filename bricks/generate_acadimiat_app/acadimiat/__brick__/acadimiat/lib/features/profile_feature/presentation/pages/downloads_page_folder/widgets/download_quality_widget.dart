
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';

class DownloadQualityWidget extends StatefulWidget {
  const DownloadQualityWidget({Key? key}) : super(key: key);

  @override
  State<DownloadQualityWidget> createState() => _DownloadQualityWidgetState();
}

class _DownloadQualityWidgetState extends State<DownloadQualityWidget> {
  var val ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: size.height * 0.65,
          child: Material(
              color:Theme.of(context).scaffoldBackgroundColor,//scaffoldBackgroundColor
              borderRadius:
              const BorderRadius.only(
                  topLeft:
                  Radius.circular(
                      10),
                  topRight:
                  Radius.circular(
                      10)),
              child: Padding(
                padding:
                const EdgeInsets.only(
                    left: 17,
                    right: 17),
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 15),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Container(
                            width: 50,
                            height: 3,
                            color: Theme.of(context).canvasColor,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets
                          .only(
                          top: 15),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Text(
                              locale.videoDownloadQuality!,
                              style: blackBoldTextStyle(context: context,
                                  fontSize:
                                  15)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 52),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(

                            fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                            value: 0,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;

                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.low!,style: blackBoldTextStyle(context: context,fontSize: 13),),
                              SizedBox(height: 10,),
                              Text("360p ${locale.or!} 240p ${locale.fasterLoadingAndLessStorage!}",style: blackBoldTextStyle(context: context,fontSize: 11),),
                            ],
                          )
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 37),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(

                            fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                            value: 1,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;

                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.medium!,style: blackBoldTextStyle(context: context,fontSize: 13),),
                              const SizedBox(height: 10,),
                              Text("3540P ${locale.loadAndStoreMediumQuality!}",style: blackBoldTextStyle(context: context,fontSize: 11),),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 37),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(

                            fillColor: MaterialStateColor.resolveWith((states) => activeColor),
                            value: 2,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;

                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.high!,style: blackBoldTextStyle(context: context,fontSize: 13),),
                              const SizedBox(height: 10,),
                              Text("720P ${locale.slowLoadingAndMoreStorage!}",style: blackBoldTextStyle(context: context,fontSize: 11),),
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )),
        ),

      ],
    );
  }
}
