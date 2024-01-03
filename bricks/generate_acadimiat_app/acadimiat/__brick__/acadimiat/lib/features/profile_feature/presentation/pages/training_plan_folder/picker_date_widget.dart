import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class PickerDateWidget extends StatefulWidget {
  const PickerDateWidget({super.key});

  @override
  State<PickerDateWidget> createState() => _PickerDateWidgetState();
}

class _PickerDateWidgetState extends State<PickerDateWidget> {
  bool dateSelected = false;
  DateTime fromDate=DateTime.now();
  DateTime toDate=DateTime.now();
  bool checkbox = false;
  TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Jiffy.locale("ar");
    Size size =MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter mystate) {
            return
              Form(
                key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 50,
                              height: 3,
                              color: Theme.of(context).canvasColor)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("إضافة خطة تدريبية",
                              style: blackBoldTextStyle(
                                  context: context, fontSize: 15)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:30,left: 17,right: 17),
                      child: Text("تاريخ البداية",style: blackBoldTextStyle(fontSize: 14, context: context),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Container(
                        height: 130,
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
                                mystate(() {
                                  fromDate = value;
                                });
                              }
                            },
                            initialDateTime: fromDate,
                            minimumYear: DateTime.now().year,
                            // maximumYear: DateTime.now().year,

                            use24hFormat: true,
                            // backgroundColor: CupertinoColors.systemBlue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15 ,left: 17,right: 17),
                      child: Text("تاريخ النهاية",style: blackBoldTextStyle(fontSize: 14, context: context),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Container(
                        height: 130,
                        child: CupertinoTheme(
                          data:  CupertinoThemeData(
                            brightness:(isDarkMode) ?
                            Brightness.dark:
                            Brightness.light,
                          ),
                          child: CupertinoDatePicker(
                            mode:CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              if (value != fromDate) {
                                setState(() {
                                  toDate = value;
                                });
                              }
                            },
                            initialDateTime: fromDate,
                            minimumDate:fromDate ,
                            use24hFormat: true,
                            // backgroundColor: CupertinoColors.systemBlue,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 17,right: 17,bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: CustomTextField(
                        title: "عدد الساعات",
                        hint: 'أدخل عدد الساعات',
                        maxLength: 250,
                        inputFormatters:[ FilteringTextInputFormatter.digitsOnly,],
                        keyboardType: TextInputType.datetime,
                        controller: textController,
                        maxLines: 1,
                        onTap: () {},
                        onChange: (value){
                          if (value == null || value=="") {
                            return 'الرجاء ادخال عدد الساعات';
                          }
                        },

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom:30,left: 5,right: 5),
                      child: Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: iconsColor,
                            ),
                            child: Checkbox(
                              value: checkbox,
                              autofocus: true,
                              activeColor: Theme.of(context).primaryColor,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                checkbox=!checkbox;
                                mystate(() {});
                              },
                            ),
                          ),
                          Text("قم بتذكيري",style: blackBoldTextStyle(fontSize: 13, context: context),)
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 25, left: 17, right: 17,top:15),
                      child: SafeArea(
                          child: CustomButton(
                              title: "حفظ خطة التعلم",
                              onTap: () {
                                FormState form =  _formKey.currentState!;
                                if (form.validate()) {
                                  if(textController.text!="") {
                                    Navigator.pop(context,[fromDate,toDate,checkbox,int.parse(textController.text) ]);
                                  }else{
                                    Navigator.pop(context, 500);
                                    showMessage(message: "الرجاء اضافة نص للملاحظة", context: context);

                                    mystate(() {

                                    });
                                  }
                                }
                              })),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
