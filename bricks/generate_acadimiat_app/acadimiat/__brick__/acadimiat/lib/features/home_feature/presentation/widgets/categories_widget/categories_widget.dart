import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import '../../../../../injection_container.dart';
import '../../../domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'loading_categories_widget.dart';

import 'category_item_list.dart';
class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (kDebugMode) {
                print("Categories State:$state");
              }
              if (state is Empty ) {
                ///1-Get data from locale DB
                ///2-Get data from server.
                ///3-View the data we have collected from locale DB.
                ///4-When data come from server,will will hide data from locale DB and
                ///show data from server
                BlocProvider.of<HomeBloc>(context).add(GetCategoriesFromLocaleDBEvent());

              }

              ///Success get categories from locale DB.
              if(state is SuccessGetCategoriesFromLocalDB){
                ///2-Get data from server.
                BlocProvider.of<HomeBloc>(context).add(GetCategories());
                ///If there is no item store in local db, we should view loading widget
                ///while the data is fetched.
                if(state.categoriesFromLocalDBEntity.isEmpty){
                  return const LoadingCategoriesWidget();
                }

                List<Widget> widgetList = [];


                for(int i=0; i<state.categoriesFromLocalDBEntity.length;i++){
                  if(state.categoriesFromLocalDBEntity[i].numberOfCourses>0){
                    widgetList.add(CategoryItemList(
                        index: i,
                        categoryName: state.categoriesFromLocalDBEntity[i].name,
                        categoryId: state.categoriesFromLocalDBEntity[i].categoryId,
                        image: state.categoriesFromLocalDBEntity[i].image,
                        categoryCourses:state.categoriesFromLocalDBEntity[i].numberOfCourses
                    ));
                  }
                }

                if(widgetList.isEmpty) return Container();

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 8),
                          child: Text(locale.categories!,style: blackBoldTextStyle(context: context,fontSize:15),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widgetList,
                          ),
                        ),

                      ),
                    ),
                  ],
                );

              }

              if(state is CategoriesIsLoaded){
                ///4-When data come from server,will will hide data from locale DB and
                ///show data from server

                ///Update categories in locale DB.
                ///1-Generate categories list.
                List<UpdateCategoriesParams> list=[];
                for(int i=0;state.categoriesEntity.length>i;i++)
                {
                  list.add(UpdateCategoriesParams(
                      categoryId: state.categoriesEntity[i].categoryId,
                      image:"" ,
                      name: state.categoriesEntity[i].categoryName,
                      numberOfCourses: state.categoriesEntity[i].categoryCourses)
                  );
                }
                ///Store data in locale DB event
                BlocProvider.of<HomeBloc>(context).add(UpdateCategoriesFromLocaleDBEvent(params: list));

                List<Widget> widgetList = [];

                for(int i=0; i<state.categoriesEntity.length;i++){
                  if(state.categoriesEntity[i].categoryCourses>0){
                    widgetList.add(CategoryItemList(
                        index: i,
                        categoryName: state.categoriesEntity[i].categoryName,
                        categoryId: state.categoriesEntity[i].categoryId,
                        image: "",
                        categoryCourses:state.categoriesEntity[i].categoryCourses
                    ));
                  }

                }

                if(widgetList.isEmpty) return Container();

                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18,left: 18,right: 18,bottom: 8),
                          child: Text(locale.categories!,style: blackBoldTextStyle(context: context,fontSize:15),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widgetList,
                          ),
                        ),

                      ),
                    ),
                  ],
                );
              }

              return const LoadingCategoriesWidget();
            }));

  }
}








