import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/globals.dart';
import '../../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../../../domain/entities/Categories_from_local_db_entity.dart';
import '../../../domain/entities/banners_entity.dart';
import '../../../domain/entities/card_by_id_entity.dart';
import '../../../domain/entities/categories_entity.dart';
import '../../../domain/entities/consultancies_from_local_db_entity.dart';
import '../../../domain/entities/counsultancy_entity.dart';
import '../../../domain/entities/diplomas_and_packages_entity.dart';
import '../../../domain/entities/fav_entity.dart';
import '../../../domain/entities/latest_entity.dart';
import '../../../domain/entities/latestp_entity.dart';
import '../../../domain/entities/search_entity.dart';
import '../../../domain/entities/search_process_entity.dart';
import '../../../domain/entities/training_courses_entity.dart';
import '../home_state.dart';

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}



Stream<HomeState> eitherConsultanciesLoadedOrErrorState(
    Either<Failure, List<ConsultanciesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (consultanciesEntity) =>
        ConsultanciesIsLoaded(consultanciesEntity: consultanciesEntity),
  );
}

Stream<HomeState> eitherLatestLoadedOrErrorState(
    Either<Failure, List<LatestEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (latestEntity) => latestIsLoaded(latestEntity: latestEntity),
  );
}
Stream<HomeState> eitherLatestCLoadedOrErrorState(
    Either<Failure, List<LatestEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (latestEntity) => latestCIsLoaded(latestEntity: latestEntity),
  );
}

Stream<HomeState> eitherLatestPLoadedOrErrorState(
    Either<Failure, List<LatestPEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (latestPEntity) => latestPIsLoaded(latestPEntity: latestPEntity),
  );
}

Stream<HomeState> eitherSuccessGetCardByIdOrErrorState(
    Either<Failure, CardByIdEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (cardByIdEntity) => CardByIdLoaded(cardByIdEntity: cardByIdEntity),
  );
}

Stream<HomeState> eitherSuccessGetCategoriesOrErrorState(
    Either<Failure, List<CategoriesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (categoriesEntity) => CategoriesIsLoaded(categoriesEntity: categoriesEntity),
  );
}
Stream<HomeState> eitherSuccessGetPackageOrErrorState(
    Either<Failure, PackageEntity> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (packageEntity) => SuccessGetPackage(packageEntity: packageEntity),
  );
}

Stream<HomeState> eitherSuccessGetDiplomasAndPackagesFromLocaleDBOrErrorState(
    Either<Failure, List<DiplomasAndPackagesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (diplomasAndPackagesEntity) =>
            SuccessGetDiplomasAndPackagesFromLocaleDB(diplomasAndPackagesEntity: diplomasAndPackagesEntity),
  );
}
Stream<HomeState> eitherSuccessGetConsultanciesFromLocalDBOrErrorState(
    Either<Failure, List<ConsultanciesFromLocalDbEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (consultanciesFromLocalDbEntity) =>
            SuccessGetConsultanciesFromLocalDB(consultanciesFromLocalDbEntity: consultanciesFromLocalDbEntity),
  );
}
Stream<HomeState> eitherSuccessGetCategoriesFromLocalDBOrErrorState(
    Either<Failure,List<CategoriesFromLocalDBEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (categoriesFromLocalDBEntity) =>
            SuccessGetCategoriesFromLocalDB(categoriesFromLocalDBEntity: categoriesFromLocalDBEntity),
  );
}
Stream<HomeState> eitherSuccessDeleteProductToFavLocalDBOrErrorState(
    Either<Failure,int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statesCode) =>
            SuccessDeleteProductToFavLocalDB(statesCode: statesCode),
  );
}
Stream<HomeState> eitherSuccessGetAllProductsFromFavLocalDBOrErrorState(
    Either<Failure,List<FavEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (favEntity) =>
            SuccessGetAllProductsFromFav(favEntity: favEntity),
  );
}
Stream<HomeState> eitherSuccessGetTrainingCoursesFromLocaleDBUseCaseOrErrorState(
    Either<Failure,List<TrainingCoursesEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trainingCoursesEntity) =>
            SuccessGetTrainingCourses(trainingCoursesEntity: trainingCoursesEntity),
  );
}
Stream<HomeState> eitherSuccessGetSearchItemOrErrorState(
    Either<Failure,List<SearchEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (list) =>
            SuccessGetSearchItem(list: list),
  );
}
Stream<HomeState> eitherSuccessGetAllSearchProcessFromLocalDBUseCaseOrErrorState(
    Either<Failure,List<SearchProcessEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (list) =>
            SuccessGetSearchProcess(list: list),
  );
}

Stream<HomeState> eitherSuccessUpdateDiplomasAndPackagesOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statesCode) => SuccessUpdateDiplomasAndPackages(statesCode: statesCode),
  );
}

Stream<HomeState> eitherSuccessDeleteSearchProcessFromLocalDBUseCaseOrErrorState(
    Either<Failure, int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statesCode) => SuccessDeleteSearchProcess(statesCode: statesCode),
  );
}


Stream<HomeState> eitherSuccessGetBannersOrErrorState(
    Either<Failure,  List<BannersEntity>> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (banners) => SuccessGetBanners(banners: banners),
  );
}

Stream<HomeState> successCheckPurchaseOrErrorState(
    Either<Failure,  int> failureOrSuccess,
    ) async* {
  yield failureOrSuccess.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (statusCode) => SuccessCheckPurchase(statusCode: statusCode),
  );
}





