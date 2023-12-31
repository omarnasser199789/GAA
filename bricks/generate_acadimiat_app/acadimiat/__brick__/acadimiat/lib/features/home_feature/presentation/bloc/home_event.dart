


import '../../domain/use_cases/check_purchase_usecase.dart';
import '../../domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';

abstract class HomeEvent {}
class FetchData extends HomeEvent {}
class StopAnyEvent extends HomeEvent {}
class RestartEvent extends HomeEvent {}
class GetLatest extends HomeEvent {}
class GetLatestC extends HomeEvent {}
class GetLatestP extends HomeEvent {}
class GetConsultancies extends HomeEvent {}
class GetCategories extends HomeEvent {}
class GetCardByIdEvent extends HomeEvent {
 final int id;
 GetCardByIdEvent({required this.id});
}
class GetPackageEvent extends HomeEvent {
 final int id;
 GetPackageEvent({required this.id});
}

class UpdateDiplomasAndPackagesFromLocaleDBEvent extends HomeEvent {
 final List<UpdateDiplomasAndPackagesParams> params;
 UpdateDiplomasAndPackagesFromLocaleDBEvent({required this.params});
}
class GetDiplomasAndPackagesFromLocaleDBEvent extends HomeEvent{}

class GetConsultanciesFromLocaleDBEvent extends HomeEvent{}
class GetCategoriesFromLocaleDBEvent extends HomeEvent{}
class GetBannersEvent extends HomeEvent{}
class GetAllSearchProcessEvent extends HomeEvent{}
class DeleteAllSearchProcessEvent extends HomeEvent{
}
class GetTrainingCoursesFromLocaleDBEvent extends HomeEvent{}
class SearchEvent extends HomeEvent{
 String text;
 SearchEvent({required this.text});
}
class GetAllProductsFromFavLocalDBEvent extends HomeEvent{}
class AddProductToFavLocalDBEvent extends HomeEvent{
 AddProductToFavLocalDBEvent({
  required this.addProductToFavParams,
});
 AddProductToFavParams addProductToFavParams;
}

class DeleteProductToFavLocalDBEvent extends HomeEvent{
 DeleteProductToFavLocalDBEvent({
  required this.id,
});
 int id;
}

class UpdateCategoriesFromLocaleDBEvent extends HomeEvent{
 List<UpdateCategoriesParams> params;
 UpdateCategoriesFromLocaleDBEvent({required this.params});
}
class UpdateConsultanciesFromLocaleDBEvent extends HomeEvent{
 List<UpdateConsultanciesParams> params;
 UpdateConsultanciesFromLocaleDBEvent({required this.params});
}

class UpdateTrainingCoursesInLocaleDBEvent extends HomeEvent{
 List<UpdateTrainingCoursesParams> params;
 UpdateTrainingCoursesInLocaleDBEvent({required this.params});
}

class CheckPurchaseEvent extends HomeEvent{
 CheckPurchaseModel params;
 CheckPurchaseEvent({required this.params});
}




