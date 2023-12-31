import 'package:flutter/foundation.dart';
import 'dart:async';
import'package:flutter_bloc/flutter_bloc.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/widgets/show_case_widget.dart';
import '../../../../../../core/widgets/svg_code_widget.dart';
import '../../../../../../injection_container.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../../widgets/banner_widget.dart';
import '../../../widgets/keep_watching_courses/keep_watching_courses_widget.dart';
import '../../consulting/widgets/consulting_widget.dart';
import '../../search_page.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import '../../../widgets/categories_widget/categories_widget.dart';
import '../widgets/training_courses_widget.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePageViewCase extends StatelessWidget {
  const HomePageViewCase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onStart: (index, key) {
      },
      onComplete: (index, key) {
      },
      blurValue: 1,
      builder: Builder(builder: (context) => const HomePage()),
      autoPlayDelay: const Duration(seconds: 3),
    );
  }
}

  class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);
    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    Timer? timer;
    @override
    void initState() {
      super.initState();
      // ShowCaseWidget.of(context).autoPlay=true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase(
            [globalKeyOne,globalKeyTow,globalKeyThree]
        );
      }
      );
    }

    final GlobalKey globalKeyOne = GlobalKey();
    final GlobalKey globalKeyTow = GlobalKey();
    final GlobalKey globalKeyThree = GlobalKey();
    bool allowEditOnCounter=true;

    @override
    Widget build(BuildContext context) {
      Future.delayed(const Duration(milliseconds: 11000), () {
        globalSH.setBool(iS_Show_Case, true);
        AwesomeNotifications().isNotificationAllowed().then(
              (isAllowed) {
            if (!isAllowed) {
              AwesomeNotifications()
                  .requestPermissionToSendNotifications();
            }
          },
        );
      });

      var locale = AppLocalizations.of(context)!;

      return BlocProvider(
          create: (BuildContext context) => sl<HomeBloc>(),
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (kDebugMode) {
              print("State:$state");
            }

            if(state is Empty){
              BlocProvider.of<HomeBloc>(context).add(GetAllProductsFromFavLocalDBEvent());
            }
            if(state is SuccessGetAllProductsFromFav){
              favEntity= state.favEntity;
            }

            return Scaffold(
              backgroundColor: //backgroundColor
              Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                bottom: false,
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          pinned: true,
                          forceElevated: false,
                          collapsedHeight: kToolbarHeight,
                          elevation: 0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          floating: true,
                          automaticallyImplyLeading: false,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(0),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 17),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                      width: 40,
                                      height: 30,
                                      child: Image(image: AssetImage("assets/logo.png"),)),

                                  Row(children: [
                                    ShowCaseView(
                                      globalKey: globalKeyOne,
                                      title: "استخدم البحث",
                                      description: "ابحث عن ايه شيء تريد آن تتعلمه",
                                      enable: isShowCase(),
                                      child: GestureDetector(
                                        onTap: (){goTo(context, (context) =>  const SearchPage());},
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: SvgPicture.asset(
                                              "assets/svgs/search.svg",
                                              color:iconsColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body:SingleChildScrollView(
                      child: Column(children: [

                        const BannerWidget(),

                        const CategoriesWidget(),

                        ///type=3 => Training Courses
                        const TrainingCoursesWidget(title: "جديدنا",type: 3,isNew: true,),

                        ///type=3 => Training Courses
                        TrainingCoursesWidget(title: locale.trainingCourses!, type: 3,isNew: false,),

                        ///type = 2 => Diplomas and packages
                        TrainingCoursesWidget(title: locale.diplomasAndPackages!,isDiploma: true,type: 2),

                        const ConsultingWidget(),

                        const KeepWatchingCoursesWidget(),

                        const SizedBox(height: 80,),

                        // TrainingCoursesWidget(title: locale.coursesInManagementAndMarketing!, type: 1,),
                        // const FirstListWidget(),
                        // TrainingCoursesWidget(title: locale.mostWanted!,showFavBtn: true,enableBroadcast: false,disableTitleOnImage: true, type: 1,),

                        const  SizedBox(height: 30,),

                      ],),
                    ),
                  )

              ),
            );
          }));
    }
}
