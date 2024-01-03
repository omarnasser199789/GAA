import 'package:acadmiat/core/widgets/empty_state_widget.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../injection_container.dart';
import '../../../../profile_feature/presentation/bloc/bloc.dart';
import '../../../data/models/my_course_model.dart';
import 'package:jiffy/jiffy.dart';
import '../../../domain/use_cases/topic_reply_usecase.dart';
import '../../bloc/my_courses_bloc.dart';
import '../../bloc/my_courses_event.dart';

class RepliesPage extends StatefulWidget {
  const RepliesPage({super.key,required this.topic});

  final Topic topic;
  @override
  State<RepliesPage> createState() => _RepliesPageState();
}

class _RepliesPageState extends State<RepliesPage> {

  bool msgShow=false;
  List<Widget> widgetsList=[];
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Jiffy.locale("ar");
    updateData(size);

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if(state is SuccessTopicReplyState){
            int i=0;
            for(var item in  widget.topic.replies){
              if(item.replyId==state.topicReplyEntity.id) {
                i++;
              }
            }
            if(i==0){
              widget.topic.replies.add(Reply(replyId: state.topicReplyEntity.id,
                  addedBy: userId().toString(),
                  reply:  state.topicReplyEntity.reply,
                  attachment: null, date: state.topicReplyEntity.date,));

             updateData(size);
              if (msgShow) {
                showMessage(message: "تم ارسال تعليقك",bgColor:Colors.green ,context: context,);
                msgShow = false;
              }
            }
          }

          return Scaffold(
            appBar:appBarWidget("النقاشات",context,true,null,null),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        children: widgetsList,
                      ),
                    ),
                  ),
                ),

                SafeArea(
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
                                  data:[],
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
                                            const SizedBox(width: 10.0),
                                            Column(
                                              children: <Widget>[
                                                Text(data['full_name'],style: blackBoldTextStyle(fontSize: 12, context: context,color: Theme.of(context).canvasColor),),
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
                              msgShow=true;
                              if(key.currentState!.controller!.markupText!=""){
                                BlocProvider.of<MyCoursesBloc>(context).add(
                                    TopicReplyEvent(params:
                                    TopicReplyParams(
                                        id: null,
                                        topicId: widget.topic.topicId,
                                        userId: userId(),
                                        reply: key.currentState!.controller!.markupText,
                                        attachment: '', date: DateTime.now())
                                    ));

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
                )
              ],
            ),
          );
        }
    ));
  }

  void updateData(size) {
    widgetsList=[];
    widgetsList.add(Padding(
      padding: const EdgeInsets.only(top:10,left: 17,right: 17),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
            child: Text(widget.topic.topic,style: blackBoldTextStyle(fontSize: 11,height: 1.5, context: context,),),
          )),
    ));


    if(widget.topic.replies.isNotEmpty) {
      for (var item in widget.topic.replies) {
        widgetsList.add(Padding(
          padding: const EdgeInsets.only(top: 10, left: 17, right: 17),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(color: Theme.of(context).canvasColor.withOpacity(0.1), borderRadius: BorderRadius.circular(200)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(ImgAssets.profileIcon),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.addedBy, style: blackBoldTextStyle(fontSize: 12, context: context),),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(Jiffy(item.date).yMMMdjm,
                                  style: blackBoldTextStyle(fontSize: 11, context: context, color: iconsColor),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: Text(
                      textWidthBasis: TextWidthBasis.longestLine,
                      parseHtmlString(item.reply),
                      style: blackBoldTextStyle(fontSize: 11, height: 1.5, context: context,),),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    }else{
      widgetsList.add( Padding(
        padding: const EdgeInsets.only(top:100),
        child: EmptyStateWidget(svg: ImgAssets.reply, text1:"لا توجد ردود!",text3: "قم باضافة اول رد",),
      ));
    }
  }
}
