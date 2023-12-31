import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../consultancies_feature/domain/entities/consultancies_entity.dart';
import '../entities/Categories_from_local_db_entity.dart';
import '../entities/banners_entity.dart';
import '../entities/card_by_id_entity.dart';
import '../entities/categories_entity.dart';
import '../entities/consultancies_from_local_db_entity.dart';
import '../entities/counsultancy_entity.dart';
import '../entities/diplomas_and_packages_entity.dart';
import '../entities/fav_entity.dart';
import '../entities/latest_entity.dart';
import '../entities/latestp_entity.dart';
import '../entities/search_entity.dart';
import '../entities/search_process_entity.dart';
import '../entities/training_courses_entity.dart';
import '../use_cases/check_purchase_usecase.dart';
import '../use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import '../use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import '../use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import '../use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';


abstract class HomeRepository{

  Future<Either<Failure,List<LatestPEntity>>> getLatestP();
  Future<Either<Failure,List<LatestEntity>>> getLatest(bool isNew);
  Future<Either<Failure,List<ConsultanciesEntity>>> getConsultancies();
  Future<Either<Failure,CardByIdEntity>> getCardById(int id);
  Future<Either<Failure,List<CategoriesEntity>>> getCategories(String params);
  Future<Either<Failure,PackageEntity>> getPackageById(int id);
  Future<Either<Failure,List<SearchEntity>>> search(String text);
  Future<Either<Failure,List<BannersEntity>>> getBanners();
  Future<Either<Failure,int>> checkPurchase(CheckPurchaseModel params);
  ///Local DB
  Future<Either<Failure,int>> updateDiplomasAndPackages(List<UpdateDiplomasAndPackagesParams> params);
  Future<Either<Failure,List<DiplomasAndPackagesEntity>>> getDiplomasAndPackages(String noParams);
  Future<Either<Failure,int>> updateConsultancies( List<UpdateConsultanciesParams> params);
  Future<Either<Failure,List<ConsultanciesFromLocalDbEntity>>> getConsultanciesFromLocalDB( String noParams);
  Future<Either<Failure,int>> updateCategories( List<UpdateCategoriesParams> params);
  Future<Either<Failure,List<CategoriesFromLocalDBEntity>>> getCategoriesFromLocalDB(String noParams);
  Future<Either<Failure,int>> addProductToFav(AddProductToFavParams params);
  Future<Either<Failure,List<FavEntity>>> getAllProductFromFav(String params);
  Future<Either<Failure,int>> deleteProductFromFav(int id);
  Future<Either<Failure,int>> deleteAllSearchProcess();
  Future<Either<Failure,int>> updateTrainingCourses(List<UpdateTrainingCoursesParams> params);
  Future<Either<Failure,List<TrainingCoursesEntity>>> getTrainingCourses(String noParams);
  Future<Either<Failure,int>> addSearchProcess(String text);
  Future<Either<Failure,List<SearchProcessEntity>>> getAllSearchProcess();


}