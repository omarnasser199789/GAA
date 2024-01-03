import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../injection_container.dart';
import '../../bloc/my_courses_bloc.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key,required this.comments,required this.hadeComment});
  final List<Comment> comments;
  final Comment hadeComment;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment, Comment>(
      widget. hadeComment,

      widget.comments,
      treeThemeData:
      TreeThemeData(lineColor: Theme.of(context).scaffoldBackgroundColor//Colors.grey[500]!
          , lineWidth: 0),
      avatarRoot: (context, data) =>  PreferredSize(
        preferredSize: const Size.fromRadius(18),
        child: SizedBox(
            width: 40,
            height: 40,
            child:CachedNetWorkImage(
              borderRadius: BorderRadius.circular(200),
              url: data.avatar,
              boxFit: BoxFit.cover,
            )
        ),
      ),
      avatarChild: (context, data) =>  PreferredSize(
        preferredSize: const Size.fromRadius(12),
        child:   Padding(
          padding: const EdgeInsets.only(right: 50),
          child: SizedBox(
              width: 30,
              height: 30,
              child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),url: data.avatar,)
          ),
        ),
      ),
      contentChild: (context, data) {
        return Padding(
          padding: const EdgeInsets.only(right: 0,left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.userName!,
                      style:blackBoldTextStyle(fontSize: 14, context: context),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style:blackRegularTextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      contentRoot: (context, data) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color:Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.userName!,
                          style: blackBoldTextStyle(fontSize: 14, context: context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: blackBoldTextStyle(fontSize: 12, context: context,height: 1.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: iconsColor.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (contextt, __, ___) {

        return BlocProvider(
            create: (BuildContext context) => sl<MyCoursesBloc>(),
            child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    print("State:$state");
                  }
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom:33 ),
                        child: SafeArea(
                          child: Container(
                            height: 231,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 17),
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Scaffold(
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 23),
                                      child: Text(
                                        "حذف/ تعديل تعليق ",
                                        style: blackBoldTextStyle(
                                            context: context, fontSize: 12,color: hintTextColor),
                                      ),
                                    ),
                                    Container(height: 0.1, width:double.infinity,color: Theme.of(context).canvasColor,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svgs/edit.svg",
                                          color:Theme.of(context).canvasColor,
                                          width: 18,
                                        ),
                                        const SizedBox(width: 11,),
                                        Text(
                                          "تعديل تعليق ",
                                          style: blackBoldTextStyle(
                                              context: context, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Container(height: 0.1, width:double.infinity,color: Theme.of(context).canvasColor,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svgs/deleteIcon.svg",
                                          color: Colors.red,
                                          width: 18,
                                        ),
                                        const SizedBox(width: 11,),

                                        Text(
                                          "حذف تعليق",
                                          style: blackBoldTextStyle(
                                              context: context, fontSize: 14,color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Container(height: 0.1, width:double.infinity,color: Theme.of(context).canvasColor,),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 23),
                                      child: Text(
                                        "الغاء الأمر",
                                        style: blackBoldTextStyle(
                                            context: context, fontSize: 12,color: hintTextColor),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),


                          ),
                        ),
                      ),
                    ],
                  );

                }));
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
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

      }
    });
  }
}