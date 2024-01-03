import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../injection_container.dart';
import '../../../../my_courses_feature/data/models/my_courses_model.dart';
import '../../../../my_courses_feature/domain/entities/my_courses_entity.dart';
import '../../../../my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import '../../../../my_courses_feature/presentation/bloc/my_courses_event.dart';
import '../../../../my_courses_feature/presentation/bloc/my_courses_state.dart';
import 'result_widget.dart';

class KeepWatchingCoursesWidget extends StatefulWidget {
  const KeepWatchingCoursesWidget({super.key});

  @override
  State<KeepWatchingCoursesWidget> createState() => _KeepWatchingCoursesWidgetState();
}

class _KeepWatchingCoursesWidgetState extends State<KeepWatchingCoursesWidget> {

  List<MyCoursesEntity> myCoursesEntity=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => sl<MyCoursesBloc>(),
        child:  BlocBuilder<MyCoursesBloc, MyCoursesState>(
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
                BlocProvider.of<MyCoursesBloc>(context).add(GetMyCoursesFromLocaleDBEvent());/// : => SuccessGetMyCoursesFromLocaleDBState.
                // BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourses());



              }

              if(state is SuccessGetMyCoursesFromLocaleDBState){
                ///2-Get data from server.
                BlocProvider.of<MyCoursesBloc>(context).add(GetMyCourses());/// : => Loaded.
                ///If there is no item store in local db, we should view loading widget
                ///while the data is fetched.

                if(state.myCoursesEntity.isEmpty){
                  ///Loading Widget.
                  return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: Theme.of(context).primaryColor,
                      )
                  );

                }

                ///If there is data in local db
                ///3-View the data we have collected from locale DB.
                myCoursesEntity=[];
                myCoursesEntity=state.myCoursesEntity;
              }

              if(state is Loaded){

                ///4-When data come from server,will will hide data from locale DB and
                ///show data from server

                ///Update myCourses in locale DB.
                ///1-Generate myCourses list.
                List<MyCoursesModel> list=[];
                for(int i=0;state.myCoursesEntity.length>i;i++)
                {
                  list.add(MyCoursesModel(
                    id: state.myCoursesEntity[i].id,
                    header: state.myCoursesEntity[i].header,
                    authorized:state.myCoursesEntity[i].authorized,
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
                BlocProvider.of<MyCoursesBloc>(context).add(UpdateMyCoursesFromLocaleDBEvent(params: list));/// : => no thing



                myCoursesEntity=[];
                myCoursesEntity=state.myCoursesEntity;

              }

              if(state is Loading){
                return const WaitingWidget();
              }

              if(myCoursesEntity.isNotEmpty) {
                return ResultWidget(myCoursesEntity: myCoursesEntity,);
              }
              else{return Container();}
            })

    );
  }
}





