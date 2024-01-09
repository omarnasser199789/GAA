import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/home_feature/presentation/pages/course_content/pages/tabs/course_content_widget/course_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../my_courses_feature/presentation/pages/my_course/course_page/course_page.dart';
import '../../../../domain/use_cases/check_purchase_usecase.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../cart_feature/presentation/success_payment_page.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/quick_information.dart';
import '../widgets/trail.dart';
import '../widgets/video_player_widget.dart';
import 'tabs/course_overview/course_overview_page.dart';
import '../../../../../../injection_container.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class CourseContentPage extends StatefulWidget {
  const CourseContentPage({super.key, required this.cardId, required this.productType, required this.courseCover});

  final int cardId;
  final int productType;
  final String courseCover;

  @override
  State<CourseContentPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<CourseContentPage> {
  final controller = PageController(initialPage: 0);
  bool allowShowPaymentSheet = false;
  int page = 0;
  bool selected = true;
  bool changeColor = true;
  bool initVideoIsNotInit = false;
  bool loading = false;
  bool allowGo = false;
  int animatedDuration = 2;
  bool allowGetCard = true;
  Size get preferredSize => Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }
          if (state is Empty && allowGetCard) {
            allowGetCard=false;
            BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
          }
          else if (state is Error) {
            return Scaffold(appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:ImgAssets.error,
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {
                  BlocProvider.of<HomeBloc>(context).add(GetCardByIdEvent(id: widget.cardId));
                },
              ),
            );
          }
          else if(state is SuccessCheckPurchase && allowGo){
            allowGo=false;
            Future.delayed(const Duration(milliseconds: 300), () {
              goTo(context, (context) => SuccessPaymentPage());
            });
          }
          else if (state is CardByIdLoaded) {
            if (!initVideoIsNotInit && state.cardByIdEntity.courseVideo!="") {
              initVideoIsNotInit = true;

            }
            return OrientationBuilder(
              builder: (context, orientation) {
                return Scaffold(
                  backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
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
                                collapsedHeight: kToolbarHeight,//
                                expandedHeight:size.height>1000?850:565, //30,
                                elevation: 4,
                                backgroundColor: Theme.of(context).cardColor,
                                floating: true,
                                automaticallyImplyLeading: false,
                                bottom: PreferredSize(
                                  preferredSize: const Size.fromHeight(10),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.04),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: TabBar(
                                            labelColor: Theme.of(context).primaryColor,
                                            dividerColor:Theme.of(context).cardColor,
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
                                      CustomAppBar( courseName: state.cardByIdEntity.courseName,),
                                      VideoPlayerWidget(courseVideo: state.cardByIdEntity.courseVideo, courseCover:  widget.courseCover,),
                                      QuickInformation(courseName:state.cardByIdEntity.courseName, courseDescription: state.cardByIdEntity.courseDescription,
                                        currentPrice: state.cardByIdEntity.currentPrice, trainers: state.cardByIdEntity.trainers, mainPrice: state.cardByIdEntity.mainPrice,),
                                    ],
                                  ),
                                ),

                              ),
                            ];
                          },
                          body: TabBarView(
                            children: [
                              SingleChildScrollView(child: CourseOverviewPage(cardByIdEntity: state.cardByIdEntity)),
                              SingleChildScrollView(child: CourseContentWidget(cardByIdEntity: state.cardByIdEntity)),
                            ],
                          ),
                        ),
                      ),
                      if(state.cardByIdEntity.appleId!="")
                        Trail(newPrice: state.cardByIdEntity.currentPrice, price: state.cardByIdEntity.mainPrice,loading:loading,
                          onTap: () async {
                          setState(() {
                            loading=true;
                            allowGo=true;
                          });

                          if (!coursePurchaseOrNot(state.cardByIdEntity.id)) {
                            if(!mounted) return;
                            goTo(context, (context) => CoursePage(userId: userId(), courseId:state.cardByIdEntity.id, imageUrl: widget.courseCover,));
                          }else{
                            try{
                              await Purchases.purchaseProduct(state.cardByIdEntity.appleId);
                              String appUserId = await Purchases.appUserID;
                              if(!mounted) return;
                              BlocProvider.of<HomeBloc>(context).add(CheckPurchaseEvent(params: CheckPurchaseModel(subscriberId: appUserId, productId: state.cardByIdEntity.appleId, userId: "${userId()}")));
                            }catch(e){
                              if (kDebugMode) {print("Error:$e");}
                            }
                          }
                          setState(() {loading=false;});
                          },
                        ),
                    ],
                  ),
                );
              },
            );
          }
          return const WaitingWidget();
        }));
  }
}







