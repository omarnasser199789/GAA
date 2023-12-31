import 'package:acadmiat/features/home_feature/domain/entities/Categories_from_local_db_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/categories_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/consultancies_from_local_db_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/counsultancy_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/diplomas_and_packages_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/search_entity.dart';
import 'package:acadmiat/features/home_feature/domain/entities/training_courses_entity.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/check_purchase_usecase.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import 'package:acadmiat/features/home_feature/domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../../domain/entities/banners_entity.dart';
import '../../domain/entities/card_by_id_entity.dart';
import '../../domain/entities/fav_entity.dart';
import '../../domain/entities/latest_entity.dart';
import '../../domain/entities/latestp_entity.dart';
import '../../domain/entities/search_process_entity.dart';
import '../../domain/repositories/latestP_repository.dart';
import '../data_sources/local_data_sourse/home_local_data_source.dart';
import '../data_sources/remot_data_sourse/home_remot_data_source.dart';

typedef Future<List<LatestPEntity>> _LatestPInfoChooser();
typedef Future<List<LatestEntity>> _LatestInfoChooser();
typedef Future<List<ConsultanciesEntity>> _ConsultanciesInfoChooser();
typedef Future<CardByIdEntity> _CardByIdInfoChooser();
typedef Future<int> _StatusCodeInfoChooser();
typedef Future<List<SearchProcessEntity>> _SearchProcessEntityInfoChooser();
typedef Future<List<TrainingCoursesEntity>> _TrainingCoursesEntity();
typedef Future<List<FavEntity>> _FavEntityChooser();
typedef Future<List<CategoriesFromLocalDBEntity>> _CategoriesFromLocalDBEntity();
typedef Future<List<ConsultanciesFromLocalDbEntity>> _ConsultanciesFromLocalDbEntity();
typedef Future< List<SearchEntity>> _SearchEntity();
typedef Future<List<BannersEntity>> _ToBannerEntity();
typedef Future<List<DiplomasAndPackagesEntity>> _DiplomasAndPackagesEntityInfoChooser();
typedef Future<List<CategoriesEntity>> _CategoriesEntityInfoChooser();
typedef Future<PackageEntity> _PackageEntityInfoChooser();

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, CardByIdEntity>> getCardById(int id) async {
    return await _getCardById(() {
      return homeRemoteDataSource.getCardbyId(id);
    });
  }

  @override
  Future<Either<Failure, List<LatestPEntity>>> getLatestP() async {
    return await _getLatestP(() {
      return homeRemoteDataSource.getLatestP();
    });
  }

  @override
  Future<Either<Failure, List<LatestEntity>>> getLatest(bool isNew) async {
    return await _getLatest(() {
      return homeRemoteDataSource.getLatest(isNew);
    });
  }

  @override
  Future<Either<Failure, List<ConsultanciesEntity>>> getConsultancies() async {
    return await _getConultancies(() {
      return homeRemoteDataSource.getConsultancies();
    });
  }

  @override
  Future<Either<Failure, List<CategoriesEntity>>> getCategories(String params) async {
    return await _getCategories(() {
      return homeRemoteDataSource.getCategories("");
    });
  }
  @override
  Future<Either<Failure, PackageEntity>> getPackageById(int id) async {
    return await _getPackageById(() {
      return homeRemoteDataSource.getPackageById(id);
    });
  }


  ///local DB

  @override
  Future<Either<Failure, int>> updateDiplomasAndPackages(List<UpdateDiplomasAndPackagesParams> params) async{
    return await _StatusCode(() {
      return homeLocalDataSource.updateDiplomasAndPackages(params);
    });
  }

  @override
  Future<Either<Failure, List<DiplomasAndPackagesEntity>>> getDiplomasAndPackages(String noParams)async {
    return await _getDiplomasAndPackages(() {
      return homeLocalDataSource.getDiplomasAndPackages(noParams);
    });
  }
  @override
  Future<Either<Failure, int>> updateConsultancies(List<UpdateConsultanciesParams> params)async {
    return await _StatusCode(() {
      return homeLocalDataSource.updateConsultancies(params);
    });
  }
  @override
  Future<Either<Failure, List<ConsultanciesFromLocalDbEntity>>> getConsultanciesFromLocalDB(String noParams)async {
    return await _getConsultanciesFromLocalDB(() {
      return homeLocalDataSource.getConsultanciesFromLocalDB(noParams);
    });
  }

  @override
  Future<Either<Failure, int>> updateCategories(List<UpdateCategoriesParams> params) async{
    return await _StatusCode(() {
      return homeLocalDataSource.updateCategories(params);
    });
  }


  @override
  Future<Either<Failure, List<CategoriesFromLocalDBEntity>>> getCategoriesFromLocalDB(String noParams) async{
    return await _categoriesFromLocalDBEntity(() {
      return homeLocalDataSource.getCategoriesFromLocalDB(noParams);
    });
  }

  @override
  Future<Either<Failure, int>> addProductToFav(AddProductToFavParams params) async{
    print("step2");
    return await _StatusCode(() {
      return homeLocalDataSource.addProductToFav(params);
    });
  }

  @override
  Future<Either<Failure, List<FavEntity>>> getAllProductFromFav(String params)async {
    return await _FavEntity(() {
      return homeLocalDataSource.getAllProductFromFav(params);
    });
  }

  @override
  Future<Either<Failure, int>> deleteProductFromFav(int id) async{
    return await _StatusCode(() {
      return homeLocalDataSource.deleteProductFromFav(id);
    });
  }



  @override
  Future<Either<Failure, int>> deleteAllSearchProcess() async{
    return await _StatusCode(() {
      return homeLocalDataSource.deleteAllSearchProcess();
    });
  }


  @override
  Future<Either<Failure, int>> updateTrainingCourses(List<UpdateTrainingCoursesParams> params) async{
    return await _StatusCode(() {
      return homeLocalDataSource.updateTrainingCourses(params);
    });
  }


  @override
  Future<Either<Failure, List<TrainingCoursesEntity>>> getTrainingCourses(String noParams)async {
    return await _getTrainingCourses(() {
      return homeLocalDataSource.getTrainingCourses(noParams);
    });
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> search(String text)async {
    return await _searchEntity(() {
      return homeRemoteDataSource.search(text);
    });
  }

  @override
  Future<Either<Failure, int>> addSearchProcess(String text)async {
    return await _StatusCode(() {
      return homeLocalDataSource.addSearchProcess(text);
    });
  }

  @override
  Future<Either<Failure, List<SearchProcessEntity>>> getAllSearchProcess() async{
    return await _SearchProcessEntity(() {
      return homeLocalDataSource.getAllSearchProcess();
    });
  }
  @override
  Future<Either<Failure, List<BannersEntity>>> getBanners() async {
    return await _toBannerEntity(() {
      return homeRemoteDataSource.getBanners();
    });
  }

  @override
  Future<Either<Failure, int>> checkPurchase(CheckPurchaseModel params) async{
    return await _StatusCode(() {
      return homeRemoteDataSource.checkPurchase(params);
    });
  }



  Future<Either<Failure, List<SearchProcessEntity>>> _SearchProcessEntity(
      _SearchProcessEntityInfoChooser _searchProcessEntityInfoChooser,
      ) async {
    try {
      final remotePhysician = await _searchProcessEntityInfoChooser();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<SearchEntity>>> _searchEntity(
      _SearchEntity _searchEntity,
  ) async {
    try {
      final remotePhysician = await _searchEntity();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, List<BannersEntity>>> _toBannerEntity(
      _ToBannerEntity _toBannerEntity,
  ) async {
    try {
      final remotePhysician = await _toBannerEntity();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, List<ConsultanciesFromLocalDbEntity>>> _getConsultanciesFromLocalDB(
      _ConsultanciesFromLocalDbEntity _consultanciesFromLocalDbEntity,
  ) async {
    try {
      final remotePhysician = await _consultanciesFromLocalDbEntity();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, int>> _StatusCode(
      _StatusCodeInfoChooser _statusCodeInfoChooser,
  ) async {
    try {
      final remotePhysician = await _statusCodeInfoChooser();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, List<TrainingCoursesEntity>>> _getTrainingCourses(
      _TrainingCoursesEntity _trainingCoursesEntity,
  ) async {
    try {
      final remotePhysician = await _trainingCoursesEntity();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, List<FavEntity>>> _FavEntity(
      _FavEntityChooser _favEntityChooser,
  ) async {
    try {
      final remotePhysician = await _favEntityChooser();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure,  List<CategoriesFromLocalDBEntity>>> _categoriesFromLocalDBEntity(
      _CategoriesFromLocalDBEntity _categoriesFromLocalDBEntity,
  ) async {
    try {
      final remotePhysician = await _categoriesFromLocalDBEntity();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, List<DiplomasAndPackagesEntity>>> _getDiplomasAndPackages(
      _DiplomasAndPackagesEntityInfoChooser _diplomasAndPackagesEntityInfoChooser,
  ) async {
    try {
      final remotePhysician = await _diplomasAndPackagesEntityInfoChooser();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, CardByIdEntity>> _getCardById(
    _CardByIdInfoChooser _cardByIdInfoChooser,
  ) async {
    try {
      final remotePhysician = await _cardByIdInfoChooser();

      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<ConsultanciesEntity>>> _getConultancies(
    _ConsultanciesInfoChooser _consultanciesInfoChooser,
  ) async {
    final remotePhysician = await _consultanciesInfoChooser();

    return Right(remotePhysician);
  }

  Future<Either<Failure, List<CategoriesEntity>>> _getCategories(
    _CategoriesEntityInfoChooser _categoriesEntityInfoChooser,
  ) async {
    final remotePhysician = await _categoriesEntityInfoChooser();

    return Right(remotePhysician);
  }
  Future<Either<Failure,PackageEntity>> _getPackageById(
      _PackageEntityInfoChooser _packageEntityInfoChooser,
  ) async {
    final remotePhysician = await _packageEntityInfoChooser();

    return Right(remotePhysician);
  }

  Future<Either<Failure, List<LatestEntity>>> _getLatest(
    _LatestInfoChooser _latestInfoChooser,
  ) async {
    final remotePhysician = await _latestInfoChooser();

    return Right(remotePhysician);
  }

  Future<Either<Failure, List<LatestPEntity>>> _getLatestP(
      _LatestPInfoChooser _latestPInfoChooser,
  ) async {
    final remotePhysician = await _latestPInfoChooser();

    return Right(remotePhysician);
  }





























}
