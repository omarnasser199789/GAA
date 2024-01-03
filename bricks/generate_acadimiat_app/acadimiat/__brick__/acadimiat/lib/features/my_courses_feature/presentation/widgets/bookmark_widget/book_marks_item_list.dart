import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../data/models/my_lecture_model.dart';
import '../../../domain/use_cases/add_bookmark_usecase.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';
import '../../../../home_feature/presentation/pages/search_page.dart';

class BookMarksItemList extends StatefulWidget {
  BookMarksItemList(
      {super.key,
      required this.bookmarks,
      required this.atTime,
      required this.theTextOfNote,
      required this.videoId,
      required this.isVimeo,
      required this.index,
      required this.bookmarkId,
      });
  final int videoId;
  final int bookmarkId;
  final bool isVimeo;
  final int atTime;
  List<Bookmark> bookmarks;
  final int index;
  final String theTextOfNote;

  @override
  State<BookMarksItemList> createState() => _BookMarksItemListState();
}

class _BookMarksItemListState extends State<BookMarksItemList> {
  TextEditingController textController = TextEditingController();

  bool checkBoxValue = false;

  @override
  void initState() {
    textController.text = widget.theTextOfNote;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    return GestureDetector(
        onLongPress: () async {
          final result = await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) {
                return BlocProvider(
                    create: (BuildContext context) => sl<MyCoursesBloc>(),
                    child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                        builder: (context, state) {
                      if (kDebugMode) {
                        print("State:$state");
                      }
                      if (state is SuccessDeleteBookmark) {
                        Navigator.pop(context, 200);
                      }
                      if (state is SuccessAddBookmarkEntity) {
                        Navigator.pop(context, 201);
                      }
                      if (state is Error) {
                        Navigator.pop(context, 500);
                      }

                      return StatefulBuilder(
                          builder: (BuildContext context, StateSetter mystate) {
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              height: size.height * 0.65,
                              child: Material(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17, right: 17),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 50,
                                                  height: 3,
                                                  color: Theme.of(context)
                                                      .canvasColor)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("تعديل الملاحظة",
                                                  style: blackBoldTextStyle(
                                                      context: context,
                                                      fontSize: 15)),
                                              GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              MyCoursesBloc>(
                                                          context)
                                                      .add(DeleteBookmarkEvent(
                                                          bookmarkId: widget
                                                              .bookmarkId));
                                                },
                                                child: SvgPicture.asset(
                                                  "assets/svgs/deleteIcon.svg",
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 19),
                                          child: CustomTextField(
                                            title: '',
                                            hint:
                                                '${locale.writeYourNotes!}...',
                                            maxLength: 250,
                                            keyboardType: TextInputType.text,
                                            controller: textController,
                                            maxLines: 5,
                                            onTap: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25, left: 35, right: 35),
                              child: SafeArea(
                                  child: CustomButton(
                                      title: "تعديل الملاحظة",
                                      onTap: () {
                                        setState(() {});

                                        BlocProvider.of<MyCoursesBloc>(context)
                                            .add(AddBookmarkEvent(
                                                addBookMarkParams:
                                                    AddBookMarkParams(
                                                        videoId: widget.videoId,
                                                        userId: userId(),
                                                        atTime: widget.atTime,
                                                        id: widget.bookmarkId,
                                                        note: textController
                                                            .text)));

                                        // Navigator.pop(contextddd);
                                      })),
                            )
                          ],
                        );
                      });
                    }));
              }).whenComplete(() {});
          if (result == 200) {
          } else if (result == 201) {
            showMessage(message: "تم تعديل الملاحظة", context: context);
            setState(() {});
          } else if (result == 500) {
            showMessage(message: "لم يتم الحذف", context: context);
            setState(() {});
          }
        },
        onTap: () {
          if (widget.isVimeo) {
          }
          else {
            amazonVideoWidgetKey.currentState!.geTo(
                second: int.parse("${widget.bookmarks[widget.index].atTime}"));
          }
        },
        child: OptionBox(title: widget.bookmarks[widget.index].note));
  }
}
