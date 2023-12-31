import 'package:flutter/material.dart';
import 'package:acadmiat/Theme/style.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../domain/use_cases/add_comment_usecase.dart';
import '../bloc/my_courses_bloc.dart';
import '../bloc/my_courses_event.dart';
import '../bloc/my_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({Key? key,required this.lectureId}) : super(key: key);
  final int lectureId;


  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
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

  @override
  Widget build(BuildContext context) {


    Size size =MediaQuery.of(context).size;

    return FutureBuilder<dynamic>(
        future: init(),
    builder: (context, snapshot) {

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("State:$state");
              }
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
                            // border: Border.all(
                            //   color: Theme.of(context).primaryColor,
                            //   width: 1
                            // )
                          ),
                          suggestionPosition: SuggestionPosition.Top,
                          maxLines: 5,
                          minLines: 1,
                          // keyboardType: TextInputType.multiline,
                          keyboardType:TextInputType.text ,


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
                            // Mention(
                            //   trigger: '#',
                            //   disableMarkup: true,
                            //   style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),
                            //
                            //   data: [
                            //     {'id': 'reactjs', 'display': 'reactjs'},
                            //     {'id': 'javascript', 'display': 'javascript'},
                            //   ],
                            //   matchAll: true,
                            // )
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
            }));

        });







  }
}


class MentionUser{
  String id;
  String display;
  String fullName;
  String photo;
  MentionUser({
    required this.id,
    required this.display,
    required this.fullName,
    required this.photo
  });

}