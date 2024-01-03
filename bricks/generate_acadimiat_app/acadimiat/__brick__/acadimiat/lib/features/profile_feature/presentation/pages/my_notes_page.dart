import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Locale/locale.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/util/assets_manager.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/custom_botton.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/my_notes_entity.dart';
import '../../domain/use_cases/my_notes/add_new_note_usecase.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

class MyNotePage extends StatefulWidget {
  const MyNotePage({super.key});

  @override
  State<MyNotePage> createState() => _MyNotePageState();
}

class _MyNotePageState extends State<MyNotePage> {

  MyNoteEntity myNoteEntity = MyNoteEntity(id: -1, userId: -1, notes: []);
  List<Widget> widgetList=[];
  TextEditingController textController = TextEditingController();
  bool addBookMark = false;

  @override
  Widget build(BuildContext context) {
    Jiffy.locale("ar");
    var locale = AppLocalizations.of(context)!;

    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }
          if (state is Empty) {
            BlocProvider.of<ProfileBloc>(context).add(GetMyNotes(userId: userId()));
          }
          if(state is MyNotesEntity){
            myNoteEntity=state.myNoteEntity;
          }

          if(state is SuccessDeleteNoteEntity){
            BlocProvider.of<ProfileBloc>(context).add(GetMyNotes(userId: userId()));
            showMessage(message: "تم حذف الملاحظة", context: context,bgColor: Colors.red);
          }
          if(state is SuccessAddNoteEntity){
            BlocProvider.of<ProfileBloc>(context).add(GetMyNotes(userId: userId()));
            showMessage(message: "تم اضافة الملاحظة", context: context,bgColor: percentIndicatorColor);
          }
          if(state is Loading){
            return Scaffold(
                appBar:appBarWidget("دفتر الملاحظات",context,true,null,null),
                body: Padding(
                  padding: const EdgeInsets.only(left: 17,right: 17),
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).cardColor,
                    highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(top:20),
                            child: Container(
                              height:130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                          );
                        }),
                  ),
                )
            );
          }
          widgetList=[];
          for(var item in myNoteEntity.notes){
            widgetList.add(GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
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

                              Directionality(
                                textDirection:
                                TextDirection.ltr,
                                child: Text(
                                    Jiffy(item.createdAt).yMMMMdjm,
                                  style: blackBoldTextStyle(
                                      fontSize: 12,
                                      height: 2,
                                      context: context,
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      textController.text= parseHtmlString(item.notes);
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
                                                            padding: const EdgeInsets.only(bottom: 25, left: 35, right: 35),
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
                                        BlocProvider.of<ProfileBloc>(context)
                                            .add(AddNewNoteEvent(
                                            params: AddNewNoteParams(bookId: myNoteEntity.id, notes: textController.text, createdAt: DateTime.now(),id: item.id)));
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/svgs/edit.svg",
                                      color: iconsColor,
                                      width: 16,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 30,
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      // showMsg=true;//
                                      showCustomDialog(context,item.id);
                                    },
                                    child: SvgPicture.asset(
                                      ImgAssets.deleteIcon,
                                      color: iconsColor,
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
                            parseHtmlString(item.notes),
                            style: blackBoldTextStyle(
                                context: context,
                                fontSize: 13),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
          if(widgetList.isNotEmpty){
            widgetList.add(const SizedBox(height: 65,));
          }

          return Scaffold(
            appBar:appBarWidget("دفتر الملاحظات",context,true,null,null),
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {

                  textController.text="";
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
                                                    mystate(() {});
                                                  }
                                                })),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        );
                      }).whenComplete(() {});


                  if (result == 200) {
                    addBookMark=true;
                    BlocProvider.of<ProfileBloc>(context)
                        .add(AddNewNoteEvent(
                        params: AddNewNoteParams(bookId: myNoteEntity.id, notes: textController.text, createdAt: DateTime.now())));
                  }


                },
                backgroundColor: kMainColor,
                child: SvgPicture.asset(
                  ImgAssets.note_,
                  color: Colors.white,
                  width: 23,
                ),
              ),
            ),
            body:
            (widgetList.isNotEmpty)?
            SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.only(left: 17,right: 17,bottom: 10),
                child:SafeArea(
                  child: Column(
                    children: widgetList,
                  ),
                ),
              ),
            ):
            EmptyStateWidget(svg:ImgAssets.notesEmpty,
              text1:"لم تقم باضافة ملاحظات بعد!",
              text3: "قم باضافة ملاحظتك الاولى",
            ),
          );
        }));
  }

  void showCustomDialog(BuildContext context, int id) {
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
              create: (BuildContext context) => sl<ProfileBloc>(),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (kDebugMode) {
                      print("State:$state");
                    }
                    return Center(
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15)),
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
                                                  style: blackBoldTextStyle(context: context, fontSize: 12,
                                                      color: Theme.of(context).primaryColor),
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
                                                  style: blackBoldTextStyle(context: context, fontSize: 12,
                                                      color: Theme.of(context).primaryColor),
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
        BlocProvider.of<ProfileBloc>(context)
            .add(DeleteNote(id: id));
      }
    });
  }
}
