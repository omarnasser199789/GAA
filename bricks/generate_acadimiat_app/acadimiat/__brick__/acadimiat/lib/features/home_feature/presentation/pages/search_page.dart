import 'package:acadmiat/core/widgets/price_widget.dart';
import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/home_feature/presentation/bloc/home_event.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/classes/constants.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/cached_net_work_image.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/is_course_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/entities/search_process_entity.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import 'course_content/pages/course_content_page.dart';
import 'courses_content_page.dart';

TextEditingController searchTextController = TextEditingController();

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  State<SearchPage> createState() => _SearchPageState();
}

bool showSearchHistory = true;

class _SearchPageState extends State<SearchPage> {
  
  List<SearchEntity> searchEntityList = [];
  List<SearchProcessEntity> searchProcessEntity = [];
  bool loading = false;
  FocusNode inputNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchTextController.text="";
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
          if (state is Empty) {
            ///Get all search process that user did it
            BlocProvider.of<HomeBloc>(context).add(GetAllSearchProcessEvent());
          }
          if (state is Loading) {
            loading = true;
          } else {
            loading = false;
          }
          if (state is SuccessGetSearchItem) {
            searchEntityList = state.list;

            showSearchHistory = false;
            BlocProvider.of<HomeBloc>(context).add(StopAnyEvent());
          }
          if (state is SuccessGetSearchProcess) {
            searchProcessEntity = state.list.reversed.toList();

          }

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar:  AppBar(
              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              title: CustomTextField(
                title: '',
                focusNode: inputNode,
                controller: searchTextController,
                hint: 'ابحث عن كل شيء',
                maxLines: 1,
                width: size.width * 0.8,
                suffixIcon: (searchTextController.text != "")
                    ? GestureDetector(
                  onTap: () {
                    searchTextController.text = "";

                    FocusScope.of(context)
                        .requestFocus(inputNode);
                    if (!mounted) {
                      return;
                    }

                    if (!mounted) {
                      return;
                    }

                    setState(() {
                      showSearchHistory = true;
                    });
                  },
                  child: Container(
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.cancel,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
                    : null,
                autofocus: true,
                isSearch: true,
                onTap: () {
                  ///Get all search process that user did it
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetAllSearchProcessEvent());

                  /// :> SuccessGetSearchProcess

                  ///Delete all item form searchEntityList,
                  searchEntityList = [];
                  if (!mounted) {
                    return;
                  }

                  setState(() {
                    showSearchHistory = true;
                  });
                },
                onFieldSubmitted: (val) {
                  if (searchTextController.text != "") {
                    ///Get data from server using searchTextController

                    BlocProvider.of<HomeBloc>(context).add(
                        SearchEvent(
                            text: searchTextController.text));

                    /// :> SuccessGetSearchItem

                    if (!mounted) {
                      return;
                    }

                    setState(() {
                      showSearchHistory = false;
                    });
                  }
                },
              ),
              leading: BackButtonWidget(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [

                  if (showSearchHistory)
                    Archives(
                      searchProcessEntity: searchProcessEntity,
                    ),

                  if (!showSearchHistory)
                    (loading)
                        ? Padding(
                            padding: EdgeInsets.only(top: size.height * 0.3),
                            child: const WaitingWidget(),
                          )
                        : (searchEntityList.isNotEmpty)
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 17, bottom: 5),
                                    child: Container(
                                      height: 40,
                                      color: Colors.grey.withOpacity(0.1),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17, right: 17),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${searchEntityList.length} نتيجة",
                                              style: blackBoldTextStyle(context: context, fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 13),
                                    child: SizedBox(
                                      height: 140 * searchEntityList.length / 1,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: searchEntityList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                ///Package from courses
                                                if (searchEntityList[index].numberOfCourses >0) {
                                                  goTo(context, (context) =>
                                                          CoursesContentPage(
                                                            cardId: searchEntityList[index].id,
                                                            courseCover: searchEntityList[index].image,
                                                          ));
                                                }

                                                ///For course and diploma
                                                else {
                                                  goTo(
                                                      context,
                                                      (context) =>
                                                          CourseContentPage(
                                                            cardId: searchEntityList[index].id,
                                                            productType: ProductType.course,
                                                            courseCover: searchEntityList[index].image,
                                                          ));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 17,
                                                    right: 17,
                                                    top: 8,
                                                    bottom: 8),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Theme.of(context)
                                                            .canvasColor
                                                            .withOpacity(0.05),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(0,1), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            right: 8,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 92,
                                                          height: 92,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child:
                                                              CachedNetWorkImage(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxFit: BoxFit.fill,
                                                            url:
                                                            (searchEntityList[index].squareImage != "")
                                                                ? searchEntityList[index].squareImage
                                                                :
                                                            searchEntityList[index].image,

                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                                width:
                                                                    size.width -
                                                                        150,
                                                                child: Text(
                                                                  searchEntityList[
                                                                          index]
                                                                      .header,
                                                                  style: blackBoldTextStyle(
                                                                      context:
                                                                          context,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          lineSpace),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15),
                                                              child: Text(
                                                                  searchEntityList[
                                                                          index]
                                                                      .trainer,
                                                                  style: blackBoldTextStyle(
                                                                      context:
                                                                          context,
                                                                      fontSize:
                                                                          12)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15),
                                                              child: SizedBox(
                                                                width:
                                                                    size.width -
                                                                        150,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    if (searchEntityList[index]
                                                                            .isCourse !=
                                                                        null)
                                                                      IsCourseWidget(
                                                                        isCourse:
                                                                            searchEntityList[index].isCourse!,
                                                                        numberOfCourses:
                                                                            searchEntityList[index].numberOfCourses,
                                                                      ),
                                                                    PriceWidget(
                                                                        newPrice:
                                                                            searchEntityList[index]
                                                                                .newPrice,
                                                                        price: searchEntityList[index]
                                                                            .price)
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.2),
                                child: const EmptyStateWidget(
                                  svg: 'assets/svgs/search-empty-state.svg',
                                  text1: 'نآسف، لا توجد نتائج',
                                  text3: 'يرجى المحاولة باستخدام كلمات اخرى',
                                  onTap: null,
                                ),
                              ),
                ],
              ),
            ),
          );
        }));
  }
}

dynamic showCustomDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: iconsColor.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (contextt, __, ___) {
      var locale = AppLocalizations.of(context)!;

      return Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
        body: BlocProvider(
            create: (BuildContext context) => sl<HomeBloc>(),
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (kDebugMode) {
                print("State:$state");
              }
              return Center(
                child: Container(
                  height: 130,
                  width: double.infinity,
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
                                      child: Container(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Text(
                                            locale.noCancelTheDeletion!,
                                            style: blackBoldTextStyle(
                                                context: context,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Text(
                                            locale.yesIWantToDelete!,
                                            style: blackBoldTextStyle(
                                                context: context,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(15)),
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
  );
}

class SelectedFilters extends StatelessWidget {
  const SelectedFilters({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: activeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: blackBoldTextStyle(
                      context: context, fontSize: 12, color: activeColor),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    "assets/svgs/cancel.svg",
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
      ],
    );
  }
}

class OptionBox extends StatelessWidget {
  const OptionBox({Key? key, required this.title, this.isFilter})
      : super(key: key);

  final String title;
  final bool? isFilter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isFilter != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/sort.svg",
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                Text(
                  title,
                  style: blackBoldTextStyle(context: context, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Archives extends StatefulWidget {
  Archives({Key? key, required this.searchProcessEntity}) : super(key: key);
     List<SearchProcessEntity> searchProcessEntity;
  @override
  State<Archives> createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.searchProcessEntity.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("المحفوظات",
                    style: blackBoldTextStyle(
                      context: context,
                      fontSize: 12,
                    )),
                GestureDetector(
                    onTap: () async {
                      await showCustomDialog(context).then((value) {
                        if (value == 200) {
                          BlocProvider.of<HomeBloc>(context)
                              .add(DeleteAllSearchProcessEvent());
                          widget.searchProcessEntity = [];

                          BlocProvider.of<HomeBloc>(context)
                              .add(GetAllSearchProcessEvent());
                        } else {
                          return 500;
                        }
                      });
                      if (!mounted) {
                        return;
                      }
                      setState(() {});
                    },
                    child: Text("مسح الكل",
                      style: blackBoldTextStyle(context: context, fontSize: 12, color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: SizedBox(
              height: size.height - 180,
              // color: Colors.green,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.searchProcessEntity.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ///Close keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                        searchTextController.text =
                            widget.searchProcessEntity[index].text;

                        if (searchTextController.text != "") {
                          BlocProvider.of<HomeBloc>(context).add(
                              SearchEvent(text: searchTextController.text));
                          setState(() {
                            showSearchHistory = false;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.searchProcessEntity[index].text,
                              style: blackBoldTextStyle(
                                  context: context, fontSize: 12),
                            ),
                            SvgPicture.asset(
                              "assets/svgs/arrow-up-left.svg",
                              color: Theme.of(context).canvasColor,
                              width: 15,
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
    );
  }
}
