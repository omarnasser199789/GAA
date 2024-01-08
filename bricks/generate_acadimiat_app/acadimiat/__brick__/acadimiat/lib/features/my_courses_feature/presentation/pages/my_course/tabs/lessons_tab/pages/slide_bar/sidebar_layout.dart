import 'package:acadmiat/features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/pages/slide_bar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../domain/entities/my_course_entity.dart';
import '../../../../../../bloc/my_courses_bloc.dart';
import '../../../../../../bloc/my_courses_event.dart';
import '../../../../../../bloc/my_courses_state.dart';
import '../../../../../../../../../injection_container.dart';
import '../lecture_page.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({super.key,
    required this.lectureId,
    required this.part,
    required this.index,
    required this.courseCover,
    required this.myCourseEntity,
    required this.mediaQueryPadding
  });

  final int lectureId;
  final MyCourseEntity myCourseEntity;
  final int part;
  final int index;
  final String courseCover;
  final EdgeInsets mediaQueryPadding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
            builder: (context, state) {
          if (state is Empty) {
            BlocProvider.of<MyCoursesBloc>(context).add(LaunchNewVideoEvent(
              lectureId: lectureId,
              myCourseEntity: myCourseEntity,
              part: part,
              index: index,
              courseCover: courseCover,
              mediaQueryPadding: mediaQueryPadding,
            ));
          }
          if (state is LecturePage) {
            return Stack(
              children: <Widget>[
                state,
                SideBar(
                  courseCover:    courseCover,
                  myCourseEntity: myCourseEntity,
                ),
              ],
            );
          }
          return Container();
        }));
  }
}
