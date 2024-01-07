import 'package:acadmiat/core/widgets/waiting_widget.dart';
import 'package:acadmiat/features/home_feature/presentation/pages/training_courses_page.dart';
import 'package:flutter/foundation.dart';
import '../../../../../../../core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Locale/locale.dart';
import '../../../../../../core/classes/constants.dart';
import '../../../../../../core/globals.dart';
import '../../../../../../core/util/assets_manager.dart';
import '../../../../../../core/widgets/empty_state_widget.dart';
import '../../../bloc/home_bloc.dart';
import '../../../bloc/home_event.dart';
import '../../../bloc/home_state.dart';
import '../../course_content/pages/course_content_page.dart';
import '../../courses_content_page.dart';
import '../../../../../../injection_container.dart';
import '../widgets/item_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (kDebugMode) {
            print("State:$state");
          }

          if (state is Empty) {
            BlocProvider.of<HomeBloc>(context).add(GetAllProductsFromFavLocalDBEvent());
          }
          if (state is SuccessGetAllProductsFromFav) {
            favEntity = state.favEntity;

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar:appBarWidget(locale.favorite!,context,false,null,null),
              body: (state.favEntity.isNotEmpty)?Padding(
                padding: const EdgeInsets.only(left: 17,right: 17,top:19),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: (118+11)*state.favEntity.length/1,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.favEntity.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){

                                  ///Package from courses
                                  if(state.favEntity[index].productType==ProductType.package){
                                    goTo(
                                        context,
                                            (context) => CoursesContentPage(
                                          cardId: state.favEntity[index].apiId,
                                              courseCover: state.favEntity[index].image,
                                        ));

                                  }
                                  ///For course and diploma
                                  else{
                                    goTo(context, (context) => CourseContentPage(
                                      cardId: state.favEntity[index].apiId,
                                      productType: ProductType.course,
                                      courseCover: state.favEntity[index].image
                                    ));
                                  }
                                },
                                child: ItemList(
                                  image: state.favEntity[index].image,
                                  trainer: state.favEntity[index].trainer,
                                  name: state.favEntity[index].name,
                                  oldPrice: state.favEntity[index].oldPrice,
                                  newPrice: state.favEntity[index].newPrice,
                                  onFavTap: (v) {
                                    BlocProvider.of<HomeBloc>(context).add(DeleteProductToFavLocalDBEvent(id:state.favEntity[index].apiId));
                                    if (!mounted) {
                                      return;
                                    }

                                    setState(() {
                                      state.favEntity.removeAt(index);
                                    });
                                  }, apiId: state.favEntity[index].apiId,),
                              );
                            }),
                      ),
                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
              ):  EmptyStateWidget(svg:ImgAssets.wishlist,
                text1:"المفضلة فارغة!",
                text3: "تصفح الدورات",
                onTap: () async {
                  await goTo(context, (context) => TrainingCoursesPage(latestEntity: const [],));
                  if(!mounted) return;
                  BlocProvider.of<HomeBloc>(context).add(GetAllProductsFromFavLocalDBEvent());
                },
              ),
            );
          }
          return const WaitingWidget();
        }
        )
    );
  }
}


