import 'package:flutter/material.dart';
import '../../../../../core/classes/constants.dart';
import '../../../domain/entities/my_lecture_entity.dart';
import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/functions.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';
import '../../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/discussion_entity.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/add_comment_widget.dart';
import '../discussion_widget/comment_widget.dart';
import 'loading_comment_tab.dart';

class CommentTabWidget extends StatefulWidget {
  const CommentTabWidget({super.key,required this.myLectureEntity,required this.lectureId});
  final MyLectureEntity myLectureEntity;
  final int lectureId;
  @override
  State<CommentTabWidget> createState() => _CommentTabWidgetState();
}

class _CommentTabWidgetState extends State<CommentTabWidget> {

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
                  discussionEntity =DiscussionEntity(discussionId: state.discussionEntity.discussionId, lectureId: state.discussionEntity.lectureId, timeline: state.discussionEntity.timeline.reversed.toList());

                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      (discussionEntity.timeline.isNotEmpty)?
                      ListView.builder(
                          itemCount: discussionEntity.timeline.length,
                          itemBuilder: (context,index){
                            comments.clear();
                            for(var item in discussionEntity.timeline[index].replies!){
                              comments.add(Comment(avatar: item.useravatar, userName: item.username, content: parseHtmlString(item.message)));
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

                      AddCommentWidget(lectureId: widget.lectureId,timeline: state.discussionEntity.timeline.reversed.toList(),),
                    ],
                  );
                }
            return LoadingCommentTab();
              })
      );
    }
    else{
      return Container();
    }
  }
}
