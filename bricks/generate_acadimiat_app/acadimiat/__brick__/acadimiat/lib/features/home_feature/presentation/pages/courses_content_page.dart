import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import '../../../../core/classes/constants.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../cart_feature/domain/use_cases/add_product_in_local_db_usecase.dart';
import '../../../cart_feature/presentation/bloc/my_cart_bloc.dart';
import '../../../cart_feature/presentation/bloc/my_courses_event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../../../../core/widgets/price_widget.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../injection_container.dart';
import '../../../my_courses_feature/presentation/widgets/common.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_player/better_player.dart';
import 'package:measure_size/measure_size.dart';
import 'course_content/pages/course_content_page.dart';
import '../../../cart_feature/presentation/bloc/my_cart_state.dart' as cartState;


class CoursesContentPage extends StatefulWidget {
  const CoursesContentPage({Key? key,required this.cardId,required this.courseCover}) : super(key: key);

  final int cardId;
  final String courseCover;

  @override
  State<CoursesContentPage> createState() => _CoursesContentPageState();
}

class _CoursesContentPageState extends State<CoursesContentPage> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    _betterPlayerController.pause();
    _betterPlayerController.dispose();
    super.dispose();
  }
  int page=0;
  bool selected = true;
  bool changeColor = true;
  bool initVideoIsNotInit = false;
  bool playVideo = false;
  late BetterPlayerController _betterPlayerController;
  Size itemSize=const Size(0,100);
  bool allowAddNewProduct = false;
  int animatedDuration=2;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size =MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(kDebugMode) {
                print("State:$state");
              }
              if(state is Empty) {
                BlocProvider.of<HomeBloc>(context).add(GetPackageEvent(id: widget.cardId));
              }
              else if(state is Error){
                return Scaffold(
                  appBar:appBarWidget("",context,true,null,null),
                  body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                    text1:"عذرا! حدثت مشكلة غير متوقعة",
                    text3: "حدث الان",
                    onTap: () async {
                      BlocProvider.of<HomeBloc>(context).add(GetPackageEvent(id: widget.cardId));
                    },
                  ),
                );
              }
              else if(state is SuccessGetPackage){

                return OrientationBuilder(
                  builder: (context, orientation) {
                    return BlocProvider(
                        create: (BuildContext context) => sl<MyCartBloc>(),
                        child: BlocBuilder<MyCartBloc, cartState.MyCartState>(
                            builder: (context, statee) {
                              if (kDebugMode) {
                                print("state:$statee");
                              }
                              if (statee is cartState.Empty) {
                                ///Check if product exit already in (cart)DB or not.
                                BlocProvider.of<MyCartBloc>(context).add(CheckIfProductIsExitEvent(id: state.packageEntity.packageId));
                              }
                              if (statee is cartState.SuccessCheckProductEntity) {
                                ///Product is already exit
                                if (statee.statusCode == 200) {
                                  if (kDebugMode) {
                                    print("item exit already");
                                  }
                                  animatedDuration = 0;
                                  selected = false;
                                  changeColor = !changeColor;
                                }

                                ///Product is not exit in DB
                                else if (statee.statusCode == 404 && allowAddNewProduct) {
                                  allowAddNewProduct = false;
                                  BlocProvider.of<MyCartBloc>(context)
                                      .add(AddProductToCart(
                                      params: AddProductParams(
                                        name: state.packageEntity.packageName,
                                        apiId: state.packageEntity.packageId,
                                        trainer: "مجموعة مدربين",
                                        newPrice:state.packageEntity.currentPrice,
                                        oldPrice:state.packageEntity.mainPrice,
                                        fav: 0,
                                        image:state.packageEntity.packageImage,
                                        productType: ProductType.package,
                                      )));
                                }
                              }
                              return Scaffold(
                                backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                body: SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        AppBar(
                                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                          elevation: 0,
                                          leading: BackButtonWidget(),
                                          actions: [
                                            const SizedBox(width: 15,),
                                            GestureDetector(
                                              onTap: (){
                                                Share.share("watch--------- \n https://google.com  \n\n downloadTheAppFromGooglePlay \n https://play.google.com \n\n downloadTheAppFromAppStore\n https://apps.apple.com");
                                              },
                                              child: SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: SvgPicture.asset(
                                                  "assets/svgs/share.svg",
                                                  color:iconsColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15,),
                                          ],

                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 16/9,
                                              child: CachedNetWorkImage(borderRadius:BorderRadius.circular(0),
                                                boxFit: BoxFit.fill ,url: state.packageEntity.packageImage,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 17,right: 17,top:18),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: size.width-34,
                                                    // color: Colors.green,
                                                    child: Text(
                                                      state.packageEntity.packageName,
                                                      style: blackBoldTextStyle(context: context,fontSize: 15),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 10,right: 10,top:18),
                                              child: PriceWidget(newPrice: state.packageEntity.currentPrice, price: state.packageEntity.mainPrice,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 17,right: 17,top:18,bottom: 10),
                                              child: Text("الدورات المتضمنة في هذه الباقة",style: blackBoldTextStyle(fontSize: 15,context: context,color: Theme.of(context).primaryColor),),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,top: 10),
                                          child: SizedBox(
                                            height: (itemSize.height+20)*(state.packageEntity.courses.length/2).round(),
                                            width: double.infinity,
                                            child: GridView.builder(
                                                padding: EdgeInsets.zero,
                                                physics: const NeverScrollableScrollPhysics(),
                                                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 210,
                                                    childAspectRatio: childAspectRatio,
                                                    crossAxisSpacing: 15,
                                                    mainAxisSpacing: 20),
                                                itemCount:state.packageEntity.courses.length,
                                                itemBuilder: (BuildContext ctx, index) {

                                                  return MeasureSize(
                                                    onChange: (size ) {
                                                      if (!mounted) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        itemSize=size;
                                                      });
                                                    },
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        goTo(context, (context) =>
                                                            CourseContentPage(cardId:state.packageEntity.courses[index].id,
                                                              productType: ProductType.course,
                                                              courseCover:  state.packageEntity.courses[index].courseCover,
                                                            ));
                                                      },
                                                      child: Container(
                                                        width: 260,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          color:Theme.of(context).cardColor,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              height: 110,
                                                              child: Stack(
                                                                alignment: Alignment.bottomLeft,
                                                                children: [
                                                                  CachedNetWorkImage(
                                                                    borderRadius:
                                                                    const BorderRadius.all(Radius.circular(6)),
                                                                    url: state.packageEntity.courses[index].courseCover,
                                                                    boxFit: BoxFit.fill,
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 0, left: 7, right: 7),
                                                              child: Text(state.packageEntity.courses[index].courseName,
                                                                maxLines: 2,
                                                                style: blackBoldTextStyle(context: context,fontSize: 14),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 0, left: 7, right: 7),
                                                              child: Text(
                                                                state.packageEntity.courses[index].trainerName,
                                                                style: blackRegularTextStyle(fontSize: 12,),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  PriceWidget(newPrice:state.packageEntity.courses[index].currentPrice, price: state.packageEntity.courses[index].mainPrice,),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(height: 5,)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),

                                          ),
                                        ),
                                        const SizedBox(height: 80),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            )
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