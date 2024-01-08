import 'package:flutter/material.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:shimmer/shimmer.dart';
import '../discussion_widget/comment_widget.dart';

class LoadingCommentTab extends StatelessWidget {
  const LoadingCommentTab({super.key});

  @override
  Widget build(BuildContext context) {
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

          ], hadeComment: Comment(
            avatar: "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
            userName: "********",
            content:"*********"),
        ),
      ),
    );
  }
}