import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/discussion_entity.dart';
import '../bloc/my_courses_bloc.dart';
import '../bloc/my_courses_event.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
class DiscussionWidget extends StatefulWidget {
  const DiscussionWidget({Key? key,required this.lectureId}) : super(key: key);
  final int lectureId;


  @override
  State<DiscussionWidget> createState() => DiscussionWidgetState();
}
 // int lectureIdToGetDiscussion=0;
class DiscussionWidgetState extends State<DiscussionWidget> {
 late DiscussionEntity discussionEntity;
  final List<Comment> comments=[];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state)
        {
      if (kDebugMode) {
        print("State:$state");
      }

      if (state is Empty) {
        BlocProvider.of<MyCoursesBloc>(context).add(GetDiscussionEvent(lectureId: widget.lectureId));
      }

      if(state is SuccessGetDiscussionEntity){

        discussionEntity=state.discussionEntity;

      return (state.discussionEntity.timeline.isNotEmpty)?
        ListView.builder(
        itemCount: state.discussionEntity.timeline.length,
          itemBuilder: (context,index){

            comments.clear();

            for(var item in state.discussionEntity.timeline[index].replies!){
              print(item.useravatar);
              comments.add(

                  Comment(
                  avatar: item.useravatar,
                  userName: item.username,
                  content: parseHtmlString(item.message)));

            }


        return Padding(
          padding: const EdgeInsets.only(left: 17,right: 17,top:17),
          child: CommentWidget(

            comments: comments

            ,hadeComment:
          Comment(
                  avatar: state.discussionEntity.timeline[index].useravatar,
                  userName: state.discussionEntity.timeline[index].username,
                  content: parseHtmlString(state.discussionEntity.timeline[index].message)),
              ),
        );

        }):
      Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom:size.height*0.1,top:80 ),
            child: SvgPicture.asset(
              "assets/svgs/discussion.svg",
              width: 180,
            ),//
          ),
          Text("لا توجد تعليقات!",style: blackBoldTextStyle(fontSize: 15, context: context),),
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text("قم باضافة اول تعليق",style: blackBoldTextStyle(fontSize: 11, context: context),),
          ),
        ],//
      );

      }


      return Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
        child: Padding(
          padding: const EdgeInsets.only(left: 17,right: 17,top:17),
          child: CommentWidget(

            comments: [  Comment(
                avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
                userName: "  ",
                content: " *************************************** "),
              Comment(
                  avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
                  userName: "  ",
                  content: " *************************************** "),

            ]

            ,hadeComment:
          Comment(
              avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
              userName: "********",
              content:"*********"),
          ),
        ),
      );


    }));
  }
}


class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key,required this.comments,required this.hadeComment}) : super(key: key);
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
        child: SizedBox(
            width: 40,
            height: 40,
            child:CachedNetWorkImage(
              borderRadius: BorderRadius.circular(200),
              url: data.avatar,
              boxFit: BoxFit.cover,
            )
        ),
        preferredSize: Size.fromRadius(18),
      ),
      avatarChild: (context, data) =>  PreferredSize(
        child:   Padding(
          padding: const EdgeInsets.only(right: 50),
          child: SizedBox(
              width: 30,
              height: 30,
              child:CachedNetWorkImage(borderRadius: BorderRadius.circular(200),url: data.avatar,)
          ),
        ),

        preferredSize: Size.fromRadius(12),
      ),
      contentChild: (context, data) {
        return Padding(
          padding: const EdgeInsets.only(right: 0,left: 0),
          //
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
              // DefaultTextStyle(
              //   style: Theme.of(context).textTheme.caption!.copyWith(
              //       color: Colors.grey[700], fontWeight: FontWeight.bold),
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 4),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 8,
              //         ),
              //         Text('Like'),
              //         SizedBox(
              //           width: 24,
              //         ),
              //         Text('Reply'),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
      contentRoot: (context, data) {
        return Container(
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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

                        // GestureDetector(
                        //   onTap: (){
                        //     showCustomDialog(context);
                        //   },
                        //   child: Container(
                        //     width: 22,
                        //     height: 22,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       color: const Color.fromRGBO(200, 200, 200, 0.2),
                        //       borderRadius: BorderRadius.circular(5)
                        //     ),
                        //
                        //     child: SvgPicture.asset(
                        //       "assets/svgs/more.svg",
                        //       color: Theme.of(context).canvasColor,
                        //     ),
                        //   ),
                        // ),
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
              // DefaultTextStyle(
              //   style: Theme.of(context).textTheme.caption!.copyWith(
              //       color: Colors.grey[700], fontWeight: FontWeight.bold),
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 4),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 8,
              //         ),
              //         Text('Like'),
              //         SizedBox(
              //           width: 24,
              //         ),
              //         Text('Reply'),
              //       ],
              //     ),
              //   ),
              // )
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
        var locale = AppLocalizations.of(context)!;

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
                                          SizedBox(width: 11,),
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
