import 'package:acadmiat/core/globals.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/activities_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/case_stady_folder/case_stady_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/discussions_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/exams_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/glossary/glossary_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/lessons_tab.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/wiki_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Locale/locale.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/functions.dart';
import '../../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/use_cases/get_my_course/get_my_course_usecase.dart';
import '../../../bloc/bloc.dart';
import 'header_widget.dart';
import 'loading_widget.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key,
    required this.imageUrl,
    required this.courseId,
    required this.userId}) : super(key: key);

  final int userId;
  final int courseId;
  final String imageUrl;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final controller = PageController(initialPage: 0);
  final nestedController = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int page = 0;
  int nestedPage = 0;
  int value = 0;
  double offset = 0.0;
  List<Widget> tabsList = [];
  List<Widget> tabsPagesList = [];
  bool firstOne=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is Empty && firstOne) {
            firstOne=false;
            BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourse(getMyCourseParams: GetMyCourseParams(userId: userId(), courseId: widget.courseId)));/// => SuccessGetMyCourse
          }

          if (state is SuccessGetMyCourse) {
            List<Widget> tabsList = [];
            List<Widget> tabsPagesList = [];

            /// Lessons Tab
            tabsList.add(Tab(
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(locale.lessons!),
                ),
              ),);

            tabsPagesList.add(
              SingleChildScrollView(
                  child: LessonsTab(
                courseCover: widget.imageUrl,
                isVimeo: false,
                myCourseEntity: state.myCourseEntity,
              )),
            );

            ///Exams Tab
            if (state.myCourseEntity.quizz[0].quizzName != "No Quizz") {
              tabsList.add(Tab(
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(locale.tests!),
                ),
              ));
              tabsPagesList.add(
                ExamsTab(quizz: state.myCourseEntity.quizz),
              );
            }

            ///Assignments Tab
            if (state.myCourseEntity.assignments.isNotEmpty) {
              tabsList.add(const Tab(
                height: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("الواجبات"),
                ),
              ));
              tabsPagesList.add(
                AssignmentsTab(
                  assignments: state.myCourseEntity.assignments,
                  courseId: state.myCourseEntity.id,
                ),
              );
            }

            ///Case Study Tab
            if (state.myCourseEntity.caseStudy.isNotEmpty) {
              tabsList.add(
                const Tab(
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "الحالات الدراسية",
                    ),
                  ),
                ),
              );
              tabsPagesList.add(
                CaseStudyTab(
                  caseStudy: state.myCourseEntity.caseStudy,
                  courseId: state.myCourseEntity.id,
                ),
              );
            }

            ///Discussions Tab
            if (state.myCourseEntity.forum.forumName != "") {
              tabsList.add(
                const Tab(
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "النقاشات",
                    ),
                  ),
                ),
              );
              tabsPagesList.add(
                DiscussionsTab(
                  forum: state.myCourseEntity.forum,
                ),
              );
            }

            ///Glossary Tab
            if (state.myCourseEntity.glossary.name!="") {
              tabsList.add(
                Tab(
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      locale.terminology!,
                    ),
                  ),
                ),
              );
              tabsPagesList.add(
                GlossaryTab(
                  glossary: state.myCourseEntity.glossary,
                ),
              );
            }

            ///Wiki Tab
            if (state.myCourseEntity.wiki.articles.isNotEmpty) {
              tabsList.add(
                Tab(
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(locale.freeEncyclopedia!),
                  ),
                ),
              );
              tabsPagesList.add(
                SingleChildScrollView(
                    child: WikiTab(wiki: state.myCourseEntity.wiki)),
              );
            }

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: DefaultTabController(
                length: tabsPagesList.length,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        forceElevated: false,
                        collapsedHeight: kToolbarHeight,
                        expandedHeight: size.height*0.35,
                        elevation: 4,
                        backgroundColor: Theme.of(context).cardColor,
                        floating: true,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(20),
                          child: Column(
                            children: [
                              FadeAnimation(
                                child: Row(
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
                                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                        child: TabBar(
                                          isScrollable: (tabsList.length > 4)?true:false,
                                          labelColor: Theme.of(context).primaryColor,
                                          unselectedLabelColor: iconsColor,
                                          indicatorSize: TabBarIndicatorSize.tab,
                                          padding: EdgeInsets.zero,
                                          indicatorPadding: EdgeInsets.zero,
                                          labelStyle: blackBoldTextStyle(context: context, fontSize: 11,),
                                          indicator: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Theme.of(context).primaryColor.withOpacity(0.1)),
                                          tabs: tabsList,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: HeaderWidget(
                              heroTag: widget.courseId.toString(),
                              imageUrl: widget.imageUrl,
                              progress: state.myCourseEntity.progress,
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: tabsPagesList,
                  ),
                ),
              ),
            );
          }

          if (state is Error) {
            return Scaffold(appBar:appBarWidget("",context,true,null,null),
              body: EmptyStateWidget(svg:"assets/svgs/error.svg",
                text1:"عذرا! حدثت مشكلة غير متوقعة",
                text3: "حدث الان",
                onTap: () async {
                  BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourse(
                      getMyCourseParams: GetMyCourseParams(
                          userId: userId(), courseId: widget.courseId))); },
              ),
            );
          }

          if (state is NotActiveSubscriptionState) {
            return Scaffold(
                appBar:appBarWidget("",context,true,null,null),
              body:EmptyStateWidget(
                svg: "assets/svgs/expire.svg",
                text1: "نآسف لقد انتهى اشتراكك!",
                text3: "اعادة الاشتراك مرة ثانية",
                onTap: () {
                  bottomNavigationKey.currentState!.setPage(0);
                  Navigator.pop(context);
                },
              )
            );
          }

          return LoadingWidget(
            heroTag: widget.courseId.toString(),
            imageUrl: widget.imageUrl,
          );
        }));
  }

}





