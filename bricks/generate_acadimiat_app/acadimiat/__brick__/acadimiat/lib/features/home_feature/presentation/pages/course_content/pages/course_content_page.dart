import 'package:acadmiat/core/widgets/price_widget.dart';
import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/home_feature/presentation/pages/course_content/pages/trainer_info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../my_courses_feature/presentation/pages/my_course/course_page/course_page.dart';
import '../../../../domain/use_cases/check_purchase_usecase.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/back_button.dart';
import '../../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../cart_feature/presentation/success_payment_page.dart';
import '../widgets/trail.dart';
import '../../course_overview/course_overview_page.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../../injection_container.dart';
import '../../../../../my_courses_feature/presentation/widgets/common.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_player/better_player.dart';
import '../../../widgets/course_content_widget/course_content.dart';
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
  @override
  void dispose() {
    controller.dispose();
    _betterPlayerController.dispose();
    super.dispose();
  }

  int page = 0;
  bool selected = true;
  bool changeColor = true;
  bool initVideoIsNotInit = false;
  bool playVideo = false;
  bool loading = false;
  bool allowGo = false;
  late BetterPlayerController _betterPlayerController;
  int animatedDuration = 2;
  bool allowGetCard = true;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top);


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
              initVideo(url: state.cardByIdEntity.courseVideo,);
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
                                    children: [
                                      AppBar(
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        elevation: 0,
                                        leading: BackButtonWidget(),
                                        actions: [
                                          const SizedBox(width: 15),
                                          GestureDetector(
                                            onTap: () {
                                              String result = shareCourseText.replaceAll("####", state.cardByIdEntity.courseName);
                                              result = result.replaceAll("***", "\n");
                                              Share.share(result);
                                            },
                                            child: SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: SvgPicture.asset(ImgAssets.share, color: iconsColor),
                                            ),
                                          ),
                                          const SizedBox(width: 25),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          (state.cardByIdEntity.courseVideo != "")
                                              ? Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: BetterPlayer(
                                                  controller: _betterPlayerController,
                                                ),
                                              ),
                                              if (playVideo == false)
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 16/9,
                                                      child: CachedNetWorkImage(
                                                        borderRadius: BorderRadius.circular(0),
                                                        boxFit: BoxFit.fill,
                                                        url: widget.courseCover,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _betterPlayerController.play();
                                                        setState(() {
                                                              playVideo = true;
                                                            });
                                                      },
                                                      child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                              color: Colors.black.withOpacity(0.6),
                                                              borderRadius: BorderRadius.circular(200),
                                                              border: Border.all(color: Theme.of(context).primaryColor, width: 3)),
                                                          child: Icon(Icons.play_arrow_outlined, size: 30, color: Theme.of(context).primaryColor,)),
                                                    )
                                                  ],
                                                ),
                                            ],
                                          ) :
                                          AspectRatio(
                                              aspectRatio: 16/9,
                                              child: CachedNetWorkImage(
                                                borderRadius: BorderRadius.circular(0),
                                                boxFit:
                                                BoxFit.fill,
                                                url: widget.courseCover,
                                              )),

                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 17, right: 17, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width - 34,
                                                  child: Text(
                                                    state.cardByIdEntity.courseName,
                                                    style: blackBoldTextStyle(context: context, fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width - 34,
                                                  child: Text(
                                                    parseHtmlString(state.cardByIdEntity.courseDescription),
                                                    style: blackRegularTextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
                                            child: PriceWidget(newPrice: state.cardByIdEntity.currentPrice, price: state.cardByIdEntity.mainPrice),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: SizedBox(
                                              height: 90,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: state.cardByIdEntity.trainers.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(left: 17, right: 17, top: 5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          goTo(context, (context) => TrainerInfoPage(
                                                                    index: index,
                                                                    trainer: state.cardByIdEntity.trainers[index],
                                                                    image: state.cardByIdEntity.trainers[index].trainerAvatar,
                                                                  )); //
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Hero(
                                                              tag: "TrainerHeroTag$index",
                                                              child: Container(
                                                                  width: 50, height: 50,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(2000),
                                                                    border: Border.all(width: 2, color: Theme.of(context).canvasColor.withOpacity(0.5)),
                                                                  ),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(2.0),
                                                                    child: CachedNetWorkImage(borderRadius: BorderRadius.circular(200),
                                                                        url: state.cardByIdEntity.trainers[index].trainerAvatar,boxFit: BoxFit.fill,),
                                                                  )),
                                                            ),
                                                            const SizedBox(height: 8),
                                                            Text(state.cardByIdEntity.trainers[index].trainerName,
                                                              style: blackBoldTextStyle(context: context, fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
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
                          CustomerInfo customerInfo= await Purchases.getCustomerInfo();
                          List<String> allPurchasedProductIdentifiers =  customerInfo.allPurchasedProductIdentifiers;

                            // if (allPurchasedProductIdentifiers.contains(state.cardByIdEntity.appleId))
                            if (!coursePurchaseOrNot(state.cardByIdEntity.id))
                            {
                              if(!mounted) return;
                              goTo(context, (context) => CoursePage(
                                    userId: userId(),
                                    courseId:state.cardByIdEntity.id,
                                    imageUrl: widget.courseCover,
                                  )
                              );
                            }else{
                              try{
                                await Purchases.purchaseProduct(state.cardByIdEntity.appleId);
                                String appUserId = await Purchases.appUserID;
                                if(!mounted) return;
                                BlocProvider.of<HomeBloc>(context).add(CheckPurchaseEvent(params:
                                CheckPurchaseModel(subscriberId: appUserId, productId: state.cardByIdEntity.appleId, userId: "${userId()}")));
                              }catch(e){
                                if (kDebugMode) {
                                  print("Error:$e");
                                }
                              }
                            }
                              setState(() {
                                loading=false;
                              });
                          },),
                    ],
                  ),
                );
              },
            );
          }
          return const WaitingWidget();
        }));
  }

  Future<dynamic> initVideo({required String url, int? startFrom}) async {
    _betterPlayerController = BetterPlayerController(
      configurationBetterPlayer(context: context, startFrom: startFrom),
      betterPlayerDataSource: BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, url,
          useAsmsSubtitles: true, headers: headers),
    );

    return 200;
  }
}