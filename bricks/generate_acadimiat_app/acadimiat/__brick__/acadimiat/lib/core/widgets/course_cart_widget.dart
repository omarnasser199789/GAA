import 'package:acadmiat/core/widgets/is_course_widget.dart';
import 'package:acadmiat/core/widgets/price_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import '../../Theme/style.dart';
import '../../features/home_feature/data/models/fav_model.dart';
import '../../features/home_feature/domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import '../../features/home_feature/presentation/bloc/home_bloc.dart';
import '../../features/home_feature/presentation/bloc/home_event.dart';
import '../../features/home_feature/presentation/bloc/home_state.dart';
import '../../injection_container.dart';
import '../functions.dart';
import '../globals.dart';
import 'cached_net_work_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCartWidget extends StatelessWidget {
  const CourseCartWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.trainer,
      required this.newPrice,
      required this.height,
      this.width,
      required this.id,
      required this.productType,
      required this.price,
      this.loading,
      this.numberOfCourses,
      this.isCourse})
      : super(key: key);

  final String image;
  final String title;
  final String trainer;
  final double newPrice;
  final double height;
  final double? width;
  final double price;
  final int? numberOfCourses;
  final int id;
  final int productType;
  final bool? isCourse;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => sl<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Container(
            width: width ?? 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SizedBox(
                  width: width ?? 260,
                  height: height,
                  child: Stack(
                    children: [
                      CachedNetWorkImage(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        url: image,
                        boxFit: BoxFit.cover,
                      ),
                      CachedNetWorkImage(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        url: image,
                        boxFit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height + 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 7, right: 7, top: 8),
                        child: Text(
                          title,
                          maxLines: 2,
                          style: blackBoldTextStyle(
                              context: context, fontSize: 13, height: 1.5),
                        ),
                      ),
                      if (isCourse != null && newPrice != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: IsCourseWidget(
                            isCourse: isCourse!,
                            numberOfCourses: numberOfCourses ?? 0,
                          ),
                        ),
                      if ( //
                          // isCourse!=null &&
                          newPrice == 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: Text(
                            trainer,
                            style: blackBoldTextStyle(
                                fontSize: 12,
                                context: context,
                                color: iconsColor),
                            maxLines: 1,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PriceWidget(
                              newPrice: newPrice,
                              price: price,
                            ),
                            if (isCourse != null && newPrice == 0)
                              IsCourseWidget(
                                isCourse: isCourse!,
                                numberOfCourses: numberOfCourses ?? 0,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height - 25, left: 5, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: (loading == false || loading == null)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FavoriteButton(
                              iconSize: 35,
                              iconColor: Theme.of(context).primaryColor,
                              isFavorite: isFavOrNot(id) > -1,
                              valueChanged: (v) {
                                int index = isFavOrNot(id);

                                if (index > -1) {
                                  if (kDebugMode) {
                                    print("Delete from fav table");
                                  }
                                  favEntity.removeAt(index);
                                  BlocProvider.of<HomeBloc>(context).add(DeleteProductToFavLocalDBEvent(id: id));
                                } else {
                                  if (kDebugMode) {
                                    print("Add from fav table");
                                  }

                                  favEntity.add(FavModel(
                                    id: 0,
                                    apiId: id,
                                    productType: productType,
                                    name: title,
                                    image: image,
                                    trainer: trainer,
                                    newPrice: newPrice,
                                    oldPrice: price,
                                    fav: 1,
                                  ));

                                  BlocProvider.of<HomeBloc>(context).add(
                                      AddProductToFavLocalDBEvent(
                                          addProductToFavParams:
                                              AddProductToFavParams(
                                                  apiId: id,
                                                  productType: productType,
                                                  name: title,
                                                  trainer: trainer,
                                                  newPrice: newPrice,
                                                  oldPrice: price,
                                                  image: image,
                                                  fav: 1)));
                                }
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(3),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              strokeWidth: 0.8,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
