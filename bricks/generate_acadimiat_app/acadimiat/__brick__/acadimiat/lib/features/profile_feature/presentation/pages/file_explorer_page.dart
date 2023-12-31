import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/svg_code_widget.dart';
import '../../../../injection_container.dart';
import '../../../my_courses_feature/data/models/files_model.dart';
import '../../../my_courses_feature/domain/entities/files_entity.dart';
import '../../../my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../../../my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../../../my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:open_filex/open_filex.dart';
class FileExplorerPage extends StatefulWidget {
  const FileExplorerPage({Key? key}) : super(key: key);

  @override
  State<FileExplorerPage> createState() => _FileExplorerPageState();
}

class _FileExplorerPageState extends State<FileExplorerPage> {
  List<Widget> widgetList=[];
  bool firstTime = true;
  FilesEntity  filesEntity =FilesEntity(index: 0,items: []);
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("state:$state");
              }
              if(state is Empty){
                BlocProvider.of<MyCoursesBloc>(context).add(GetAllFilesEvent());
              }
              if(state is SuccessDeleteFileFromDBState){
                BlocProvider.of<MyCoursesBloc>(context).add(GetAllFilesEvent());
               widgetList=[];
                 firstTime = true;
              }

              if(state is SuccessGetFileEntityState){

                if(firstTime) {
                  firstTime=false;
                  filesEntity=state.filesEntity;

                  for (var item in state.filesEntity.items) {
                    widgetList.add(GestureDetector(
                      onTap: () async {
                        /// Checks whether the file system entity with this path exists.
                        bool fileExists = await File(item.path).exists();
                        if (kDebugMode) {
                          print(fileExists);
                        }
                        if(fileExists) {
                          try {
                            OpenFilex.open(item.path);
                          } catch (e) {
                            if (kDebugMode) {

                              print("ERROR");
                              print(e);
                            }
                          }
                        }else{

                          showMessage(message: "هذا الملف غير موجود، سيتم حذفه من هذه القاءمة", context: context,bgColor: Colors.red);
                          Future.delayed(const Duration(milliseconds: 5000), () {
                            showCustomDialog(context,item);
                          });

                          setState(() {

                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .cardColor,
                              borderRadius:
                              BorderRadius.circular(5),
                              border: Border.all(
                                  color: Theme
                                      .of(context)
                                      .cardColor,
                                  width: 1)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 17,right: 17,top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  getIcon(
                                      fileName: item.path),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    // color: Colors.red,
                                    width: size.width - 120,
                                    child: Text(item.name,
                                      maxLines: 1,
                                      style:
                                      blackBoldTextStyle(
                                          context:
                                          context,
                                          fontSize: 11),
                                    ),
                                  ),
                                ],),



                                GestureDetector(
                                  onTap: (){
                                    showCustomDialog(context,item);

                                  },
                                  child: SvgPicture.asset(
                                    "assets/svgs/deleteIcon.svg",
                                    color: iconsColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                }
              }
              return Scaffold(
                appBar:appBarWidget("ملفاتي",context,true,

                    (widgetList.length>1)?[Padding(
                  padding: const EdgeInsets.only(top:20,left: 5,right: 5),
                  child: GestureDetector(
                      onTap: (){
                        showCustomDialog(context,null);
                      },
                      child: Text("حذف الكل",style: blackBoldTextStyle(fontSize: 15, context: context,color: Colors.red),)),
                ),]:null,null),
                body: (widgetList.isNotEmpty)? SingleChildScrollView(

                  child:

                  Column(
                    children: widgetList,
                  ),

                  // Container(
                  //   width: size.width,
                  //   height: size.height-200,
                  //
                  //   // alignment: Alignment.center,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     // crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         width: size.width,
                  //         child:  SvgCodeWidget(svg: "assets/svgs/files_empty_state.svg",)
                  //
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(top:30),
                  //         child: Text("لا توجد ملفات!",style: blackBoldTextStyle(fontSize: 16, context: context),),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(top:15),
                  //         child: Container(
                  //             width: 220,
                  //             alignment: Alignment.center,
                  //             child: Text("عند تنزيل ايه ملف خلال فترة التعلم سوف تجده هنا",
                  //               textAlign: TextAlign.center,
                  //               style: blackBoldTextStyle(fontSize: 12,context: context,height: lineSpace),)),
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                ): const EmptyStateWidget(svg:"assets/svgs/files_empty_state.svg",
                  text1:"لا توجد ملفات!",
                  text3: "عند تنزيل ايه ملف خلال فترة التعلم سوف تجده هنا",
                ),
              );
            }));





  }
  void showCustomDialog(BuildContext context,Item ? item) {
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
        if(item==null) {
          BlocProvider.of<MyCoursesBloc>(context).add(DeleteAllFilesFromDBEvent(
              files: FilesModel(index: 0, items: filesEntity.items)));
        }else{
          BlocProvider.of<MyCoursesBloc>(context).add(DeleteFileFromDBEvent(
              files:FilesModel(index: 0, items: [item])));
        }
        // bookMarksWidgetKey.currentState!.bookmarkIdForDelete = bookmarkId;
        // bookMarksWidgetKey.currentState!.successDeleteBookmark=false;
        // BlocProvider.of<MyCoursesBloc>(context)
        //     .add(DeleteBookmarkEvent(bookmarkId: bookmarkId));
      }
    });
  }
}
