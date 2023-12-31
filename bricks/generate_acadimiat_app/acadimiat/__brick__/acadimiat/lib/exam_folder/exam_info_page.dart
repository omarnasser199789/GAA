
import 'package:acadmiat/core/widgets/custom_botton.dart';
import 'package:acadmiat/core/widgets/error_widget.dart';
import 'package:acadmiat/exam_folder/exam_page.dart';
import 'package:acadmiat/features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import 'package:acadmiat/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import '../Theme/style.dart';
import '../core/functions.dart';
import '../core/widgets/app_bar_widget.dart';
import '../core/widgets/empty_state_widget.dart';
import '../core/widgets/waiting_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/my_courses_feature/domain/entities/my_quizz_info_entity.dart';
import '../features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import '../features/my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../features/my_courses_feature/presentation/bloc/my_courses_state.dart';

class ExamInfoPage extends StatefulWidget {
  const ExamInfoPage({Key? key, required this.quizzId}) : super(key: key);

  final int quizzId;
  @override
  State<ExamInfoPage> createState() => _ExamInfoPageState();
}
bool restartGetMyQuizizzInfo = false;
class _ExamInfoPageState extends State<ExamInfoPage> {
  late MyQuizzInfoEntity myQuizzInfoEntity;
  bool firstOne = true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if(state is Error){
            return Scaffold(appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {
                  BlocProvider.of<MyCoursesBloc>(context).add(GetMyQuizizzInfoEvent(
                      getMyQuizizzInfoParams: GetMyQuizizzInfoParams(
                          userId: userId(), quizzId: widget.quizzId)));
                },
              ),
            );
          }

          if (state is Empty) {
            BlocProvider.of<MyCoursesBloc>(context).add(GetMyQuizizzInfoEvent(
                getMyQuizizzInfoParams: GetMyQuizizzInfoParams(
                    userId: userId(), quizzId: widget.quizzId)));
          }
          if (state is SuccessGetQuizizzInfoState) {
            myQuizzInfoEntity = state.myQuizzInfoEntity;
            if (firstOne) {
              BlocProvider.of<MyCoursesBloc>(context).add(GetMyQuizizz(
                  getMyQuizezzParams: GetMyQuizezzParams(
                      userId: userId(), lectureId: widget.quizzId)));
              firstOne = false;
            }
          }

          if (state is SuccessGetMyQuizizz) {

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: appBarWidget(state.myQuizizzEntity.name, context, true,
                  null, Theme.of(context).cardColor),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 19, left: 19, right: 19),
                              child: Text(
                                "معلومات عامة عن الاختبار",
                                style: blackBoldTextStyle(
                                    context: context, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 19, right: 19, top: 10),
                          child: Container(
                            // height: 343,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13, left: 19, right: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "الوقت المسموح لتقديم الاختبار",
                                        style: blackBoldTextStyle(
                                            context: context, fontSize: 12),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svgs/clock.svg",
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${state.myQuizizzEntity.timeLimit} دقيقة",
                                              style: blackBoldTextStyle(
                                                  context: context,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BoxInfo(
                                        size: size,
                                        svg:
                                            "assets/svgs/Group 130313333333.svg",
                                        text: "عدد أسئلة الاختبار ",
                                        title:
                                            "${state.myQuizizzEntity.questions.length}",
                                      ),
                                      BoxInfo(
                                        size: size,
                                        svg:
                                            "assets/svgs/Group 130312222222.svg",
                                        text: "عدد المحاولات المسموحة",
                                        title:
                                            "${state.myQuizizzEntity.repetition}",
                                      ),
                                      BoxInfo(
                                        size: size,
                                        svg: "assets/svgs/Group 13031.svg",
                                        text: "عدد محاولات التقديم",
                                        title:
                                            "${state.myQuizizzEntity.myAttempts}",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (myQuizzInfoEntity.myAttempts.isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 19, left: 19, right: 19),
                                    child: Text(
                                      "سجل المحاولات السابقة",
                                      style: blackBoldTextStyle(
                                          context: context, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 19, right: 19, top: 10),
                                child: Container(
                                  // height: 343,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(12)),

                                  child:  Padding(
                                    padding: const EdgeInsets.only(top: 19),
                                    child: Container(
                                      height: 88 *
                                          myQuizzInfoEntity
                                              .myAttempts.length /
                                          1,
                                      // color: Colors.green,
                                      child: ListView.builder(
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemCount: myQuizzInfoEntity
                                              .myAttempts.length,
                                          itemBuilder: (context, index) {
                                            Jiffy.locale("ar");
                                            String date = Jiffy(
                                                myQuizzInfoEntity
                                                    .myAttempts[index]
                                                    .date)
                                                .yMMMMd;
                                            print(date);

                                            return Container(
                                              height: 88,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 14,
                                                        right: 14,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                              child: Text(
                                                                "المحاولة ${index+1}",
                                                                style: blackBoldTextStyle(
                                                                    fontSize:
                                                                    13,
                                                                    context:
                                                                    context),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  top: 4,
                                                                  bottom:
                                                                  10),
                                                              child: Text(
                                                                date,
                                                                style: blackBoldTextStyle(
                                                                    fontSize:
                                                                    11,
                                                                    context:
                                                                    context),
                                                              ),
                                                            ),
                                                            (myQuizzInfoEntity
                                                                .myAttempts[
                                                            index]
                                                                .didPass)
                                                                ? Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/svgs/Icon feather-check-circle.svg",
                                                                  color: percentIndicatorColor,
                                                                ),
                                                                const SizedBox(
                                                                  width:
                                                                  7,
                                                                ),
                                                                Text(
                                                                  "لقد اجتزت الاختبار",
                                                                  style:
                                                                  blackBoldTextStyle(fontSize: 12, context: context,color: percentIndicatorColor),
                                                                ),
                                                              ],
                                                            )
                                                                : Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/svgs/warning-2.svg",
                                                                    color: Colors.red),
                                                                SizedBox(
                                                                  width:
                                                                  7,
                                                                ),
                                                                Text(
                                                                  "لم تقم باجتياز الاختبار",
                                                                  style: blackBoldTextStyle(
                                                                      fontSize: 13,
                                                                      context: context,
                                                                      color: Colors.red),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                  context)
                                                                  .scaffoldBackgroundColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5)),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(
                                                                8.0),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/svgs/group 3020.svg",
                                                                ),
                                                                SizedBox(
                                                                  width: 7,
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      myQuizzInfoEntity
                                                                          .myAttempts[index]
                                                                          .totalDegree
                                                                          .toString(),
                                                                      style: blackBoldTextStyle(
                                                                          fontSize: 15,
                                                                          context: context),
                                                                    ),
                                                                    Text(
                                                                      "الدرجة المستحقة",
                                                                      style: blackBoldTextStyle(
                                                                          fontSize: 9,
                                                                          context: context),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (index !=
                                                      myQuizzInfoEntity
                                                          .myAttempts
                                                          .length -
                                                          1)
                                                    Container(
                                                      height: 0.5,
                                                      color: Theme.of(
                                                          context)
                                                          .canvasColor
                                                          .withOpacity(0.5),
                                                      width:
                                                      double.infinity,
                                                    )
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),

                  if (state.myQuizizzEntity.repetition > state.myQuizizzEntity.myAttempts)
                    Container(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 17, top: 26, right: 17, bottom: 10),
                            child: SafeArea(
                                child: Material(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: CustomButton(
                                  title: "ابدء الاختبار",
                                  onTap: () {
                                    Navigator.of(context).push( MaterialPageRoute(builder: (_)=> ExamPage(
                                      cameFrom: ExamInfoPage,
                                      myQuizizzEntity:
                                    state.myQuizizzEntity,)),)
                                        .then((val){
                                          if(val==200){
                                            firstOne=true;
                                            BlocProvider.of<MyCoursesBloc>(context).add(ResetEvent());
                                          }
                                    });
                                  }),
                            )),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            );
          }

          return WaitingWidget();
        }));
  }
}

class BoxInfo extends StatelessWidget {
  const BoxInfo({
    Key? key,
    required this.size,
    required this.svg,
    required this.text,
    required this.title,
  }) : super(key: key);

  final Size size;

  final String svg;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119,
      width: size.width * 0.265,
      decoration: BoxDecoration(
          // color: Theme.of(context).cursorColor,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SvgPicture.asset(
                  svg,
                ),
              ),
              Text(
                title,
                style: blackBoldTextStyle(
                    context: context, fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: blackBoldTextStyle(context: context, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
