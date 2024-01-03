import 'package:flutter/material.dart';
import '../../../../core/classes/constants.dart';
import '../../../../core/globals.dart';
import '../../domain/entities/my_lecture_entity.dart';
import 'package:measure_size/measure_size.dart';
import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/functions.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../domain/use_cases/add_comment_usecase.dart';
import '../bloc/my_courses_bloc.dart';
import '../bloc/my_courses_event.dart';
import '../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/discussion_entity.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'discussion_widget/comment_widget.dart';

class CommentTabWidget extends StatefulWidget {
  const CommentTabWidget({super.key,required this.myLectureEntity,required this.lectureId});
  final MyLectureEntity myLectureEntity;
  final int lectureId;
  @override
  State<CommentTabWidget> createState() => _CommentTabWidgetState();
}

class _CommentTabWidgetState extends State<CommentTabWidget> {
  double addCommentTabWidgetHeight = 0;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  List<Map<String, dynamic>> mentionUserList=[];
  Future<int> init() async {

    await Future.delayed(const Duration(milliseconds: 500));
    mentionUserList.clear();
    for (var item in discussionWidgetKey.currentState!.discussionEntity.timeline) {
      mentionUserList.add({
        'id': '${item.id}',
        'display': item.username.replaceAll(' ', ''),
        'full_name': item.username,
        'style': const TextStyle(color: Colors.blue),
        'photo': item.useravatar
      },);
    }
    return 200;
  }
  late DiscussionEntity discussionEntity;
  final List<Comment> comments=[];
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    if (widget.myLectureEntity.contents[0].type == Constants.VIDEO) {
      return BlocProvider(create: (BuildContext context) => sl<MyCoursesBloc>(),
          child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
              builder: (context, state) {
           if (kDebugMode) {
           print("State:$state");
           }

             if (state is Empty) {
             BlocProvider.of<MyCoursesBloc>(context).add(GetDiscussionEvent(lectureId: widget.lectureId));/// => SuccessGetDiscussionEntity
             }
             if(state is SuccessAddComment){
               BlocProvider.of<MyCoursesBloc>(context).add(GetDiscussionEvent(lectureId: widget.lectureId));
             }

             if(state is SuccessGetDiscussionEntity){
               discussionEntity =DiscussionEntity(
                   discussionId: state.discussionEntity.discussionId,
                   lectureId: state.discussionEntity.lectureId,
                   timeline: state.discussionEntity.timeline.reversed.toList());
               return Stack(
                 alignment: Alignment.bottomCenter,
                 children: [
                   Padding(
                     padding: EdgeInsets.only(bottom: addCommentTabWidgetHeight),
                     child: (discussionEntity.timeline.isNotEmpty)?
                     ListView.builder(
                itemCount: discussionEntity.timeline.length,
                itemBuilder: (context,index){

                  comments.clear();

                  for(var item in discussionEntity.timeline[index].replies!){
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
                      comments: comments,
                      hadeComment:
                    Comment(
                        avatar: discussionEntity.timeline[index].useravatar,
                        userName: discussionEntity.timeline[index].username,
                        content: parseHtmlString(discussionEntity.timeline[index].message)),
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
            ),
                   ),
                   MeasureSize(
            onChange: (Size newSize) {
              setState(() {
                addCommentTabWidgetHeight =
                    newSize.height;
              });
            },
            child: FutureBuilder<dynamic> (
                future: init(),
                builder: (context, snapshot) {

                  return    SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top:5),
                      child: Row(
                        //
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: size.width*0.84,
                            // height: 50,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: FlutterMentions(
                              // scrollPadding:  const EdgeInsets.only(right: 10,bottom: 5,left: 10),
                              key: key,
                              suggestionListDecoration: BoxDecoration(
                                color:    Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              suggestionPosition: SuggestionPosition.Top,
                              maxLines: 5,
                              minLines: 1,
                              keyboardType:TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "ااضف تعليق ...",
                                hintStyle: blackBoldTextStyle(context: context,fontSize: 12,color: hintTextColor),
                                filled: true,
                                fillColor: textFormFieldFillColor,
                                contentPadding: const EdgeInsets.all(8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).cardColor),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              mentions: [
                                Mention(
                                    trigger: '@',
                                    style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),
                                    data:mentionUserList,
                                    matchAll: false,
                                    suggestionBuilder: (data) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 6,top: 10,left: 6),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          padding: const EdgeInsets.only(right: 10,bottom: 10,left: 10,top: 10),
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius:15,
                                                backgroundImage: NetworkImage(
                                                  data['photo'],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(data['full_name'],style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).canvasColor),),
                                                  // Text('@${data['display']}',style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).canvasColor),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),

                          ),
                          GestureDetector(
                              onTap: (){
                                if(key.currentState!.controller!.markupText!=""){
                                  BlocProvider.of<MyCoursesBloc>(context).add(
                                      AddCommentEvent(addCommentParams:
                                      AddCommentParams(id: null,
                                        discussionId: null,
                                        lectureId: widget.lectureId,
                                        trainerId: null,
                                        userId: userId(),
                                        message: key.currentState!.controller!.markupText,
                                        isReplied: false,
                                        orginialId: null,
                                        updateAt:DateTime.now() ,
                                        addedDate: DateTime.now(),
                                      ))); /// => SuccessAddComment
                                }else{
                                  showMessage(message: "الرجاء اضافة تعليق", context: context);
                                  setState(() {
                                  });
                                }
                              },

                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Icon(Icons.send,color: iconsColor,size: 30,),
                              )),

                        ],
                      ),
                    ),
                  );

                }),

          ),
                 ],
               );
             }
            return Shimmer.fromColors(
              baseColor: Theme.of(context).cardColor,
              highlightColor: const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
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

          ], hadeComment:
        Comment(
            avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
            userName: "********",
            content:"*********"),
        ),
      ),
    );
    }));
    }
    else{
      return Container();
    }
  }
}
