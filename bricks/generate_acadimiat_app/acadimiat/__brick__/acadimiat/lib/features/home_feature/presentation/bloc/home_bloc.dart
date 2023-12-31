import 'dart:async';

import 'package:acadmiat/features/home_feature/presentation/bloc/success_error/either_success_or_error.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';


import '../../domain/use_cases/check_purchase_usecase.dart';
import '../../domain/use_cases/get_banners_usecase.dart';
import '../../domain/use_cases/get_card_by_id_usecase.dart';
import '../../domain/use_cases/get_categories_usecase.dart';
import '../../domain/use_cases/get_consultancies.dart';
import '../../domain/use_cases/get_latestP_usecase.dart';
import '../../domain/use_cases/get_latest_usecase.dart';
import '../../domain/use_cases/get_package_by_id_usecase.dart';
import '../../domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/add_search_process_usecase.dart';
import '../../domain/use_cases/local_db_usecase/delete_product_from_fav_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/delete_search_process_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_all_producta_from_fav_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_all_search_process_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_categories_from_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_consultancies_from_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_diplomas_and_packages_from_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/get_training_courses_from_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import '../../domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import '../../domain/use_cases/search_usecase.dart';
import 'bloc.dart';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
bool fetchData1 = false;
bool fetchData2 = false;

class HomeBloc extends Bloc<HomeEvent, HomeState> {


  final GetLatestPUseCase getLatestPUseCase;
  final GetLatestUseCase getLatestUseCase;
  final GetConsultanciesUseCase getConsultanciesUseCase;
  final GetCardByIdUseCase getCardByIdUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetPackageByIdUseCase getPackageByIdUseCase;
  final UpdateDiplomasAndPackagesInLocaleDBUseCase updateDiplomasAndPackagesInLocaleDBUseCase;
  final GetDiplomasAndPackagesFromLocaleDBUseCase getDiplomasAndPackagesFromLocaleDBUseCase;
  final UpdateConsultanciesInLocalDBUseCase updateConsultanciesInLocalDBUseCase;
  final GetConsultanciesFromLocalDBUseCase getConsultanciesFromLocalDBUseCase;
  final UpdateCategoriesInLocalDBUseCase updateCategoriesInLocalDBUseCase;
  final GetCategoriesFromLocalDBUseCase getCategoriesFromLocalDBUseCase;
  final AddProductToFavLocalDBUseCase addProductToFavLocalDBUseCase;
  final GetAllProductFromFavLocalDBUseCase getAllProductFromFavLocalDBUseCase;
  final DeleteProductFromFavLocalDBUseCase deleteProductFromFavLocalDBUseCase;
  final UpdateTrainingCoursesInLocaleDBUseCase updateTrainingCoursesInLocaleDBUseCase;
  final GetTrainingCoursesFromLocaleDBUseCase getTrainingCoursesFromLocaleDBUseCase;
  final SearchUseCase searchUseCase;
  final AddSearchProcessToLocalDBUseCase addSearchProcessToLocalDBUseCase;
  final GetAllSearchProcessFromLocalDBUseCase getAllSearchProcessFromLocalDBUseCase;
  final DeleteAllSearchProcessFromDBUseCase deleteAllSearchProcessFromDBUseCase;
  final GetBannersUseCase getBannersUseCase;
  final CheckPurchaseUseCase checkPurchaseUseCase;


  HomeBloc({
    required GetLatestPUseCase concretegetLatestPUseCase,
    required GetLatestUseCase concretegetLatestUseCase,
    required GetConsultanciesUseCase concreteGetConsultanciesUseCase,
    required GetCardByIdUseCase concreteGetCardByIdUseCase,
    required GetCategoriesUseCase concreteGetCategoriesUseCase,
    required GetPackageByIdUseCase concreteGetPackageByIdUseCase,
    required UpdateDiplomasAndPackagesInLocaleDBUseCase concreteUpdateDiplomasAndPackagesInLocaleDBUseCase,
    required GetDiplomasAndPackagesFromLocaleDBUseCase concreteGetDiplomasAndPackagesFromLocaleDBUseCase,
    required UpdateConsultanciesInLocalDBUseCase concreteUpdateConsultanciesInLocalDBUseCase,
    required GetConsultanciesFromLocalDBUseCase concreteGetConsultanciesFromLocalDBUseCase,
    required UpdateCategoriesInLocalDBUseCase concreteUpdateCategoriesInLocalDBUseCase,
    required GetCategoriesFromLocalDBUseCase concreteGetCategoriesFromLocalDBUseCase,
    required AddProductToFavLocalDBUseCase concreteAddProductToFavLocalDBUseCase,
    required GetAllProductFromFavLocalDBUseCase concreteGetAllProductFromFavLocalDBUseCase,
    required DeleteProductFromFavLocalDBUseCase concreteDeleteProductFromFavLocalDBUseCase,
    required UpdateTrainingCoursesInLocaleDBUseCase concreteUpdateTrainingCoursesInLocaleDBUseCase,
    required GetTrainingCoursesFromLocaleDBUseCase concreteGetTrainingCoursesFromLocaleDBUseCase,
    required SearchUseCase concreteSearchUseCase,
    required AddSearchProcessToLocalDBUseCase concreteAddSearchProcessToLocalDBUseCase,
    required GetAllSearchProcessFromLocalDBUseCase concreteGetAllSearchProcessFromLocalDBUseCase,
    required DeleteAllSearchProcessFromDBUseCase concreteDeleteSearchProcessFromDBUseCase,
    required GetBannersUseCase concreteGetBannersUseCase,
    required CheckPurchaseUseCase concreteCheckPurchaseUseCase,


  })  : assert(concretegetLatestUseCase != null),
        assert(concreteGetConsultanciesUseCase != null),
        getConsultanciesUseCase = concreteGetConsultanciesUseCase,
        getLatestPUseCase = concretegetLatestPUseCase,
        getLatestUseCase = concretegetLatestUseCase,
        getCardByIdUseCase = concreteGetCardByIdUseCase,
        getCategoriesUseCase = concreteGetCategoriesUseCase,
        getPackageByIdUseCase = concreteGetPackageByIdUseCase,
        updateDiplomasAndPackagesInLocaleDBUseCase = concreteUpdateDiplomasAndPackagesInLocaleDBUseCase,
        getDiplomasAndPackagesFromLocaleDBUseCase=concreteGetDiplomasAndPackagesFromLocaleDBUseCase,
        updateConsultanciesInLocalDBUseCase=concreteUpdateConsultanciesInLocalDBUseCase,
        getConsultanciesFromLocalDBUseCase=concreteGetConsultanciesFromLocalDBUseCase,
        updateCategoriesInLocalDBUseCase=concreteUpdateCategoriesInLocalDBUseCase,
        getCategoriesFromLocalDBUseCase=concreteGetCategoriesFromLocalDBUseCase,
        addProductToFavLocalDBUseCase=concreteAddProductToFavLocalDBUseCase,
        getAllProductFromFavLocalDBUseCase=concreteGetAllProductFromFavLocalDBUseCase,
        deleteProductFromFavLocalDBUseCase=concreteDeleteProductFromFavLocalDBUseCase,
        updateTrainingCoursesInLocaleDBUseCase=concreteUpdateTrainingCoursesInLocaleDBUseCase,
        getTrainingCoursesFromLocaleDBUseCase=concreteGetTrainingCoursesFromLocaleDBUseCase,
        addSearchProcessToLocalDBUseCase=concreteAddSearchProcessToLocalDBUseCase,
        searchUseCase=concreteSearchUseCase,
        getAllSearchProcessFromLocalDBUseCase=concreteGetAllSearchProcessFromLocalDBUseCase,
        deleteAllSearchProcessFromDBUseCase=concreteDeleteSearchProcessFromDBUseCase,
        getBannersUseCase=concreteGetBannersUseCase,
        checkPurchaseUseCase=concreteCheckPurchaseUseCase,
        super(Empty());


  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetLatest) {
      final failureOrPhysician = await getLatestUseCase(false);
      yield* eitherLatestLoadedOrErrorState(failureOrPhysician);
    }
    if (event is GetLatestC) {
      final failureOrPhysician = await getLatestUseCase(true);
      yield* eitherLatestCLoadedOrErrorState(failureOrPhysician);
    }
    if (event is GetConsultancies) {
      final failureOrPhysician = await getConsultanciesUseCase("");
      yield* eitherConsultanciesLoadedOrErrorState(failureOrPhysician);
    }
    if (event is GetLatestP) {
      final failureOrPhysician = await getLatestPUseCase("");
      yield* eitherLatestPLoadedOrErrorState(failureOrPhysician);
    }
    if (event is GetCardByIdEvent) {
      final failureOrPhysician = await getCardByIdUseCase(event.id);
      yield* eitherSuccessGetCardByIdOrErrorState(failureOrPhysician);
    }
    if (event is GetCategories) {
      final failureOrPhysician = await getCategoriesUseCase("");
      yield* eitherSuccessGetCategoriesOrErrorState(failureOrPhysician);
    }
    if (event is GetPackageEvent) {
      final failureOrPhysician = await getPackageByIdUseCase(event.id);
      yield* eitherSuccessGetPackageOrErrorState(failureOrPhysician);
    }
    if(event is UpdateDiplomasAndPackagesFromLocaleDBEvent){
      // final failureOrPhysician = await
      updateDiplomasAndPackagesInLocaleDBUseCase(event.params);
      // yield* eitherSuccessUpdateDiplomasAndPackagesOrErrorState(failureOrPhysician);
    }
    if(event is GetDiplomasAndPackagesFromLocaleDBEvent){
      yield Loading();
      final failureOrPhysician = await getDiplomasAndPackagesFromLocaleDBUseCase("");
      yield* eitherSuccessGetDiplomasAndPackagesFromLocaleDBOrErrorState(failureOrPhysician);
    }
    if(event is UpdateConsultanciesFromLocaleDBEvent){
      updateConsultanciesInLocalDBUseCase(event.params);

    }
    if(event is GetConsultanciesFromLocaleDBEvent){
      yield Loading();
      final failureOrPhysician = await getConsultanciesFromLocalDBUseCase("");
      yield* eitherSuccessGetConsultanciesFromLocalDBOrErrorState(failureOrPhysician);
    }
    if(event is UpdateCategoriesFromLocaleDBEvent){
      updateCategoriesInLocalDBUseCase(event.params);
    }
    if(event is GetCategoriesFromLocaleDBEvent){
      yield Loading();
      final failureOrPhysician = await getCategoriesFromLocalDBUseCase("");
      yield* eitherSuccessGetCategoriesFromLocalDBOrErrorState(failureOrPhysician);
    }
    if(event is AddProductToFavLocalDBEvent){
      // final failureOrPhysician =await
      addProductToFavLocalDBUseCase(event.addProductToFavParams);
      // yield* eitherSuccessDeleteProductToFavLocalDBOrErrorState(failureOrPhysician);
    }
    if(event is DeleteProductToFavLocalDBEvent){
      // final failureOrPhysician =await
      deleteProductFromFavLocalDBUseCase(event.id);
      // yield* eitherSuccessDeleteProductToFavLocalDBOrErrorState(failureOrPhysician);
    }
    if(event is GetAllProductsFromFavLocalDBEvent){
      final failureOrPhysician =await getAllProductFromFavLocalDBUseCase("");
      yield* eitherSuccessGetAllProductsFromFavLocalDBOrErrorState(failureOrPhysician);
    }
    if(event is UpdateTrainingCoursesInLocaleDBEvent){
      updateTrainingCoursesInLocaleDBUseCase(event.params);
    }
    if(event is GetTrainingCoursesFromLocaleDBEvent){
      yield Loading();
      final failureOrPhysician = await getTrainingCoursesFromLocaleDBUseCase("");
      yield* eitherSuccessGetTrainingCoursesFromLocaleDBUseCaseOrErrorState(failureOrPhysician);
    }
    if(event is SearchEvent){
      yield Loading();
      ///save this search process to search history table
      ///and that because we will use all those search process for history search
      await addSearchProcessToLocalDBUseCase(event.text);
      ///Now fetch data from server
      final failureOrPhysician = await searchUseCase(event.text);
      yield* eitherSuccessGetSearchItemOrErrorState(failureOrPhysician);
    }
    if(event is GetAllSearchProcessEvent){
      yield Loading();
      final failureOrPhysician = await getAllSearchProcessFromLocalDBUseCase("");
      yield* eitherSuccessGetAllSearchProcessFromLocalDBUseCaseOrErrorState(failureOrPhysician);
    }
    if(event is DeleteAllSearchProcessEvent){
      yield Loading();
      final failureOrPhysician = await deleteAllSearchProcessFromDBUseCase(0);
      yield* eitherSuccessDeleteSearchProcessFromLocalDBUseCaseOrErrorState(failureOrPhysician);
    }
    if(event is StopAnyEvent){
      yield NoEvent();
    }
    if(event is RestartEvent){
      yield Empty();
    }

    if(event is GetBannersEvent){
      yield Loading();
      final failureOrPhysician = await getBannersUseCase("");
      yield* eitherSuccessGetBannersOrErrorState(failureOrPhysician);
    }
    if(event is CheckPurchaseEvent){
      yield Loading();
      final failureOrSuccess = await checkPurchaseUseCase(event.params);
      yield* successCheckPurchaseOrErrorState(failureOrSuccess);
    }

  }






}
