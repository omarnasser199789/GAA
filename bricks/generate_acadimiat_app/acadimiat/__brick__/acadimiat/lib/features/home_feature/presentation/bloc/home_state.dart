import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../../domain/entities/Categories_from_local_db_entity.dart';
import '../../domain/entities/banners_entity.dart';
import '../../domain/entities/card_by_id_entity.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/consultancies_from_local_db_entity.dart';
import '../../domain/entities/counsultancy_entity.dart';
import '../../domain/entities/diplomas_and_packages_entity.dart';
import '../../domain/entities/fav_entity.dart';
import '../../domain/entities/latest_entity.dart';
import '../../domain/entities/latestp_entity.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/entities/search_process_entity.dart';
import '../../domain/entities/training_courses_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class Empty extends HomeState {}

class YourLoadingState extends HomeState {}

class Loading extends HomeState {}

class NoEvent extends HomeState {}

class Error extends HomeState {
  final String message;

  Error({required this.message}); //we use this constructor in ((BLOC & test))

  List<Object> get props => [message];
}

class latestPIsLoaded extends HomeState {
  final List<LatestPEntity> latestPEntity; //Entities form domain

  latestPIsLoaded(
      {required this.latestPEntity}); //we use this constructor in ((BLOC & test))

  List<Object> get props => [latestPEntity];
}

class CardByIdLoaded extends HomeState {
  final CardByIdEntity cardByIdEntity; //Entities form domain
  CardByIdLoaded({required this.cardByIdEntity}); //we use this constructor in ((BLOC & test))
}

class CategoriesIsLoaded extends HomeState {
  final List<CategoriesEntity> categoriesEntity; //Entities form domain
  CategoriesIsLoaded({required this.categoriesEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetPackage extends HomeState {
  final PackageEntity packageEntity; //Entities form domain
  SuccessGetPackage({required this.packageEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetDiplomasAndPackagesFromLocaleDB extends HomeState {
  final List<DiplomasAndPackagesEntity> diplomasAndPackagesEntity; //Entities form domain
  SuccessGetDiplomasAndPackagesFromLocaleDB({required this.diplomasAndPackagesEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetConsultanciesFromLocalDB extends HomeState {
  final List<ConsultanciesFromLocalDbEntity> consultanciesFromLocalDbEntity; //Entities form domain
  SuccessGetConsultanciesFromLocalDB({required this.consultanciesFromLocalDbEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetCategoriesFromLocalDB extends HomeState {
  final List<CategoriesFromLocalDBEntity> categoriesFromLocalDBEntity; //Entities form domain
  SuccessGetCategoriesFromLocalDB({required this.categoriesFromLocalDBEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetAllProductsFromFav extends HomeState {
  final List<FavEntity> favEntity; //Entities form domain
  SuccessGetAllProductsFromFav({required this.favEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetTrainingCourses extends HomeState {
  final List<TrainingCoursesEntity> trainingCoursesEntity; //Entities form domain
  SuccessGetTrainingCourses({required this.trainingCoursesEntity}); //we use this constructor in ((BLOC & test))
}

class SuccessGetSearchItem extends HomeState {
  final List<SearchEntity> list; //Entities form domain
  SuccessGetSearchItem({required this.list}); //we use this constructor in ((BLOC & test))
}

class SuccessGetSearchProcess extends HomeState {
  final List<SearchProcessEntity> list; //Entities form domain
  SuccessGetSearchProcess({required this.list}); //we use this constructor in ((BLOC & test))
}

class SuccessUpdateDiplomasAndPackages extends HomeState {
  final int statesCode; //Entities form domain
  SuccessUpdateDiplomasAndPackages({required this.statesCode}); //we use this constructor in ((BLOC & test))
}

class SuccessDeleteProductToFavLocalDB extends HomeState {
    final int statesCode; //Entities form domain
  SuccessDeleteProductToFavLocalDB({required this.statesCode}); //we use this constructor in ((BLOC & test))

}

class SuccessDeleteSearchProcess extends HomeState {
    final int statesCode; //Entities form domain
    SuccessDeleteSearchProcess({required this.statesCode}); //we use this constructor in ((BLOC & test))
}

class SuccessGetBanners extends HomeState {
    final List<BannersEntity> banners; //Entities form domain
    SuccessGetBanners({required this.banners}); //we use this constructor in ((BLOC & test))
}

class latestIsLoaded extends HomeState {
  final List<LatestEntity> latestEntity; //Entities form domain
  latestIsLoaded({required this.latestEntity}); //we use this constructor in ((BLOC & test))
  List<Object> get props => [latestEntity];
}

class latestCIsLoaded extends HomeState {
  final List<LatestEntity> latestEntity; //Entities form domain
  latestCIsLoaded({required this.latestEntity}); //we use this constructor in ((BLOC & test))
  List<Object> get props => [latestEntity];
}

class ConsultanciesIsLoaded extends HomeState {
  final List<ConsultanciesEntity> consultanciesEntity; //Entities form domain
  ConsultanciesIsLoaded({required this.consultanciesEntity}); //we use this constructor in ((BLOC & test))
  List<Object> get props => [consultanciesEntity];
}

class SuccessCheckPurchase extends HomeState {
  final int statusCode; //Entities form domain
  SuccessCheckPurchase({required this.statusCode}); //we use this constructor in ((BLOC & test))

}
