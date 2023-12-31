
import 'package:acadmiat/features/my_courses_feature/data/models/my_lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../../Locale/locale.dart';
import '../../../../../../../Theme/style.dart';
import '../../../../../../../core/globals.dart';
import '../../../../../../../core/widgets/custom_botton.dart';
import '../../../../../../../../../../../../core/widgets/custom_text_field.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../../../../injection_container.dart';
import '../../../../../../core/functions.dart';
import '../../../../domain/use_cases/add_bookmark_usecase.dart';
import '../../../bloc/my_courses_bloc.dart';
import '../../../bloc/my_courses_event.dart';
import '../../../widgets/bookmark_widget/add_bookmark_button.dart';

class NotesTab extends StatefulWidget {
  const NotesTab({
    Key? key,
    required this.videoId,
    required this.isVimeo,
  }) : super(key: key);
  final bool isVimeo;
  final int videoId;

  @override
  State<NotesTab> createState() => NotesTabState();
}
bool addBookMark = false;

class NotesTabState extends State<NotesTab> {

  void removeBookmarks(int id) {
    for (int i = 0;
        lecturePageKey
                .currentState!.myLectureEntity.currentVideo.bookmarks.length >
            i;
        i++) {
      // print(i);
      if (id ==
          lecturePageKey
              .currentState!.myLectureEntity.currentVideo.bookmarks[i].id) {
        // print("Item deleted is $i");
        lecturePageKey.currentState!.myLectureEntity.currentVideo.bookmarks
            .removeAt(i);
      }
    }
    setState(() {});
  }

  TextEditingController textController = TextEditingController();
  bool editBookMark = false;
  late int bookmarkIdForDelete;
  // bool addBookmarks = true;
  bool showMsg = true;

  List<Bookmark> bookmarks =[];
  bool successDeleteBookmark = true;
  // TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bookmarks =
        lecturePageKey.currentState!.myLectureEntity.currentVideo.bookmarks;

    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is SuccessDeleteBookmark) {
            if(!successDeleteBookmark) {
              deleteBookMark(bookmarkIdForDelete);
            }
          }

          if (state is SuccessAddBookmarkEntity) {


            if(editBookMark) {
              editBookMark=false;
              editBookmark(state);
            }
            if(addBookMark){
              addBookMark=false;
              addBookmark(state);
            }
          }


          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {



                  // vimeoVideoWidgetKey.currentState!.stzopVideo();
                  amazonVideoWidgetKey.currentState!.stopVideo();
                  final result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        textController.text="";

                        return Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter mystate) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 17, right: 17),
                                  child:

                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
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
                                              Text(locale.addANote!,
                                                  style: blackBoldTextStyle(
                                                      context: context, fontSize: 15)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 19,
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: CustomTextField(
                                            title: '',
                                            hint: '${locale.writeYourNotes!}...',
                                            maxLength: 250,
                                            keyboardType: TextInputType.text,
                                            controller: textController,
                                            maxLines: 5,
                                            onTap: () {},
                                            onChange: (value){
                                              if (value == null || value=="") {
                                                return 'الرجاء ادخال نص الملاحظة';
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 25, left: 35, right: 35,top:10),
                                          child: SafeArea(
                                              child: CustomButton(
                                                  title: locale.saveNotes!,
                                                  onTap: () {
              FormState form =  _formKey.currentState!;
              if (form.validate()) {

                if(textController.text!="") {
                  Navigator.pop(context, 200);
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
                      }).whenComplete(() { });


                  if (result == 200) {
                    // addBookMark=true;
                    // BlocProvider.of<MyCoursesBloc>(context)
                    //     .add(AddBookmarkEvent(
                    //     addBookMarkParams: AddBookMarkParams(
                    //         videoId: widget.videoId,
                    //         userId: userId(),
                    //         atTime: convertDateTimeToSecond((widget.isVimeo)
                    //             ? vimeoVideoWidgetKey
                    //             .currentState!
                    //             .tempDate
                    //             : amazonVideoWidgetKey
                    //             .currentState!
                    //             .tempDate),
                    //         id: null,
                    //         note: textController
                    //             .text)));

                  }


                },
                backgroundColor: kMainColor,
                child: SvgPicture.asset(
                  "assets/svgs/bookmark.svg",
                  color: Colors.white,
                  width: 18,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 27, right: 27, bottom: 10, top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       AddBookmarkButton(
                  //         isVimeo: widget.isVimeo,
                  //         allowSelectLecture: false,
                  //         videoId: widget.videoId,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  (bookmarks.isNotEmpty)?
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17, top: 8),
                    child: SizedBox(
                      height: 149 * bookmarks.length / 1,

                      // color: Colors.red,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookmarks.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (widget.isVimeo) {
                                  // vimeoVideoWidgetKey.currentState!.geTo(
                                  //     second:
                                  //     int.parse("${bookmarks[index].atTime}"),
                                  //     clipId: bookmarks[index]
                                  //         .video!
                                  //         .clipId
                                  //         .toString());
                                } else {
                                  amazonVideoWidgetKey.currentState!.geTo(
                                    second:
                                    int.parse("${bookmarks[index].atTime}"),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(15),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.1),
                                    //     spreadRadius: 5,
                                    //     blurRadius: 7,
                                    //     offset: Offset(0,
                                    //         3), // changes position of shadow
                                    //   ),
                                    // ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13, right: 13),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 14),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                SvgPicture.asset(
                                                  "assets/svgs/video.svg",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                  TextDirection.ltr,
                                                  child: Text(
                                                    formatedTime(
                                                        time: bookmarks[index]
                                                            .atTime),
                                                    style: blackBoldTextStyle(
                                                        context: context,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 13),
                                                  ),







                                                ),
                                              ],),

                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      showMsg=true;//
                                                      showCustomDialog(context, bookmarks[index].id);
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/svgs/deleteIcon.svg",
                                                      color: iconsColor,
                                                      width: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      textController.text= bookmarks[index].note;
                                                      final result = await showModalBottomSheet(
                                                          context: context,
                                                          backgroundColor: Colors.transparent,
                                                          isScrollControlled: true,
                                                          builder: (context) {

                                                            return Material(
                                                              color: Theme.of(context).scaffoldBackgroundColor,
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
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text("تعديل الملاحظة", style: blackBoldTextStyle(context: context, fontSize: 15)),
                                                                              ],
                                                                            ),
                                                                          ),

                                                                          Padding(
                                                                            padding:  EdgeInsets.only(top: 19, bottom: MediaQuery.of(context)
                                                                                .viewInsets
                                                                                .bottom),
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
                                                                                bottom: 25,
                                                                                left: 35,
                                                                                right: 35),
                                                                            child: SafeArea(
                                                                                child: CustomButton(
                                                                                    title: "تعديل الملاحظة",
                                                                                    onTap: () {
                                                                                      Navigator.pop(context, 200);
                                                                                    })),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                            );

                                                          }).whenComplete(() {});





                                                      if (result == 200) {
                                                        editBookMark = true;
                                                        showMsg=true;
                                                        bookmarkIdForDelete =
                                                            bookmarks[index]
                                                                .id;
                                                        BlocProvider.of<MyCoursesBloc>(context).add(AddBookmarkEvent(
                                                            addBookMarkParams: AddBookMarkParams(
                                                                videoId: widget
                                                                    .videoId,
                                                                userId:
                                                                userId(),
                                                                atTime: bookmarks[
                                                                index]
                                                                    .atTime,
                                                                id: bookmarks[
                                                                index]
                                                                    .id,
                                                                note: textController
                                                                    .text)));
                                                      }

                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/svgs/edit.svg",
                                                      color: iconsColor,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 10,bottom: 30),
                                          child: Text(
                                            bookmarks[index].note,
                                            style: blackBoldTextStyle(
                                                fontSize: 12,
                                                height: 2,
                                                context: context,
                                                // color: Theme.of(context)
                                                //     .accentColor
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ):
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top:size.height*0.15),
                        child: SvgPicture.asset(
                          "assets/svgs/notes.svg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  void deleteBookMark(int bookmarkIdForDelete) {
    successDeleteBookmark=true;
    Future.delayed(Duration.zero, () {

      removeBookmarks(bookmarkIdForDelete);
      if(showMsg) {
        showMsg=false;
        showMessage(message: "تم الحذف بنجاح", context: context,bgColor: percentIndicatorColor);
      }
    });
  }

  void editBookmark(state) {
    String message ="";
    Future.delayed(Duration.zero, () {


        message ="تم التعديل بنجاح";

        for(int i=0; i<lecturePageKey.currentState!.myLectureEntity.currentVideo.bookmarks.length;i++){
          if(lecturePageKey.currentState!.myLectureEntity.currentVideo.bookmarks[i].id==state.bookmarkEntity.id) {
            lecturePageKey.currentState!.myLectureEntity.currentVideo
                .bookmarks[i] = Bookmark(
                id: state.bookmarkEntity.id,
                userId: state.bookmarkEntity.userId,
                videoId: state.bookmarkEntity.videoId,
                atTime: state.bookmarkEntity.atTime,
                note: state.bookmarkEntity.note,
                video: state.bookmarkEntity.video,
                user: state.bookmarkEntity.user);
          }
        }
        bookmarks = lecturePageKey.currentState!.myLectureEntity.currentVideo.bookmarks;
        setState(() {

        });
      if(showMsg) {
        showMessage(message: message, context: context);
        showMsg=false;
      }


    });
  }
  void addBookmark(state) {
    String message ="";
    Future.delayed(Duration.zero, () {


      message = "تم اضافة بنجاح";
      int i = 0;
      for (var item in lecturePageKey.currentState!.myLectureEntity
          .currentVideo.bookmarks) {
        if (item.id == state.bookmarkEntity.id) {
          i++;
        }
      }


      if (i == 0) {
        lecturePageKey.currentState!.myLectureEntity.currentVideo
            .bookmarks
            .add(Bookmark(
            id: state.bookmarkEntity.id,
            userId: state.bookmarkEntity.userId,
            videoId: state.bookmarkEntity.videoId,
            atTime: state.bookmarkEntity.atTime,
            note: state.bookmarkEntity.note,
            video: state.bookmarkEntity.video,
            user: state.bookmarkEntity.user)
        );
        bookmarks =
            lecturePageKey.currentState!.myLectureEntity.currentVideo
                .bookmarks;
        // BlocProvider.of<MyCoursesBloc>(context).add(ResetEvent());

      }




      if(showMsg) {
        showMessage(message: message, context: context,bgColor: percentIndicatorColor);
        showMsg=false;
      }

      setState(() {

      });

    });
  }
}

void showCustomDialog(BuildContext context, int bookmarkId) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: iconsColor.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (contextt, __, ___) {
      var locale = AppLocalizations.of(context)!;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
        body: BlocProvider(
            create: (BuildContext context) => sl<MyCoursesBloc>(),
            child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print("State:$state");
                  }
                  return Center(
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Scaffold(
                          body: Padding(
                            padding: const EdgeInsets.only(right: 27, left: 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 17, bottom: 9.7),
                                  child: Text(
                                    locale.confirmDeletion!,
                                    style: blackBoldTextStyle(
                                        context: context, fontSize: 14),
                                  ),
                                ),
                                Text(
                                  locale.areSureOfTheDeletingProcess!,
                                  style: blackBoldTextStyle(
                                      context: context, fontSize: 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 21),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(contextt);
                                          },
                                          child:Container(
                                            color: Theme.of(context).scaffoldBackgroundColor,

                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Text(
                                                locale.noCancelTheDeletion!,
                                                style: blackBoldTextStyle(
                                                    context: context,
                                                    fontSize: 12,
                                                    color:
                                                    Theme.of(context).primaryColor),
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 52,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(contextt, 200);
                                          },
                                          child: Container(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(7),
                                              child: Text(
                                                locale.yesIWantToDelete!,
                                                style: blackBoldTextStyle(
                                                    context: context,
                                                    fontSize: 12,
                                                    color:
                                                    Theme.of(context).primaryColor),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                })),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  ).then((value) {
    if (value == 200) {
      bookMarksWidgetKey.currentState!.bookmarkIdForDelete = bookmarkId;
      bookMarksWidgetKey.currentState!.successDeleteBookmark=false;
      BlocProvider.of<MyCoursesBloc>(context)
          .add(DeleteBookmarkEvent(bookmarkId: bookmarkId));
    }
  });
}
