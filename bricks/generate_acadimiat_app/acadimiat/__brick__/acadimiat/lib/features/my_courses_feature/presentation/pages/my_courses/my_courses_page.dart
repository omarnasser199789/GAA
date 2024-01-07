import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/authentication_feature/presentation/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../core/functions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/util/assets_manager.dart';
import '../../../../../core/widgets/cached_net_work_image.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../home_feature/presentation/pages/training_courses_page.dart';
import '../../../data/models/my_courses_model.dart';
import '../../../domain/entities/my_courses_entity.dart';
import '../my_course/course_page/course_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../bloc/bloc.dart';
import 'package:measure_size/measure_size.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  List<MyCoursesEntity> myCoursesEntity = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is Empty && isLoggedIn()) {
            ///1-Get data from locale DB
            ///2-Get data from server.
            ///3-View the data we have collected from locale DB.
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server
            BlocProvider.of<MyCoursesBloc>(context)
                .add(GetMyCoursesFromLocaleDBEvent());

            /// : => SuccessGetMyCoursesFromLocaleDBState.
            // BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourses());
          }

          if (state is SuccessGetMyCoursesFromLocaleDBState) {
            ///2-Get data from server.
            BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourses());

            /// : => Loaded.
            ///If there is no item store in local db, we should view loading widget
            ///while the data is fetched.

            if (state.myCoursesEntity.isEmpty) {
              ///Loading Widget.
              return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Theme.of(context).primaryColor,
                  ));
            }

            ///If there is data in local db
            ///3-View the data we have collected from locale DB.
            myCoursesEntity = [];
            myCoursesEntity = state.myCoursesEntity;
          }

          if (state is Loaded) {
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server

            ///Update myCourses in locale DB.
            ///1-Generate myCourses list.
            List<MyCoursesModel> list = [];
            for (int i = 0; state.myCoursesEntity.length > i; i++) {
              list.add(MyCoursesModel(
                id: state.myCoursesEntity[i].id,
                header: state.myCoursesEntity[i].header,
                authorized: state.myCoursesEntity[i].authorized,
                image: state.myCoursesEntity[i].image,
                courseLink: state.myCoursesEntity[i].courseLink,
                trainer: state.myCoursesEntity[i].trainer,
                percent: state.myCoursesEntity[i].percent,
                total: state.myCoursesEntity[i].total,
                isCourse: state.myCoursesEntity[i].isCourse,
                hasBeforeQuizz: state.myCoursesEntity[i].hasBeforeQuizz,
              ));
            }

            ///Store data in locale DB event
            BlocProvider.of<MyCoursesBloc>(context)
                .add(UpdateMyCoursesFromLocaleDBEvent(params: list));

            /// : => no thing

            myCoursesEntity = [];
            myCoursesEntity = state.myCoursesEntity;
          }

          if (state is Loading) {
            return const WaitingWidget();
          }
          return ResultWidget(
            myCoursesEntity: myCoursesEntity,
          );
        }));
  }
}

class ResultWidget extends StatefulWidget {
  ResultWidget({super.key, required this.myCoursesEntity});
  List<MyCoursesEntity> myCoursesEntity;

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  List<MyCoursesEntity> storedData = [];
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    ///store data for search;
    if (storedData.isEmpty) {
      for (var item in widget.myCoursesEntity) {
        storedData.add(item);
      }
    }

    return Scaffold(
      body: (isLoggedIn())
          ? NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    forceElevated: false,
                    collapsedHeight: kToolbarHeight,
                    expandedHeight: 110,
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, bottom: 5),
                            child: TextField(
                              textInputAction: TextInputAction.newline,
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor),
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'عن ماذا تريد أن تبحث؟',
                                hintStyle: blackBoldTextStyle(context: context, fontSize: 12, color: hintTextColor),
                                filled: true,
                                fillColor: textFormFieldFillColor,
                                prefixIcon: Icon(Icons.search, color: hintTextColor),
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
                              controller: searchTextController,
                              onTap: () {
                                if (searchTextController.selection == TextSelection.fromPosition(TextPosition(offset: searchTextController.text.length - 1))) {
                                  setState(() {searchTextController.selection = TextSelection.fromPosition(TextPosition(offset: searchTextController.text.length));
                                  });
                                }
                              },
                              onChanged: (value) {
                                widget.myCoursesEntity.clear();
                                for (var item in storedData) {
                                  if (item.header.contains(value)) {
                                    widget.myCoursesEntity.add(item);
                                  }
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Column(
                          children: [
                            PreferredSize(
                              preferredSize: const Size.fromHeight(50),
                              child: AppBar(
                                titleSpacing: 0,
                                title: Theme(
                                  data: Theme.of(context).copyWith(),
                                  child: Column(
                                    children: [
                                      appBarWidget("${locale.myCourses!} (${widget.myCoursesEntity.length})", context, false, null, null),
                                    ],
                                  ),
                                ),
                                automaticallyImplyLeading: false,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: (widget.myCoursesEntity.isNotEmpty)
                  ? Padding(
                      padding: EdgeInsets.only(top: 30, left: 17, right: 17, bottom: (WidgetsBinding.instance.window.viewInsets.bottom > 0) ? 0 : 100),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 210,
                            childAspectRatio: childAspectRatio,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 17,
                          ),
                          itemCount: widget.myCoursesEntity.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ItemList(
                              onTap: () {
                                courseId = widget.myCoursesEntity[index].id;
                                goTo(context, (context) => CoursePage(userId: userId(), courseId: widget.myCoursesEntity[index].id, imageUrl: widget.myCoursesEntity[index].image,));
                              },
                              enableBroadcast:
                                  !widget.myCoursesEntity[index].isCourse,
                              typeCourse: locale.courses!,
                              imageUrl: widget.myCoursesEntity[index].image,
                              header: widget.myCoursesEntity[index].header,
                              trainer: widget.myCoursesEntity[index].trainer,
                              percent: widget.myCoursesEntity[index].percent,
                              total: widget.myCoursesEntity[index].total,
                              courseId: widget.myCoursesEntity[index].id,
                            );
                          }))
                  : EmptyStateWidget(
                      svg: "assets/svgs/learning.svg",
                      text1: "هل تبحث عن دورات تدريبية؟",
                      text3: "تصفح الدورات",
                      onTap: () async {
                        await goTo(context, (context) => TrainingCoursesPage(latestEntity: const []));
                        if(!mounted) return;
                        BlocProvider.of<MyCoursesBloc>(context).add(GetMyCoursesFromLocaleDBEvent());/// : => SuccessGetMyCoursesFromLocaleDBState.
                      },
                    ),
            )
          : EmptyStateWidget(
              svg: ImgAssets.login,
              text1: "من فضلك! سجل دخولك لمشاهدة دوراتك",
              text3: "تسجيل الدخول",
              onTap: () async {
                await goTo(context, (context) => const LoginPage());
              },
            ),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList(
      {super.key,
      this.enableBroadcast,
      this.courseId,
      this.total,
      required this.onTap,
      this.typeCourse,
      this.imageUrl,
      this.percent,
      this.header,
      this.trainer});

  final Function() onTap;
  final bool? enableBroadcast;
  final String? typeCourse;
  final String? header;
  final String? imageUrl;
  final String? trainer;
  final int? percent;
  final int? courseId;
  final double? total;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  double width = 100;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 5,
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              child: Hero(
                tag: widget.courseId.toString(),
                child: Stack(
                  children: [
                    CachedNetWorkImage(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6),),
                      url: widget.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                    // Positioned.fill(
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 1.0),
                    //     child: Container(
                    //       color: Colors.transparent, // You can change this color as needed
                    //     ),
                    //   ),
                    // ),
                    CachedNetWorkImage(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6),),
                      url: widget.imageUrl,
                      boxFit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
              child: Container(
                height: 35,
                alignment: Alignment.centerRight,
                child: Text(
                  widget.header!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: blackBoldTextStyle(context: context, fontSize: 13),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MeasureSize(
                  onChange: (Size? size) {
                    if(size!=null){
                      setState(() {
                        width = size.width;
                      });
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "مكتملة",
                          style: blackBoldTextStyle(
                              fontSize: 11, context: context),
                        ),
                        Text(
                          "${widget.percent!}%",
                          style: blackBoldTextStyle(
                              fontSize: 11, context: context),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        width: width - 20, //size.width*0.4,
                        animation: true,
                        lineHeight: 8,
                        animationDuration: 1000,
                        barRadius: const Radius.circular(20),
                        percent: widget.percent! / 100,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: percentIndicatorColor,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
