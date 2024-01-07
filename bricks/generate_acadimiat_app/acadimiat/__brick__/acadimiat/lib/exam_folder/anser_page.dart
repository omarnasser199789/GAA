import 'package:flutter/foundation.dart';
import '../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Theme/style.dart';
import '../core/widgets/custom_botton.dart';
import 'exam_info_page.dart';
import 'exam_page.dart';
import 'package:jiffy/jiffy.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/my_courses_feature/domain/entities/myquizizz_entity.dart';
import '../injection_container.dart';
import '../nav_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key,required this.myQuizizzEntity}) : super(key: key);
  final MyQuizizzEntity myQuizizzEntity;
  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (contextt, __, ___) {
        return Center(
          child: Container(
            height: 220,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(right: 27, left: 27),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 17, bottom: 9.7),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/feather-alert-triangle.svg",
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "هل أنت متأكد من إنهاء الاختبار؟",
                              style: blackBoldTextStyle(
                                  context: context, fontSize: 14),
                            ),
                          ],
                        ), //
                      ),
                      Text(
                        "يتم حساب نتيجة الاختبار عند الانهاء",
                        style: blackBoldTextStyle(
                            context: context, fontSize: 12, color: hintTextColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 17),
                        child: Text(
                          "عدد الأسئلة المجاب عليها",
                          style: blackBoldTextStyle(
                            context: context,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        "${attendanceTable.length}/${widget.myQuizizzEntity.questions.length}",
                        style: blackBoldTextStyle(context: context, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 31),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(contextt);
                                },
                                child: Text(
                                  "تراجع عن الانهاء",
                                  style: blackBoldTextStyle(
                                      context: context,
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor),
                                )),
                            SizedBox(
                              width: 52,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(contextt, 200);
                                },
                                child: Text(
                                  "إنهاء الاختبار",
                                  style: blackBoldTextStyle(
                                      context: context,
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
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
      print("jsnkjcndskjcnsjk");
      print(value);
      if (value == 200) {
        // Navigator.pop(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavPage()),
                (route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    Jiffy.locale("ar");
    String date= Jiffy(DateTime.now()).yMMMMd;


    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if(state is SuccessSubmitQuizState){


          }
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar:appBarWidget(widget.myQuizizzEntity.name,context,false,null,null),
              body:    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                       decoration: BoxDecoration(
                         color: Theme.of(context).cardColor,
                         borderRadius: BorderRadius.circular(10)
                       ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:20,bottom: 20,left: 20,right: 20),
                          child: Column(
                            children: [
                              Text("معلومات المحاولة الاخيرة",style: blackBoldTextStyle(context: context,fontSize: 18),),
                              Padding(
                                padding: const EdgeInsets.only(top:10),
                                child: Text(date,style: blackBoldTextStyle(context: context,fontSize: 17),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20,bottom: 20),
                                child: Container(

                                  decoration: BoxDecoration(
                                      // color: The,
                                      borderRadius:
                                      BorderRadius.circular(200)),
                                  child:  CircularPercentIndicator(
                                    animation: true,
                                    animationDuration: 1000,
                                    radius: 80.0,
                                    lineWidth: 11.0,
                                    percent: attendanceTable.length
                                        / widget.myQuizizzEntity.questions.length,
                                    center: Text(

                                      "${attendanceTable.length}/${widget.myQuizizzEntity.questions.length}",
                                      style:
                                      blackBoldTextStyle(
                                          context:
                                          context,
                                          fontSize: 24,
                                          color: Theme.of(context).canvasColor),
                                    ),
                                    progressColor:
                                    Colors.green,
                                  ),
                                ),
                              ),
                              Text("تم الاجابة على ${attendanceTable.length} من ${widget.myQuizizzEntity.questions.length} ",style: blackBoldTextStyle(fontSize: 18, context: context),),
                              Padding(
                                padding: const EdgeInsets.only(top:20),
                                child: CustomButton(
                                  width: size.width*0.6,
                                    borderRadius:10,
                                    // height: 3,

                                    title: "نتيجة الاختبار", onTap: (){


                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    restartGetMyQuizizzInfo=true;
                                    Navigator.pop(context,200);
                                    Navigator.pop(context,200);
                                  });

                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    ));

  }
}

