import 'package:acadmiat/features/home_feature/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:flutter/foundation.dart';
import '../../../../Theme/style.dart';
import '../../../../core/classes/constants.dart';
import '../../../../core/globals.dart';
import '../../../../core/widgets/course_cart_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/latest_entity.dart';
import '../../domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'course_content/pages/course_content_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/loading_courses_widget.dart';

class TrainingCoursesPage extends StatefulWidget {
    TrainingCoursesPage({super.key,required this.latestEntity});
   List<LatestEntity>  latestEntity;

  @override
  State<TrainingCoursesPage> createState() => _TrainingCoursesPageState();
}

class _TrainingCoursesPageState extends State<TrainingCoursesPage> {
  Size itemSize = const Size(0, 100);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("TrainingCoursesState:$state");
          }
          if(widget.latestEntity.isEmpty){
            ///1-Get data from locale DB
            ///2-Get data from server.
            ///3-View the data we have collected from locale DB.
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server
            BlocProvider.of<HomeBloc>(context).add(GetTrainingCoursesFromLocaleDBEvent()); /// => SuccessGetTrainingCourses
            // BlocProvider.of<HomeBloc>(context).add(GetLatest());
          }

          ///Success get training courses from locale DB.
          if(state is SuccessGetTrainingCourses){
            ///2-Get data from server.
            BlocProvider.of<HomeBloc>(context).add(GetLatest());///=> latestIsLoaded

            ///If there is no item store in local db, we should view loading widget
            ///while the data is fetched.
            if (state.trainingCoursesEntity.isEmpty) {
              return const LoadingCoursesWidget(
                title: "",
              );
            }

            widget.latestEntity= [];

            for(var item in state.trainingCoursesEntity){
              widget.latestEntity.add(
                  LatestEntity(
                    id:item.apiId,
                    header: item.courseName,
                    authorized: false,
                    image: item.image,
                    trainer: item.trainerName,
                    squareImage: '',
                    courseLink: '',
                    price:  item.oldPrice,
                    categories: const [],
                    newPrice: item.newPrice,
                    numberOfCourses: 0,
                    discount: false, isCourse:true,
                  )


              );
            }

          }



          ///Training Courses uploaded
          ///type=3 => Training Courses
          if (state is latestIsLoaded) {


            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server

            ///Update diplomas and packages in locale DB.
            ///1-Generate diplomas anf packages list.
            List<UpdateTrainingCoursesParams> list = [];
            for (int i = 0; state.latestEntity.length > i; i++) {

              bool itemExit=false;
              for(var item in list){
                if(item.apiId==state.latestEntity[i].id){
                  itemExit=true;
                }
              }
              if(itemExit==false){
                list.add(UpdateTrainingCoursesParams(
                  apiId: state.latestEntity[i].id,
                  image: state.latestEntity[i].image,
                  courseName: state.latestEntity[i].header,
                  trainerName: state.latestEntity[i].trainer,
                  newPrice: state.latestEntity[i].newPrice,
                  oldPrice: state.latestEntity[i].price,
                  fav: 0,
                ));
              }
            }



            ///Store data in locale DB event
            BlocProvider.of<HomeBloc>(context)
                .add(UpdateTrainingCoursesInLocaleDBEvent(params: list));


           for (var item in state.latestEntity){
             widget.latestEntity.add(
                 LatestEntity(
                     id: item.id,
                     header: item.header,
                     authorized: item.authorized,
                     image: item.image,
                     trainer: item.trainer,
                     squareImage: item.squareImage,
                     courseLink: item.courseLink,
                     price: item.price,
                     categories: item.categories,
                     newPrice: item.newPrice,
                     numberOfCourses: item.numberOfCourses,
                     discount: item.discount,
                     isCourse: item.isCourse)
             );
           }

          }


          return Scaffold(

            appBar: appBarWidget("الدورات التدريبية",context,true,[
              GestureDetector(
                onTap: (){
                  goTo(context, (context) =>  const SearchPage());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    // color: Colors.red,
                    child: SvgPicture.asset(
                      "assets/svgs/search.svg",
                      color:iconsColor,
                    ),
                  ),
                ),
              ),

              // CartWidget(),

            ],null),
            body: GridView.builder(
                padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17,top:17),
                gridDelegate:
                 SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17),
                itemCount: widget.latestEntity.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () async {

                      goTo(
                          context,
                              (context) => CourseContentPage(
                            cardId: widget.latestEntity[index].id,
                            productType: ProductType.course,
                                courseCover: widget.latestEntity[index].image,
                          ));
                      // }
                    },

                    ///Show data From server
                    child: CourseCartWidget(
                      image: widget.latestEntity[index].image,
                      title: widget.latestEntity[index].header,
                      trainer: widget.latestEntity[index].trainer,
                      newPrice: widget.latestEntity[index].newPrice,
                      price: widget.latestEntity[index].price,
                      numberOfCourses: widget.latestEntity[index].numberOfCourses,
                      isCourse: null,// widget.latestEntity[index].isCourse,
                      height: 100,
                      id: widget.latestEntity[index].id,
                      productType: (widget.latestEntity[index].isCourse == true) ? ProductType.diplom : ProductType.package,

                    ),
                  );

                }),
          );


        }));




  }
}
