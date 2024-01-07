import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class AddBookmarkButton extends StatefulWidget {
   AddBookmarkButton({
     super.key,
      required this.allowSelectLecture,
      required this.isVimeo,
      required this.videoId});

   final bool allowSelectLecture;
  final bool isVimeo;
  final int videoId;

  @override
  State<AddBookmarkButton> createState() => _AddBookmarkButtonState();
}

class _AddBookmarkButtonState extends State<AddBookmarkButton> {
  bool checkBoxValue = false;

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () async {

        amazonVideoWidgetKey.currentState!.stopVideo();
        final result = await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter mystate) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 50, height: 3, color: Theme.of(context).canvasColor)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(locale.addANote!, style: blackBoldTextStyle(context: context, fontSize: 15)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 19,
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: CustomTextField(
                                title: '',
                                hint: '${locale.writeYourNotes!}...',
                                maxLength: 250,
                                keyboardType: TextInputType.text,
                                controller: textController,
                                maxLines: 5,
                                onTap: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25, left: 35, right: 35),
                              child: SafeArea(
                                  child: CustomButton(
                                      title: locale.saveNotes!,
                                      onTap: () {
                                        if(textController.text!="") {
                                          Navigator.pop(context, 200);
                                        }else{
                                          Navigator.pop(context, 500);
                                          showMessage(message: "الرجاء اضافة نص للملاحظة", context: context);
                                          mystate(() {
                                          });
                                        }
                                      })),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }).whenComplete(() {});


        if (result == 200) {}
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgs/note.svg",
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              locale.addANote!,
              style: blackBoldTextStyle(context: context, fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
