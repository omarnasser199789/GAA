import 'package:acadmiat/core/widgets/app_bar_widget.dart';
import 'package:acadmiat/core/widgets/empty_state_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Theme/style.dart';
import '../../../../../../core/classes/constants.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/course_cart_widget.dart';
import '../../../../domain/entities/latest_entity.dart';
import '../../../../domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import '../../../../domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import '../../course_content/pages/course_content_page.dart';
import '../../../../../../injection_container.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:measure_size/measure_size.dart';
import '../../courses_content_page.dart';
import '../../diplomas_and_packages_page.dart';
import '../../training_courses_page.dart';
import '../../../widgets/loading_courses_widget.dart';

class TrainingCoursesWidget extends StatefulWidget {
  const TrainingCoursesWidget(
      { Key? key,
        required this.title,
        required this.type,
        this.isDiploma,
        this.showFavBtn,
        this.isNew,
        this.enableBroadcast,
        this.categoryId,
        this.categoryName,
       this.disableTitleOnImage
      })
      : super(key: key);

  final String title;
  final bool? showFavBtn;
  final bool? enableBroadcast;
  final bool? disableTitleOnImage;
  final bool? isDiploma;
  final bool? isNew;
  final int type;
  final int? categoryId;
  final String? categoryName;

  @override
  State<TrainingCoursesWidget> createState() => _TrainingCoursesWidgetState();
}

class _TrainingCoursesWidgetState extends State<TrainingCoursesWidget> {
  Size itemSize = Size(0, 100);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("TrainingCoursesState:$state");
          }

          ///type = 2 => Diplomas and packages
          if (state is Empty && widget.type == 2) {
            ///1-Get data from locale DB
            ///2-Get data from server.
            ///3-View the data we have collected from locale DB.
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server
            BlocProvider.of<HomeBloc>(context).add(GetDiplomasAndPackagesFromLocaleDBEvent());/// => SuccessGetDiplomasAndPackagesFromLocaleDB
          }

          ///Success get diplomas and packages from locale DB.
          else if (state is SuccessGetDiplomasAndPackagesFromLocaleDB) {
            ///2-Get data from server.
            BlocProvider.of<HomeBloc>(context).add(GetLatestP()); /// => latestPIsLoaded

            ///If there is no item store in local db, we should view loading widget
            ///while the data is fetched.
            if (state.diplomasAndPackagesEntity.isEmpty) {
              return LoadingCoursesWidget(
                title: widget.title,
              );
            }

            ///If there is data in local db
            ///3-View the data that we have collected from locale DB.
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 8),
                  child: Text(widget.title, style: blackBoldTextStyle(context: context, fontSize: 15)),
                ),
                SizedBox(
                  height: 290,
                  width: double.infinity,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(right: 18),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.diplomasAndPackagesEntity.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: GestureDetector(
                            onTap: () {
                              if (state.diplomasAndPackagesEntity[index].isCourse == 1) {
                                goTo(context,
                                    (context) => CourseContentPage(
                                      cardId: state.diplomasAndPackagesEntity[index].apiId,
                                      productType: ProductType.course,
                                      courseCover: state.diplomasAndPackagesEntity[index].image
                                    ));
                              } else {
                                goTo(context, (context) => CoursesContentPage(
                                  cardId: state.diplomasAndPackagesEntity[index].apiId,
                                      courseCover:  state.diplomasAndPackagesEntity[index].image,
                                ));
                              }
                            },

                            ///Show data From local db
                            child: CourseCartWidget(
                              image: state.diplomasAndPackagesEntity[index].image,
                              title: state.diplomasAndPackagesEntity[index].courseName,
                              trainer: state.diplomasAndPackagesEntity[index].trainerName,
                              price: state.diplomasAndPackagesEntity[index].oldPrice,
                              newPrice: state.diplomasAndPackagesEntity[index].newPrice,
                              numberOfCourses: state.diplomasAndPackagesEntity[index].numberOfCourses, //state.latestPEntity[index].numberOfCourses,
                              isCourse: (state.diplomasAndPackagesEntity[index].isCourse == 1) ? true : false,
                              height: 140,
                              width: 240,
                              id: state.diplomasAndPackagesEntity[index].apiId,
                              productType: (state.diplomasAndPackagesEntity[index].isCourse == 1) ? ProductType.diplom : ProductType.package,

                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }

          ///Diplomas and packages uploaded
          ///type=2 => Diplomas and packages
          else if (state is latestPIsLoaded && widget.type == 2) {
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server

            ///Update diplomas and packages in locale DB.
            ///1-Generate diplomas anf packages list.
            List<UpdateDiplomasAndPackagesParams> list = [];
            if(state.latestPEntity.isNotEmpty){
              if(state.latestPEntity.length>=5){
                for (int i = 0; 5 > i; i++) {
                    list.add(UpdateDiplomasAndPackagesParams(
                      apiId: state.latestPEntity[i].id,
                      image: state.latestPEntity[i].image,
                      courseName: state.latestPEntity[i].header,
                      trainerName: state.latestPEntity[i].trainer,
                      newPrice: state.latestPEntity[i].newPrice,
                      oldPrice: state.latestPEntity[i].price,
                      fav: 0,
                      isCourse: (state.latestPEntity[i].isCourse) ? 1 : 0,
                      numberOfCourses: state.latestPEntity[i].numberOfCourses,
                    ));
                }
              }
              else{
                for (int i = 0; state.latestPEntity.length > i; i++) {
                  list.add(UpdateDiplomasAndPackagesParams(
                    apiId: state.latestPEntity[i].id,
                    image: state.latestPEntity[i].image,
                    courseName: state.latestPEntity[i].header,
                    trainerName: state.latestPEntity[i].trainer,
                    newPrice: state.latestPEntity[i].newPrice,
                    oldPrice: state.latestPEntity[i].price,
                    fav: 0,
                    isCourse: (state.latestPEntity[i].isCourse) ? 1 : 0,
                    numberOfCourses: state.latestPEntity[i].numberOfCourses,
                  ));
                }
              }

            }
            ///Store data in locale DB event
            BlocProvider.of<HomeBloc>(context).add(UpdateDiplomasAndPackagesFromLocaleDBEvent(params: list));

            List<Widget> widgetList=[];

            if(state.latestPEntity.isNotEmpty){
              if(state.latestPEntity.length>=5){
                for(int i=0; i<5; i++){
                  widgetList.add(Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: GestureDetector(
                      onTap: () async {

                        ///Actually we tow tye of pages to show
                        ///one for course and diploma
                        ///and other for courses

                        ///1-for course and diploma
                        if (state.latestPEntity[i].isCourse) {
                          goTo(context, (context) => CourseContentPage(
                            cardId: state.latestPEntity[i].id,
                            productType: ProductType.course,
                            courseCover:state.latestPEntity[i].image,

                          ));
                        }

                        ///2-for courseS
                        else {
                          goTo(context, (context) => CoursesContentPage(cardId: state.latestPEntity[i].id, courseCover: state.latestPEntity[i].image,));
                        }
                      },

                      ///Show data From server
                      child: CourseCartWidget(
                        image: state.latestPEntity[i].image,
                        title: state.latestPEntity[i].header,
                        trainer: state.latestPEntity[i].trainer,
                        newPrice: state.latestPEntity[i].newPrice,
                        price: state.latestPEntity[i].price,
                        numberOfCourses:
                        state.latestPEntity[i].numberOfCourses,
                        isCourse: state.latestPEntity[i].isCourse,
                        height: 140,
                        width: 240,
                        id: state.latestPEntity[i].id,
                        productType: (state.latestPEntity[i].isCourse == true) ? ProductType.diplom : ProductType.package,

                      ),
                    ),
                  ));
                }
              }
              else {
                for (int i = 0; i < state.latestPEntity.length; i++) {
                  widgetList.add(Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: GestureDetector(
                      onTap: () async {

                        ///Actually we tow tye of pages to show
                        ///one for course and diploma
                        ///and other for courses

                        ///1-for course and diploma
                        if (state.latestPEntity[i].isCourse) {
                          goTo(context, (context) =>
                              CourseContentPage(
                                cardId: state.latestPEntity[i].id,
                                productType: ProductType.course,
                                courseCover: state.latestPEntity[i].image,

                              ));
                        }

                        ///2-for courseS
                        else {
                          goTo(context, (context) => CoursesContentPage(cardId: state.latestPEntity[i].id, courseCover: state.latestPEntity[i].image,));
                        }
                      },

                      ///Show data From server
                      child: CourseCartWidget(
                        image: state.latestPEntity[i].image,
                        title: state.latestPEntity[i].header,
                        trainer: state.latestPEntity[i].trainer,
                        newPrice: state.latestPEntity[i].newPrice,
                        price: state.latestPEntity[i].price,
                        numberOfCourses:
                        state.latestPEntity[i].numberOfCourses,
                        isCourse: state.latestPEntity[i].isCourse,
                        height: 140,
                        width: 240,
                        id: state.latestPEntity[i].id,
                        productType: (state.latestPEntity[i].isCourse == true) ? ProductType.diplom : ProductType.package,
                      ),
                    ),
                  ));
                }
              }
            }


            if(widgetList.isNotEmpty){
              widgetList.add(GestureDetector(
                onTap: (){
                  goTo(context, (context) => DiplomasAndPackagesPage(latestPEntity:state.latestPEntity));
                },
                child: Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 200,
                    child: Text("مشاهدة المزيد",style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),)),
              ));
            }

            if(widgetList.isNotEmpty){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 8),
                    child: Text(widget.title, style: blackBoldTextStyle(context: context, fontSize: 15)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: SizedBox(
                      height: 290,
                      width: double.infinity,
                      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: widgetList,)),
                    ),
                  ),
                ],
              );
            }else{
              return Container();
            }
          }

          /// To get the new courses
          else if(state is Empty && widget.type == 3 && widget.isNew == true){
            BlocProvider.of<HomeBloc>(context).add(GetLatestC());
          }

          else if (state is Empty && widget.type == 3 && widget.isNew == false) {
            ///1-Get data from locale DB
            ///2-Get data from server.
            ///3-View the data we have collected from locale DB.
            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server
            BlocProvider.of<HomeBloc>(context).add(GetTrainingCoursesFromLocaleDBEvent()); /// => SuccessGetTrainingCourses
          }

          ///Success get training courses from locale DB.
          else if(state is SuccessGetTrainingCourses){
            ///2-Get data from server.
            BlocProvider.of<HomeBloc>(context).add(GetLatest());///=> latestIsLoaded

            ///If there is no item store in local db, we should view loading widget
            ///while the data is fetched.
            if (state.trainingCoursesEntity.isEmpty || widget.categoryId != null) {
              return LoadingCoursesWidget(title: widget.title);
            }

            List<Widget> list=[];

            if(state.trainingCoursesEntity.isNotEmpty){
              if(state.trainingCoursesEntity.length>=5){
                for(int i=0;i<5;i++){
                  list.add(Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: GestureDetector(
                      onTap: () {
                        goTo(context, (context) => CourseContentPage(cardId: state.trainingCoursesEntity[i].apiId, productType: ProductType.course,courseCover: state.trainingCoursesEntity[i].image));
                      },
                      child: CourseCartWidget(
                        image: state.trainingCoursesEntity[i].image,
                        title: state.trainingCoursesEntity[i].courseName,
                        trainer: state.trainingCoursesEntity[i].trainerName,
                        newPrice: state.trainingCoursesEntity[i].newPrice,
                        price: state.trainingCoursesEntity[i].oldPrice,
                        height: 148,
                        width: 240,
                        id: state.trainingCoursesEntity[i].id,
                        productType: ProductType.course,
                      ),
                    ),
                  ));
                }
              }
              else{
                for(int i=0;i<state.trainingCoursesEntity.length;i++){
                  list.add(Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: GestureDetector(
                      onTap: () {
                        goTo(
                            context,
                                (context) => CourseContentPage(
                              cardId: state.trainingCoursesEntity[i].apiId,
                              productType: ProductType.course,
                              courseCover: state.trainingCoursesEntity[i].image,
                            ));
                      },
                      child: CourseCartWidget(
                        image: state.trainingCoursesEntity[i].image,
                        title: state.trainingCoursesEntity[i].courseName,
                        trainer: state.trainingCoursesEntity[i].trainerName,
                        newPrice: state.trainingCoursesEntity[i].newPrice,
                        price: state.trainingCoursesEntity[i].oldPrice,
                        height: 148,
                        width: 240,
                        id: state.trainingCoursesEntity[i].id,
                        productType: ProductType.course,
                      ),
                    ),
                  ));
                }
              }
            }

            ///If there is data in local db
            ///3-View the data we have collected from locale DB.
            return Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 8),
                      child: Text(widget.title, style: blackBoldTextStyle(context: context, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SizedBox(
                        height: 268,
                        width: size.width-17,
                        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: list,)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          ///Training Courses uploaded
          ///type=3 => Training Courses
          if (state is latestIsLoaded && widget.type == 3) {


            ///4-When data come from server,will will hide data from locale DB and
            ///show data from server

            ///Update diplomas and packages in locale DB.
            ///1-Generate diplomas anf packages list.
            List<UpdateTrainingCoursesParams> list = [];
            if(state.latestEntity.length>5) {
              for (int i = 0; 5 > i; i++) {
                bool itemExit = false;
                for (var item in list) {
                  if (item.apiId == state.latestEntity[i].id) {
                    itemExit = true;
                  }
                }
                if (itemExit == false) {
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
            }
            else{
              for (var element in state.latestEntity) {
                bool itemExit = false;
                for (var item in list) {
                  if (item.apiId == element.id) {
                    itemExit = true;
                  }
                }
                if (itemExit == false) {
                  list.add(UpdateTrainingCoursesParams(
                    apiId: element.id,
                    image: element.image,
                    courseName: element.header,
                    trainerName: element.trainer,
                    newPrice: element.newPrice,
                    oldPrice: element.price,
                    fav: 0,
                  ));
                }
              }
            }

            ///Store data in locale DB event
            BlocProvider.of<HomeBloc>(context).add(UpdateTrainingCoursesInLocaleDBEvent(params: list));

            if (widget.categoryId != null) {
              List<LatestEntity> latestEntity = [];
              for (var item in state.latestEntity) {
                for(var cat in item.categories){
                  if(widget.categoryName!.contains(cat.categoryName)){
                    if(doesTheCourseNotAlreadyExist(latestEntity,item)){
                      latestEntity.add(item);
                    }
                  }
                }
              }
              return (latestEntity.isNotEmpty)?
              GridView.builder(
                  padding: const EdgeInsets.only(left: 17, right: 17, top: 17,bottom: 17),
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                   SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 17),
                  itemCount: latestEntity.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return MeasureSize(
                      onChange: (size) {
                        if (!mounted) {
                          return;
                        }

                        setState(() {
                          itemSize = size;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          goTo(context, (context) => CourseContentPage(
                            cardId:latestEntity[index].id,
                            productType: ProductType.course,
                            courseCover: latestEntity[index].image,));
                        },
                        child: CourseCartWidget(
                          image: latestEntity[index].image,
                          title: latestEntity[index].header,
                          trainer: latestEntity[index].trainer,
                          newPrice: latestEntity[index].newPrice,
                          price: latestEntity[index].price,
                          height: 94,
                          id: latestEntity[index].id,
                          productType: ProductType.course,
                        ),
                      ),
                    );

                  }):
              EmptyStateWidget(svg:ImgAssets.learning, text1:"لا يوجد دورات متاحة الان", text3: "عوده للخلف", onTap: () async {Navigator.pop(context);},);
            }

            List<Widget> widgetList=[];
            if(state.latestEntity.length>5) {
              for (int i = 0; i < 5; i++) {
                widgetList.add(Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: GestureDetector(
                    onTap: () {
                      goTo(context, (context) => CourseContentPage(cardId: state.latestEntity[i].id, productType: ProductType.course, courseCover: state.latestEntity[i].image,));
                    },
                    child: CourseCartWidget(
                      image: state.latestEntity[i].image,
                      title: state.latestEntity[i].header,
                      trainer: state.latestEntity[i].trainer,
                      newPrice: state.latestEntity[i].newPrice,
                      price: state.latestEntity[i].price,
                      height: 148,
                      width: 240,
                      id: state.latestEntity[i].id,
                      productType: ProductType.course,
                    ),
                  ),
                ));
              }
            }else{
              for (var item in state.latestEntity) {
                widgetList.add(Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: GestureDetector(
                    onTap: () {
                      goTo(context, (context) => CourseContentPage(cardId: item.id, productType: ProductType.course, courseCover: item.image,));
                    },
                    child: CourseCartWidget(
                      image: item.image,
                      title: item.header,
                      trainer: item.trainer,
                      newPrice: item.newPrice,
                      price: item.price,
                      height: 148,
                      width: 240,
                      id: item.id,
                      productType: ProductType.course,
                    ),
                  ),
                ));
              }
            }

            if(widgetList.isNotEmpty){
              widgetList.add(GestureDetector(
                onTap: (){goTo(context, (context) => TrainingCoursesPage(latestEntity:state.latestEntity));},
                child: Container(
                    alignment: Alignment.center,
                    height: 268,
                    width: 200,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text("مشاهدة المزيد",style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),)),
              ));
            }
            /// training courses from server
            if(widgetList.isNotEmpty){ return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title, style: blackBoldTextStyle(context: context, fontSize: 15),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: SizedBox(
                    height: 268,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: widgetList,)),
                  ),
                ),
              ],
            );}
            else{return Container();}
          }

          if (state is latestCIsLoaded && widget.type == 3 && widget.isNew == true) {
            List<Widget> widgetList=[];
            if(state.latestEntity.length>5){
              for(int i =0; i<5 ; i++){
                widgetList.add(Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: GestureDetector(
                    onTap: () {
                      goTo(context, (context) => CourseContentPage(cardId: state.latestEntity[i].id, productType: ProductType.course, courseCover:  state.latestEntity[i].image,));
                    },
                    child: CourseCartWidget(
                      image: state.latestEntity[i].image,
                      title: state.latestEntity[i].header,
                      trainer: state.latestEntity[i].trainer,
                      newPrice: state.latestEntity[i].newPrice,
                      price: state.latestEntity[i].price,
                      height: 148,
                      width: 240,
                      id: state.latestEntity[i].id,
                      productType: ProductType.course,
                    ),
                  ),
                ));
              }
            }else{
              for(var item in state.latestEntity ){
                widgetList.add(Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: GestureDetector(
                    onTap: () {
                      goTo(context, (context) => CourseContentPage(cardId: item.id,productType: ProductType.course,courseCover:  item.image,));
                    },
                    child: CourseCartWidget(
                      image: item.image,
                      title: item.header,
                      trainer: item.trainer,
                      newPrice: item.newPrice,
                      price: item.price,
                      height: 148,
                      width: 240,
                      id: item.id,
                      productType: ProductType.course,
                    ),
                  ),
                ));
              }
            }

            if(widgetList.isNotEmpty){
              widgetList.add(GestureDetector(
                onTap: (){goTo(context, (context) => TrainingCoursesPage(latestEntity:state.latestEntity));},
                child: Container(
                    alignment: Alignment.center,
                    height: 268,
                    width: 200,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text("مشاهدة المزيد",style: blackBoldTextStyle(fontSize: 15, context: context,color: Theme.of(context).primaryColor),)),
              ));
            }



            /// training courses from server
            if(widgetList.isNotEmpty){
              return Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.title, style: blackBoldTextStyle(context: context, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( right: 17),
                    child: SizedBox(
                      height: 268,
                      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: widgetList,)),
                    ),
                  ),
                ],
              );
            }else{
              return Container();
            }
          }

          ///Show loading widget for each of the (Diplomas, packages and training courses)
          return LoadingCoursesWidget(
            title: widget.title,
          );
        }));
  }

  bool doesTheCourseNotAlreadyExist(List<LatestEntity> latestEntity, LatestEntity item) {
    for(var i in latestEntity){
      if(i.id == item.id) {
        return false;
      }
    }
    return true;
  }
}



