/// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/injection_container.dart';
import '../../../../../../core/functions.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../../../domain/use_cases/add_comment_usecase.dart';
import '../../../bloc/my_courses_bloc.dart';
import '../../../bloc/my_courses_event.dart';
import '../../../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/discussion_model.dart';

/// Widget class for adding a comment
class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({
    Key? key,
    required this.lectureId,
    required this.timeline,
    required this.mediaQueryPadding
  }) : super(key: key);

  final int lectureId;
  final List<Timeline> timeline;
  final EdgeInsets mediaQueryPadding;

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

/// State class for the AddCommentWidget
class _AddCommentWidgetState extends State<AddCommentWidget> {
  final double horizontalPadding = 20;
  // Global key for the FlutterMentionsState
  final GlobalKey<FlutterMentionsState> _key = GlobalKey<FlutterMentionsState>();
  /// List of mentions for the user
  List<Map<String, dynamic>> _mentionUserList = [];

  /// Method to initialize the mention user list
  Future<void> _initMentionUserList() async {
    _mentionUserList = widget.timeline.map((item) {
      return {
        'id': '${item.id}',
        'display': item.username.replaceAll(' ', ''),
        'full_name': item.username,
        'style': const TextStyle(color: Colors.blue),
        'photo': item.useravatar,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initMentionUserList(),
      builder: (context, snapshot) {
        return BlocProvider(
          create: (BuildContext context) => sl<MyCoursesBloc>(),
          child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
              return Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildCommentContainer(context),
                      _buildSendButton(context),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Widget for building the comment container
  Widget _buildCommentContainer(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.83 - horizontalPadding,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FlutterMentions(
        key: _key,
        suggestionListDecoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        suggestionPosition: SuggestionPosition.Top,
        maxLines: 5,
        minLines: 1,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "اضف تعليق ...",
          hintStyle: blackBoldTextStyle(context: context, fontSize: 12, color: hintTextColor),
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
            style: blackBoldTextStyle(fontSize: 15, context: context, color: Theme.of(context).primaryColor),
            data: _mentionUserList,
            matchAll: false,
            suggestionBuilder: (data) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(data['photo']),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        children: <Widget>[
                          Text(
                            data['full_name'],
                            style: blackBoldTextStyle(fontSize: 12, context: context, color: Theme.of(context).canvasColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Widget for building the send button
  Widget _buildSendButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_key.currentState!.controller!.markupText.isNotEmpty) {
          BlocProvider.of<MyCoursesBloc>(context).add(
            AddCommentEvent(
              addCommentParams: AddCommentParams(
                id: null,
                discussionId: null,
                lectureId: widget.lectureId,
                trainerId: null,
                userId: userId(),
                message: _key.currentState!.controller!.markupText,
                isReplied: false,
                orginialId: null,
                updateAt: DateTime.now(),
                addedDate: DateTime.now(),
              ),
            ),
          ); /// => SuccessAddComment
        } else {
          showMessage(message: "الرجاء اضافة تعليق", context: context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Icon(Icons.send, color: iconsColor, size: 30),
      ),
    );
  }
}
