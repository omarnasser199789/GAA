
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/discussion_widget/comment_widget.dart';
import '../../../../../widgets/discussion_widget/discussion_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:comment_tree/data/comment.dart';

class LoadingLecturePage extends StatelessWidget {
  const LoadingLecturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.03,
        ),
        AspectRatio(
          aspectRatio: 16/9,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor:
            const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
            child: Container(
              width: double.infinity,
              height: size.height*0.36,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor:
            const Color.fromRGBO(119, 118, 118, 0.5490196078431373),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 17, right: 17, top: 17),
              child: CommentWidget(
                comments: [
                  Comment(
                      avatar:
                      "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
                      userName: "  ",
                      content:
                      " *************************************** "),
                  Comment(
                      avatar:
                      "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
                      userName: "  ",
                      content:
                      " *************************************** "),
                ],
                hadeComment: Comment(
                    avatar:
                    "https://d277bwtxqorw7z.cloudfront.net/trainer.jpg",
                    userName: "********",
                    content: "*********"),
              ),
            ),
          ),
        )
      ],
    );
  }
}