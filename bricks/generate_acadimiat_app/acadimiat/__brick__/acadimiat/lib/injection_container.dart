
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'core/globals.dart';
import 'package:path/path.dart';
import 'features/authentication_feature/data/data_sources/remot_data_sources/authenticate_remot_data_source.dart';
import 'features/authentication_feature/data/repositories/authenticaten_repository_impl.dart';
import 'features/authentication_feature/domain/repositories/authenticate_repository.dart';
import 'features/authentication_feature/domain/use_cases/check_password_usecase.dart';
import 'features/authentication_feature/domain/use_cases/facheck_usecase.dart';
import 'features/authentication_feature/domain/use_cases/login_usecase.dart';
import 'features/authentication_feature/domain/use_cases/register_usecase.dart';
import 'features/authentication_feature/domain/use_cases/reset_password_usecase.dart';
import 'features/authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import 'features/authentication_feature/presentation/bloc/authenticate_bloc.dart';
import 'features/cart_feature/data/data_sources/local_data_source/myCart_local_data_source.dart';
import 'features/cart_feature/data/data_sources/remot_data_sourse/cart_remot_data_source.dart';
import 'features/cart_feature/data/repositories/mycart_repository_impl.dart';
import 'features/cart_feature/domain/repositories/cart_repository.dart';
import 'features/cart_feature/domain/use_cases/add_product_in_local_db_usecase.dart';
import 'features/cart_feature/domain/use_cases/apply_coupon_to_cart_usecase.dart';
import 'features/cart_feature/domain/use_cases/check_if_product_is_exit_in_db_usecase.dart';
import 'features/cart_feature/domain/use_cases/delete _product_from_locale_db_usecase.dart';
import 'features/cart_feature/domain/use_cases/delete_all_products_from_cart_usecase.dart';
import 'features/cart_feature/domain/use_cases/enable_courses_usecase.dart';
import 'features/cart_feature/domain/use_cases/get_all_products_from_local_db_usecase.dart';
import 'features/cart_feature/domain/use_cases/payment_usecase.dart';
import 'features/cart_feature/presentation/bloc/my_cart_bloc.dart';
import 'features/consultancies_feature/data/data_sources/currencies_remot_data_source.dart';
import 'features/consultancies_feature/data/repositories/currencies_repository_impl.dart';
import 'features/consultancies_feature/domain/repositories/currencies_repository.dart';
import 'features/consultancies_feature/domain/use_cases/buy_section/get_consultancy_usecase.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/get_consultation_sessions_usecase.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/get_my_consultations.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/get_room_calendar_usecase.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/get_room_hours_usecase.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/get_room_timezone_usecase.dart';
import 'features/consultancies_feature/domain/use_cases/present_section/reserve_meeting_usecase.dart';
import 'features/consultancies_feature/presentation/bloc/consultancies_bloc.dart';
import 'features/home_feature/data/data_sources/local_data_sourse/home_local_data_source.dart';
import 'features/home_feature/data/data_sources/remot_data_sourse/home_remot_data_source.dart';
import 'features/home_feature/data/repositories/latestP_repository_impl.dart';
import 'features/home_feature/domain/repositories/latestP_repository.dart';
import 'features/home_feature/domain/use_cases/check_purchase_usecase.dart';
import 'features/home_feature/domain/use_cases/get_banners_usecase.dart';
import 'features/home_feature/domain/use_cases/get_card_by_id_usecase.dart';
import 'features/home_feature/domain/use_cases/get_categories_usecase.dart';
import 'features/home_feature/domain/use_cases/get_consultancies.dart';
import 'features/home_feature/domain/use_cases/get_latestP_usecase.dart';
import 'features/home_feature/domain/use_cases/get_latest_usecase.dart';
import 'features/home_feature/domain/use_cases/get_package_by_id_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/add_search_process_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/delete_product_from_fav_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/delete_search_process_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_all_producta_from_fav_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_all_search_process_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_categories_from_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_consultancies_from_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_diplomas_and_packages_from_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/get_training_courses_from_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import 'features/home_feature/domain/use_cases/search_usecase.dart';
import 'features/home_feature/presentation/bloc/home_bloc.dart';
import 'features/my_courses_feature/data/data_sources/local_data_source/myCourses_local_data_source.dart';
import 'features/my_courses_feature/data/data_sources/remot_data_sourse/myCourses_remot_data_source.dart';
import 'features/my_courses_feature/data/repositories/consultatios_repository_impl.dart';
import 'features/my_courses_feature/domain/repositories/consultations_repository.dart';
import 'features/my_courses_feature/domain/use_cases/Assignment/post_new_assignment_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/delete_all_files_from_db_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/delete_file_from_db_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/activity_case_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/activity_filling_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/activity_logical_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/activity_match_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/activity_quizz_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/add_bookmark_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/add_comment_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/case_study/activity_decision_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/case_study/attendcase_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/case_study/course_case_study_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/delete_bookmark_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/Assignment/get_assignment.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/get_all_files_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_discussion_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_my_course/get_my_course_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_my_courses_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_my_lecture/get_my_lecture_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myqizizz_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/get_my_qizizz/get_myquizzinfo_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/get_my_courses_from_db_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/local_db_usecase/update_mycourses_in_local_db_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/post_concept_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/sign_cookie_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/submit_quiz_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/topic_reply_usecase.dart';
import 'features/my_courses_feature/domain/use_cases/wiki/article_details_usecase.dart';
import 'features/my_courses_feature/presentation/bloc/my_courses_bloc.dart';
import 'features/profile_feature/data/data_sources/consultations_remot_data_source.dart';
import 'features/profile_feature/data/repositories/consultatios_repository_impl.dart';
import 'features/profile_feature/domain/repositories/profile_repository.dart';
import 'features/profile_feature/domain/use_cases/change_password_usecase.dart';
import 'features/profile_feature/domain/use_cases/get_my_payments_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_certificate_folder/get_my_certificates_usecase.dart';
import 'features/profile_feature/domain/use_cases/get_user_info_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_notes/add_new_note_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_notes/delete_note_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_notes/get_my_notes_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_plans/delete_plan_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_plans/get_my_plans_usecase.dart';
import 'features/profile_feature/domain/use_cases/my_plans/post_my_plan_usecase.dart';
import 'features/profile_feature/domain/use_cases/update_my_avatar_usecase.dart';
import 'features/profile_feature/presentation/bloc/profile_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc


  sl.registerFactory(
    () => AuthenticateBloc(
      concreteLoginUseCase: sl(),
      concreteCheckPasswordUseCase: sl(),
      concreteUpdateUserInfoUseCase: sl(),
      concreteRegisterUseCase: sl(),
      concreteResetPasswordUseCase: sl(),
      concreteFacheckUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => HomeBloc(
      concretegetLatestPUseCase: sl(),
      concretegetLatestUseCase: sl(),
      concreteGetConsultanciesUseCase: sl(),
      concreteGetCardByIdUseCase: sl(),
      concreteGetCategoriesUseCase: sl(),
      concreteGetPackageByIdUseCase: sl(),
      concreteUpdateDiplomasAndPackagesInLocaleDBUseCase: sl(),
      concreteGetDiplomasAndPackagesFromLocaleDBUseCase: sl(),
      concreteUpdateConsultanciesInLocalDBUseCase: sl(),
      concreteGetConsultanciesFromLocalDBUseCase: sl(),
      concreteUpdateCategoriesInLocalDBUseCase: sl(),
      concreteGetCategoriesFromLocalDBUseCase:sl(),
      concreteAddProductToFavLocalDBUseCase: sl(),
      concreteGetAllProductFromFavLocalDBUseCase: sl(),
      concreteDeleteProductFromFavLocalDBUseCase:sl(),
      concreteUpdateTrainingCoursesInLocaleDBUseCase: sl(),
      concreteGetTrainingCoursesFromLocaleDBUseCase:  sl(),
      concreteSearchUseCase: sl(),
      concreteAddSearchProcessToLocalDBUseCase: sl(),
      concreteGetAllSearchProcessFromLocalDBUseCase: sl(),
      concreteDeleteSearchProcessFromDBUseCase: sl(),
      concreteGetBannersUseCase: sl(),
      concreteCheckPurchaseUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => MyCartBloc(
      concreteAddProductInLocalDBUseCase: sl(),
      concreteGetAllProductsFromLocalDBUseCase: sl(),
      concreteDeleteProductFromLocalDBUseCase: sl(),
      concreteApplyCouponToCartUseCase: sl(),
      concreteCheckIfProductIsExitInDBUseCase: sl(),
      concreteDeleteAllProductFromLocalDBUseCasee:  sl(),
      concretePaymentUseCase: sl(),
      concreteEnableCoursesUseCase:  sl(),
    ),
  );

  sl.registerFactory(
    () => MyCoursesBloc(
      concreteGetMyCoursesUseCase: sl(),
      concreteGetMyCourseUseCase: sl(),
      concreteSignCookieUseCase: sl(),
      concreteMyLectureUseCase: sl(),
      concreteGetDiscussionUseCase: sl(),
      concreteAddBookmarkUseCase: sl(),
      concreteDeleteBookmarkUseCase: sl(),
      concreteAddCommentUseCase: sl(),
      concreteGetMyQuizizzUseCase: sl(),
      concreteSubmitQuizUseCase: sl(),
      concreteGetMyQuizizzInfoUseCase: sl(),
      concreteGetAssignmentUseCase: sl(),
      concretePostNewAssignmentUseCase: sl(),
      concretePostConceptUseCase: sl(),
      concreteAddFileInLocalDBUseCase: sl(),
      concreteGetFileByUrlUseCase: sl(),
      concreteTopicReplyUseCase: sl(),
      concreteCourseCaseStudyUseCase: sl(),
      concreteArticleDetailsUseCase: sl(),
      concreteActivityFillingUseCase: sl(),
      concreteActivityMatchingUseCase: sl(),
      concreteActivityLogicalUseCase: sl(),
      concreteActivityCaseUseCase: sl(),
      concreteActivityQuizzUseCase: sl(),
      concreteAttendCaseUseCase: sl(),
      concreteActivityDecisionUseCase: sl(),
      concreteGetAllFilesUseCase: sl(),
      concreteDeleteFileFromLocalDBUseCase: sl(),
      concreteDeleteAllFilesFromLocalDBUseCase: sl(),
      concreteUpdateMyCoursesInLocalDBUseCase: sl(),
      concreteGetMyCoursesFromLocaleDBUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ProfileBloc(
      concreteGetMyCertificatesUseCase: sl(),
      concreteExportCertificateToPDFUseCase: sl(),
      concreteGetMyNotesUseCase: sl(),
      concreteDeleteNoteUseCase: sl(),
      concreteAddNewNoteUseCase: sl(),
      concreteGetMyPlansUseCase: sl(),
      concreteDeletePlanUseCase: sl(),
      concretePostMyPlanUseCase: sl(),
      concreteGetUserInfoUseCase: sl(),
      concreteChangePasswordUseCase: sl(),
      concreteUpdateMyAvatarUseCase: sl(),
      concreteGetMyPaymentsUseCase: sl(),
      concreteUpdateUserInfoUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ConsultanciesBloc(
      concreteGetMyConsultanciesUseCase: sl(),
      concreteGetConsultancyUseCase: sl(),
      concreteGetConsultationSessionsUseCase: sl(),
      concreteGetRoomCalendarUseCase: sl(),
      concreteGetRoomHoursUseCase: sl(),
      concreteGetRoomTimezoneUseCase: sl(),
      concreteReserveMeetingUseCase: sl(),
    ),
  );

  ///Use cases

  sl.registerLazySingleton(() => FacheckUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckPurchaseUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetBannersUseCase(repository: sl()));

  sl.registerLazySingleton(() => ReserveMeetingUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRoomTimezoneUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRoomHoursUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRoomCalendarUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConsultationSessionsUseCase(repository: sl()));
  sl.registerLazySingleton(() => EnableCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAllSearchProcessFromDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllSearchProcessFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddSearchProcessToLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => PaymentUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAllProductFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTrainingCoursesFromLocaleDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTrainingCoursesInLocaleDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProductFromFavLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllProductFromFavLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddProductToFavLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyCoursesFromLocaleDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMyCoursesInLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoriesFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateCategoriesInLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConsultanciesFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateConsultanciesInLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDiplomasAndPackagesFromLocaleDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateDiplomasAndPackagesInLocaleDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckIfProductIsExitInDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => ApplyCouponToCartUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProductFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllProductsFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddProductInLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetPackageByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConsultancyUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyPaymentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMyAvatarUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostMyPlanUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePlanUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyPlansUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddNewNoteUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyNotesUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAllFilesFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteFileFromLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllFilesUseCase(repository: sl()));
  sl.registerLazySingleton(() => ExportCertificateToPDFUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyCertificatesUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityDecisionUseCase(repository: sl()));
  sl.registerLazySingleton(() => AttendCaseUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityQuizzUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityCaseUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityLogicalUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityMatchingUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivityFillingUseCase(repository: sl()));
  sl.registerLazySingleton(() => ArticleDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CourseCaseStudyUseCase(repository: sl()));
  sl.registerLazySingleton(() => TopicReplyUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetFileByUrlUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddFileInLocalDBUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostConceptUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostNewAssignmentUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAssignmentUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyQuizizzInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SubmitQuizUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCardByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConsultanciesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLatestPUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLatestUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookmarkUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddBookmarkUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyQuizizzUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetDiscussionUseCase(repository: sl()));
  sl.registerLazySingleton(() => MyLectureUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignCookieUseCase(repository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyCourseUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyConsultanciesUseCase(repository: sl()));
  // sl.registerLazySingleton(() => ChangePasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyCoursesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchUseCase(repository: sl()));

  ///Repository

  sl.registerLazySingleton<MyCartRepository>(
    () => MyCartRepositoryImpl(
      myCartLocalDataSource: sl(),
      myCartRemoteDataSource: sl(),
    ),
  );


  sl.registerLazySingleton<AuthenticateRepository>(
    () => AuthenticateRepositoryImpl(authenticateRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(profileRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<MyCoursesRepository>(
    () => MyCoursesRepositoryImpl(
      myCoursesRemoteDataSource: sl(),
      myCoursesLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<MyConsultanciesRepository>(
    () => MyConsultanciesRepositoryImpl(
      myConsultanciesRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDataSource: sl(),
      homeLocalDataSource: sl(),
    ),
  );

  ///Core



  ///Data sources


  sl.registerLazySingleton<MyCartRemoteDataSource>(
    () => MyCartRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<MyCartLocalDataSource>(
    () => MyCartLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<MyCoursesLocalDataSource>(
    () => MyCoursesLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<AuthenticateRemoteDataSource>(
    () => AuthenticateRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<MyCoursesRemoteDataSource>(
    () => MyCoursesRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<MyConsultanciesRemoteDataSource>(
    () => MyConsultanciesRemoteDataSourceImpl(
      client: sl(),
    ),
  );


  /// External
  database = openDatabase(
    /**
     * ? Set the path to the database. Note: Using the `join` function from the
     * ? `path` package is best practice to ensure the path is correctly
     * ? constructed for each platform.
     */
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      /// Run the CREATE TABLE statement on the database.
      db.execute(
        'CREATE TABLE files(id INTEGER PRIMARY KEY, name TEXT, path TEXT ,url TEXT)',
      );

      ///Create diplomas and packages table,
      ///this table to catch data without internet or if api delayed in responding
      db.execute(
        'CREATE TABLE diplomasAndPackages (id INTEGER PRIMARY KEY,apiId INTEGER unique, image TEXT, courseName TEXT, trainerName TEXT ,newPrice DOUBLE ,oldPrice DOUBLE,fav BOOLEAN,isCourse BOOLEAN,numberOfCourses INTEGER)',//numberOfCourses
      );

      db.execute(
        'CREATE TABLE trainingCourses (id INTEGER PRIMARY KEY,apiId INTEGER unique, image TEXT, courseName TEXT, trainerName TEXT ,newPrice DOUBLE ,oldPrice DOUBLE,fav BOOLEAN)',//numberOfCourses
      );

      ///Create consultancies table.
      db.execute(
        'CREATE TABLE consultancies (id INTEGER PRIMARY KEY,apiId INTEGER unique, image TEXT, trainerName TEXT,name TEXT)',
      );

      ///Create categories table.
      db.execute(
        'CREATE TABLE categories (id INTEGER PRIMARY KEY,categoryId INTEGER unique, image TEXT, name TEXT,numberOfCourses int)',
      );

      ///Create myCourses table.
      db.execute(
        'CREATE TABLE myCourses (id INTEGER ,header TEXT, authorized BOOL, image TEXT,courseLink TEXT, trainer TEXT, percent INTEGER,total DOUBLE ,isCourse BOOL , hasBeforeQuizz BOOL)',
      );

      ///Create favorite table.
      db.execute(
        'CREATE TABLE favorite(id INTEGER PRIMARY KEY,apiID INTEGER unique,productType INTEGER , name TEXT,image TEXT, trainer TEXT ,newPrice DOUBLE ,oldPrice DOUBLE, fav BOOLEAN)',
      );

      ///Create search history table.
      db.execute(
        'CREATE TABLE searchHistory(id INTEGER PRIMARY KEY,text TEXT)',
      );

      ///Create cart table
      return db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY,apiID INTEGER unique,productType INTEGER , name TEXT,image TEXT, trainer TEXT ,newPrice DOUBLE ,oldPrice DOUBLE, fav BOOLEAN)',
      );

    },
    /**
     * ? Set the version. This executes the onCreate function and provides a
     * ? path to perform database upgrades and downgrades.
     */
    version: 3,
  );
  globalSH = await SharedPreferences.getInstance();
  db = await database;

  sl.registerLazySingleton(() => globalSH);
  sl.registerLazySingleton(() => database);
  sl.registerLazySingleton(() => db);
  sl.registerLazySingleton(() => http.Client());


  /**
   * ! Deprecated
   * ? Should
   * TODO:
   */
}
