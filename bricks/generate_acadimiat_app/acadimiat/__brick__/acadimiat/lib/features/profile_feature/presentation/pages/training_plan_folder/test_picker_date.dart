import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Theme/style.dart';

/// My app class to display the date range picker
class PickerDateDialog extends StatefulWidget {
  const PickerDateDialog({super.key});

  @override
  MyAppState createState() => MyAppState();
}

/// State for MyApp
class MyAppState extends State<PickerDateDialog> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool first = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30, top: 120, bottom: 120),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            child: Scaffold(
                body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Text(
                    "تصفية حسب التاريخ",
                    style: blackBoldTextStyle(fontSize: 15,context: context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                first = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: (first)
                                        ? Colors.green
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                              height: 40,
                              width: 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "الي تاريخ",
                                      style: blackBoldTextStyle(fontSize: 13,context: context),
                                    ),
                                    SvgPicture.asset(
                                      "assets/svg/calendar.svg",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(toDate),
                            style:blackBoldTextStyle(fontSize: 15,context: context),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                first = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: (!first)
                                        ? Colors.green
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                              height: 40,
                              width: 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "من تاريخ",
                                      style: blackBoldTextStyle(fontSize: 13,context: context),
                                    ),
                                    SvgPicture.asset(
                                      "assets/svg/calendar.svg",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(fromDate),
                            style: blackBoldTextStyle(fontSize: 15,context: context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (!first)
                    ? Container(
                        // color: Colors.red,
                        width: double.infinity,
                        height: size.height*0.4,
                        child: CupertinoTheme(
                          data:  CupertinoThemeData(
                            brightness:(isDarkMode) ?
                            Brightness.dark:
                            Brightness.light,
                          ),
                          child: CupertinoDatePicker(
                            mode:    CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              if (value != fromDate) {
                                setState(() {
                                  fromDate = value;
                                });
                              }
                            },
                            initialDateTime: fromDate,
                            // minimumYear: 2019,
                            maximumYear: DateTime.now().year,

                            use24hFormat: true,
                            // backgroundColor: CupertinoColors.systemBlue,
                          ),
                        ),
                      )
                    : Container(
                        // color: Colors.red,
                        width: double.infinity,
                  height: size.height*0.4,
                        child: CupertinoTheme(
                          data:  CupertinoThemeData(
                            brightness:(isDarkMode) ?
                            Brightness.dark:
                            Brightness.light,
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            // maximumDate: fromDate,

                            onDateTimeChanged: (value) {
                              if (value != toDate) {
                                setState(() {
                                  toDate = value;
                                });
                              }
                            },
                            initialDateTime: toDate,
                            minimumYear: fromDate.year,
                            use24hFormat: true,
                          ),
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context, [fromDate.toString(), toDate.toString()]);
                        },
                        child: Text(
                          "تآكيد",
                          style: blackBoldTextStyle(fontSize: 15,context: context,color: percentIndicatorColor),
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("الغاءالآمر",
                            style: blackBoldTextStyle(fontSize: 15,context: context,color: Colors.red),)),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
