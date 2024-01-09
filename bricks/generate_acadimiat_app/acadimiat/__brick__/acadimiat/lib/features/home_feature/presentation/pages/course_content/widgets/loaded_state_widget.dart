import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../my_courses_feature/presentation/pages/my_course/course_page/course_page.dart';
import '../../../../domain/use_cases/check_purchase_usecase.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../pages/tabs/course_info/course_info_tab.dart';
import '../pages/tabs/course_plan/course_plan_tab.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/quick_information.dart';
import '../widgets/trail.dart';
import '../widgets/video_player_widget.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';

class LoadedStateWidget extends StatefulWidget {
  final CardByIdLoaded state;
  final Size size;
  final String courseCover;

  LoadedStateWidget({required this.state, required this.size, required this.courseCover});

  @override
  _LoadedStateWidgetState createState() => _LoadedStateWidgetState();
}

class _LoadedStateWidgetState extends State<LoadedStateWidget> {
  bool initVideoIsNotInit = false;
  bool loading = false;
  bool allowGo = false;

  @override
  Widget build(BuildContext context) {
    if (!initVideoIsNotInit && widget.state.cardByIdEntity.courseVideo != "") {
      initVideoIsNotInit = true;
    }
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        forceElevated: false,
                        collapsedHeight: kToolbarHeight,
                        expandedHeight: widget.size.height > 1000 ? 850 : 565,
                        elevation: 4,
                        backgroundColor: Theme.of(context).cardColor,
                        floating: true,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(10),
                          child: Column(
                            children: [
                              Container(
                                width: widget.size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.04),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: TabBar(
                                    labelColor: Theme.of(context).primaryColor,
                                    dividerColor: Theme.of(context).cardColor,
                                    unselectedLabelColor: iconsColor,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelStyle: blackBoldTextStyle(context: context, fontSize: 11,),
                                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(7),
                                        color: Theme.of(context).primaryColor.withOpacity(0.1)),
                                    tabs: const [
                                      Tab(
                                        height: 30,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("معلومات الدورة", maxLines: 1),
                                        ),
                                      ),
                                      Tab(
                                        height: 30,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("خطة الدورة", maxLines: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppBar(courseName: widget.state.cardByIdEntity.courseName,),
                              VideoPlayerWidget(courseVideo: widget.state.cardByIdEntity.courseVideo, courseCover: widget.courseCover,),
                              QuickInformation(courseName: widget.state.cardByIdEntity.courseName, courseDescription: widget.state.cardByIdEntity.courseDescription,
                                currentPrice: widget.state.cardByIdEntity.currentPrice, trainers: widget.state.cardByIdEntity.trainers, mainPrice: widget.state.cardByIdEntity.mainPrice,),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      SingleChildScrollView(child: CourseInfoTab(cardByIdEntity: widget.state.cardByIdEntity)),
                      SingleChildScrollView(child: CoursePlanTab(cardByIdEntity: widget.state.cardByIdEntity)),
                    ],
                  ),
                ),
              ),
              if (widget.state.cardByIdEntity.appleId != "")
                Trail(newPrice: widget.state.cardByIdEntity.currentPrice, price: widget.state.cardByIdEntity.mainPrice, loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                      allowGo = true;
                    });

                    if (!coursePurchaseOrNot(widget.state.cardByIdEntity.id)) {
                      if (!mounted) return;
                      goTo(context, (context) => CoursePage(userId: userId(), courseId: widget.state.cardByIdEntity.id, imageUrl: widget.courseCover,));
                    } else {
                      try {
                        await Purchases.purchaseProduct(widget.state.cardByIdEntity.appleId);
                        String appUserId = await Purchases.appUserID;
                        if (!mounted) return;
                        BlocProvider.of<HomeBloc>(context).add(CheckPurchaseEvent(params: CheckPurchaseModel(subscriberId: appUserId, productId: widget.state.cardByIdEntity.appleId, userId: "${userId()}")));
                      } catch (e) {
                        if (kDebugMode) {
                          print("Error:$e");
                        }
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
