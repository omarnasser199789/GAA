import 'package:acadmiat/core/widgets/error_widget.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/training_plan_folder/picker_date_widget.dart';
import 'package:acadmiat/features/profile_feature/presentation/pages/training_plan_folder/test_picker_date.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../core/widgets/custom_botton.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/my_plans_entity.dart';
import '../../../domain/use_cases/my_plans/post_my_plan_usecase.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';
import 'package:intl/intl.dart';
class TrainingPlanPage extends StatefulWidget {
  const TrainingPlanPage({Key? key}) : super(key: key);

  @override
  State<TrainingPlanPage> createState() => _TrainingPlanPageState();
}

class _TrainingPlanPageState extends State<TrainingPlanPage> {
  List<MyPlansEntity> myPlans = [];
  List<Widget> widgetList=[];

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    Jiffy.locale("ar");
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => sl<ProfileBloc>(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (kDebugMode) {
            print("state:$state");
          }
          if (state is Empty || state is SuccessPostMyPlanEntity) {
            BlocProvider.of<ProfileBloc>(context).add(
                GetMyPlans(userId: userId()));
          }
          if(state is Loading){
            loading=true;
          }else{
            loading=false;
          }
          if(state is SuccessDeletePlanEntity){
            BlocProvider.of<ProfileBloc>(context).add(
                GetMyPlans(userId: userId()));
            showMessage(message: "تم حذف الخطة الدراسية", context: context,bgColor: Colors.red);
          }
          if(state is SuccessGetMyPlansEntity){
            myPlans= state.myPlans;
          }
          if(state is Loading){
            return Scaffold(
              appBar:appBarWidget("الخطة التدريبية",context,true,null,null),
              body: Padding(
                padding: const EdgeInsets.only(left: 17,right: 17),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).cardColor,
                  highlightColor: Color.fromRGBO(119, 118, 118, 0.5490196078431373),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Container(
                            height:130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                        );
                      }),
                ),
              )
            );
          }
          if(state is Error){
            // return Error_Widget();

            return Scaffold(appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {  BlocProvider.of<ProfileBloc>(context).add(
                    GetMyPlans(userId: userId()));
                },
              ),
            );


          }
          widgetList=[];
          for(var item in myPlans){
            widgetList.add(  Padding(
              padding: const EdgeInsets.only(top:20),
              child: Container(
                // height:130,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            (item.daysLeft>0)?
                            Container(
                              decoration: BoxDecoration(
                                color: percentIndicatorColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top:10,bottom: 10,left: 17,right: 17),
                                child: Text("خطة جارية",style:blackBoldTextStyle(fontSize: 11,context: context,color: percentIndicatorColor),),
                              ),
                            ):Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top:10,bottom: 10,left: 17,right: 17),
                                child: Text("خطة منتهية",style:blackBoldTextStyle(fontSize: 11,context: context,color: Colors.red),),
                              ),
                            ),

                           if(item.daysLeft>0)
                            GestureDetector(
                              onTap: (){
                                showCustomDialog(context,item.planId);
                              },
                              child: SvgPicture.asset(
                                "assets/svgs/deleteIcon.svg",
                                color: iconsColor,
                              ),
                            ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:15,bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/vuesax-linear-calendar.svg",
                                  color: iconsColor,
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( "من تاريخ ",style: blackBoldTextStyle(context: context,fontSize: 10,color:   hintTextColor,height: 2),),
                                    Padding(
                                      padding: const EdgeInsets.only(top:6),
                                      child: Text(Jiffy(item.fromDate).yMMMd,style: blackBoldTextStyle(fontSize: 11, context: context),),
                                    ),
                                  ],)
                              ],
                            ),

                            SizedBox(width: 70,),

                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/vuesax-linear-calendar.svg",
                                  color: iconsColor,
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text( "إلى تاريخ",style: blackBoldTextStyle(context: context,fontSize: 10,color:   hintTextColor,height: 2),),
                                    Padding(
                                      padding: const EdgeInsets.only(top:6),
                                      child: Text(Jiffy(item.toDate).yMMMd,style: blackBoldTextStyle(fontSize: 11, context: context),),
                                    ),
                                  ],)
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("نسبة التقدم",style: blackBoldTextStyle(fontSize: 11, context: context),),
                          Text("${(item.progress>100)?100:item.progress}%",style: blackBoldTextStyle(fontSize: 11, context: context),),
                        ],),
                      Padding(
                        padding: const EdgeInsets.only(top: 6,bottom: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              width: size.width-58,//size.width*0.4,
                              animation: true,
                              lineHeight: 8,
                              animationDuration: 1000,
                              barRadius: const Radius.circular(20),
                              percent: (item.progress/100>1)?1:item.progress/100,
                              // center: Text("$percent"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: percentIndicatorColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          }
          return Scaffold(
            appBar:appBarWidget("الخطة التدريبية",context,true,null,null),
            floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {



                  List result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {

                        return PickerDateWidget();

                      }).whenComplete(() {});



                  if (result.length>2) {

                    BlocProvider.of<ProfileBloc>(context)
                        .add(PostMyPlanEvent(postMyPlanParams:
                    PostMyPlanParams(
                        id: null,
                        userId: userId().toString(),
                        type: 1,
                        fromDate: result[0],
                        toDate: result[1],
                        reminder: result[2],
                        isCompleted: false,
                        timePlan: TimePlan(id: null, totalToAchieve: result[3]*60))));

                  }


                },
                backgroundColor: kMainColor,
                child: SvgPicture.asset(
                  "assets/svgs/add plan.svg",
                  color: Colors.white,
                  width: 23,
                ),
              ),
            ),
            body:

            (widgetList.isNotEmpty)?
            Padding(
              padding: const EdgeInsets.only(left: 17,right: 17),
              child: SingleChildScrollView(
                child: Column(
                  children:widgetList,
                ),
              ),
            ):
            SizedBox(
              width: size.width,
              height: size.height-200,

              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    child: SvgPicture.asset(
                      "assets/svgs/plan.svg",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:30),
                    child: Text("لم تقم باضافة خطة بعد!",style: blackBoldTextStyle(fontSize: 16, context: context),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15),
                    child: Container(
                        width: 220,
                        alignment: Alignment.center,
                        child: Text("قم باضافة خطتك التدريبية",
                          textAlign: TextAlign.center,
                          style: blackBoldTextStyle(fontSize: 12,context: context,height: lineSpace),)),
                  ),

                ],
              ),
            ),
          );
        }));

  }

  void showCustomDialog(BuildContext context, int id) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: iconsColor.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (contextt, __, ___) {
        var locale = AppLocalizations.of(context)!;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
          body: BlocProvider(
              create: (BuildContext context) => sl<ProfileBloc>(),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (kDebugMode) {
                      print("State:$state");
                    }
                    return Center(
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scaffold(
                            body: Padding(
                              padding: const EdgeInsets.only(right: 27, left: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 17, bottom: 9.7),
                                    child: Text(
                                      locale.confirmDeletion!,
                                      style: blackBoldTextStyle(
                                          context: context, fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    locale.areSureOfTheDeletingProcess!,
                                    style: blackBoldTextStyle(
                                        context: context, fontSize: 12),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 21),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(contextt);
                                            },
                                            child:Container(
                                              color: Theme.of(context).scaffoldBackgroundColor,

                                              child: Padding(
                                                padding: const EdgeInsets.all(7),
                                                child: Text(
                                                  locale.noCancelTheDeletion!,
                                                  style: blackBoldTextStyle(
                                                      context: context,
                                                      fontSize: 12,
                                                      color:
                                                      Theme.of(context).primaryColor),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 52,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(contextt, 200);
                                            },
                                            child: Container(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(7),
                                                child: Text(
                                                  locale.yesIWantToDelete!,
                                                  style: blackBoldTextStyle(
                                                      context: context,
                                                      fontSize: 12,
                                                      color:
                                                      Theme.of(context).primaryColor),
                                                ),
                                              ),
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
                  })),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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
      if (value == 200) {
        BlocProvider.of<ProfileBloc>(context)
            .add(DeletePlan(planId: id));
      }
    });
  }
}
