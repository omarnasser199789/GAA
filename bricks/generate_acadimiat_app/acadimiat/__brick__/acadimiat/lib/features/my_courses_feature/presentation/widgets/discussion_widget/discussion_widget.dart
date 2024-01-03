import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/discussion_entity.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'comment_widget.dart';

class DiscussionWidget extends StatefulWidget {
  const DiscussionWidget({super.key,required this.lectureId});
  final int lectureId;

  @override
  State<DiscussionWidget> createState() => DiscussionWidgetState();
}

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
          return Shimmer.fromColors(baseColor: Theme.of(context).cardColor, highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373), child: Padding(
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



