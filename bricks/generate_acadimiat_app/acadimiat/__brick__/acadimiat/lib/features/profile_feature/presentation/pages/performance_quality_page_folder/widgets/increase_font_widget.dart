
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';


class IncreaseFontWidget extends StatefulWidget {
  const IncreaseFontWidget({Key? key}) : super(key: key);

  @override
  State<IncreaseFontWidget> createState() => _IncreaseFontWidgetState();
}

class _IncreaseFontWidgetState extends State<IncreaseFontWidget> {
  var val ;
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: size.height * 0.65,
          child: Material(
              color:  Theme.of(context).scaffoldBackgroundColor,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              locale.increaseFont!,
                              style: blackBoldTextStyle(context: context,
                                  fontSize:
                                  15)),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top:50),
                      child: Text(locale.previewTheFont!,style: blackBoldTextStyle(context: context,fontSize: 14),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Text(locale.baseAddress!,style: blackBoldTextStyle(context: context,fontSize: 14),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(locale.subtitle!,style: blackBoldTextStyle(context: context,fontSize: 12),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Text("النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي النص الافتراضي",
                        style: blackBoldTextStyle(context: context,fontSize: 10),),
                    ),


                    // Padding(
                    //   padding: const EdgeInsets.only(top:75),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       color: Theme.of(context).canvasColor.withOpacity(0.7),
                    //     ),
                    //
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: SfSlider(
                    //
                    //
                    //         min: 0.0,
                    //         max:100,
                    //         value: _value,
                    //         interval: 20,
                    //         showTicks: true,
                    //
                    //         showLabels: true,
                    //         enableTooltip: true,
                    //         activeColor: Theme.of(context).primaryColor,
                    //         inactiveColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    //         minorTicksPerInterval: 1,
                    //         onChanged: (dynamic value){
                    //           setState(() {
                    //             _value = value;
                    //
                    //
                    //             // zoomRatio=_value/60;
                    //             // print(zoomRatio);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),


                  ],
                ),
              )),
        ),

      ],
    );
  }
}
