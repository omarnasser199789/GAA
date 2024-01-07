import '../../../../../core/globals.dart';
import 'package:sqflite/sqflite.dart';
import '../../../domain/use_cases/local_db_usecase/add_product_to_fav_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/update_categories_in_local_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/update_consultancies_in_local_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/update_diplomas_and_packages_in_local_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/update_training_courses_in_local_db_usecase.dart';
import '../../models/categories_from_local_db_model.dart';
import '../../models/consultancies_from_local_db_model.dart';
import '../../models/diplomas_and_packages_model.dart';
import '../../models/fav_model.dart';
import '../../models/search_process_model.dart';
import '../../models/traning_courses_model.dart';


abstract class HomeLocalDataSource {
  Future<int> updateDiplomasAndPackages(List<UpdateDiplomasAndPackagesParams> params);
  Future<List<DiplomasAndPackagesModel>> getDiplomasAndPackages(String noParams);
  Future<int> updateConsultancies(List<UpdateConsultanciesParams> params);
  Future<List<ConsultanciesFromLocalDbModel>> getConsultanciesFromLocalDB(String noParams);
  Future<int> updateCategories(List<UpdateCategoriesParams> params);
  Future<List<CategoriesFromLocalDbModel>> getCategoriesFromLocalDB(String noParams);
  Future<int> addProductToFav(AddProductToFavParams params);
  Future<List<FavModel>> getAllProductFromFav(String noParams);
  Future<int> deleteProductFromFav(int id);
  Future<int> deleteAllSearchProcess();
  Future<int> updateTrainingCourses(List<UpdateTrainingCoursesParams> params);
  Future< List<TrainingCoursesModel>> getTrainingCourses(String noParams);
  Future<int> addSearchProcess(String text);
  Future<List<SearchProcessModel>> getAllSearchProcess();


}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {


  @override
  Future<int> updateDiplomasAndPackages(List<UpdateDiplomasAndPackagesParams> params) async {
    ///Get a reference to the database.
    final db = await database;

    ///Delete all item from table.
    await db.rawQuery("DELETE  FROM diplomasAndPackages");


    ///Insert new items
    for(var item in params){
      await db.insert(
        'diplomasAndPackages',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 200;
  }

  @override
  Future<List<DiplomasAndPackagesModel>> getDiplomasAndPackages(String noParams) async {
    ///Get a reference to the database.
    // final db = await database;
    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM diplomasAndPackages");

    ///Generate list of diplomas and packages
    List<DiplomasAndPackagesModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(DiplomasAndPackagesModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<int> updateConsultancies(List<UpdateConsultanciesParams> params) async {
    ///Get a reference to the database.
    // final db = await database;


    // ///Print the data entered into the database for the table.
    // if (kDebugMode) {
    //   print(UpdateConsultanciesParamsToJson(params));
    // }


    ///Delete all item from table.
    await db.rawQuery("DELETE  FROM consultancies");


    ///Insert new items
    for(var item in params){
      await db.insert(
        'consultancies',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 200;
  }

  @override
  Future<List<ConsultanciesFromLocalDbModel>> getConsultanciesFromLocalDB(String noParams) async {

    ///Get a reference to the database.
    // final db = await database;
    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM consultancies");

    ///Generate list of diplomas and packages
    List<ConsultanciesFromLocalDbModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(ConsultanciesFromLocalDbModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<int> updateCategories(List<UpdateCategoriesParams> params) async {
    ///Get a reference to the database.
    // final db = await database;


    // ///Print the data entered into the database for the table.
    // if (kDebugMode) {
    //   print(UpdateCategoriesParamsToJson(params));
    // }


    ///Delete all item from table.
    await db.rawQuery("DELETE  FROM categories");


    ///Insert new items
    for(var item in params){
      await db.insert(
        'categories',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 200;
  }

  @override
  Future<List<CategoriesFromLocalDbModel>> getCategoriesFromLocalDB(String noParams) async {

    ///Get a reference to the database.
    //  db = await database;
    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM categories");

    ///Generate list of diplomas and packages
    List<CategoriesFromLocalDbModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(CategoriesFromLocalDbModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<int> addProductToFav(AddProductToFavParams params) async {
    ///Get a reference to the database.
    // final db = await database;

    ///Print the data entered into the database for the table.
    // if (kDebugMode) {
    //   print("AddProductToFavParams:");
    //   print(params.toMap());
    // }
    // if (kDebugMode) {
    //   print("ADDED item where id is ${params.apiId})");
    // }
    ///Insert new items
      await db.insert(
        'favorite',
        params.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );



    return 200;
  }

  @override
  Future<List<FavModel>> getAllProductFromFav(String noParams) async{

    ///Get a reference to the database.
    //  db = await database;
    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM favorite");


    ///Generate list of diplomas and packages
    List<FavModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(FavModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<int> deleteProductFromFav(int id) async{

    // if (kDebugMode) {
    //   print("Delete item where id is $id");
    // }
    ///Delete product from table.
    await db.rawQuery("DELETE  FROM favorite WHERE apiID='$id'");
    // await db.rawQuery("DELETE  FROM favorite");
    return 200;
  }

  @override
  Future<int> updateTrainingCourses(List<UpdateTrainingCoursesParams> params) async{
    ///Print the data entered into the database for the table.
    // if (kDebugMode) {
    //   print("DataUpdateTrainingCoursesParamsToJson");
    //   print(UpdateTrainingCoursesParamsToJson(params));
    // }


    ///Delete all item from table.
    await db.rawQuery("DELETE  FROM trainingCourses");


    ///Insert new items
    for(var item in params){
      await db.insert(
        'trainingCourses',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 200;
  }

  @override
  Future<List<TrainingCoursesModel>> getTrainingCourses(String noParams) async{



    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM trainingCourses");

    ///Print the data from the database for the table.
    // if (kDebugMode) {
    //   print("DataGetTrainingCourses");
    //   print(maps);
    // }

    ///Generate list of diplomas and packages
    List<TrainingCoursesModel> list=[];

    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        bool isItemExit=false;
        for(var it in list){
          if(it.apiId==TrainingCoursesModel.fromJson(item).apiId){
            isItemExit=true;
          }
        }
        if(isItemExit==false) {
          list.add(TrainingCoursesModel.fromJson(item));
        }
      }
    }

    return list;
  }

  @override
  Future<int> addSearchProcess(String text) async{

    await db.rawQuery("DELETE  FROM searchHistory WHERE text='$text'");

    await db.insert(
      'searchHistory',
      {"text":text},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );



    return 200;
  }

  @override
  Future<List<SearchProcessModel>> getAllSearchProcess()async {

    ///Get a reference to the database.
    //  db = await database;


    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM searchHistory");

    ///Generate list of diplomas and packages
    List<SearchProcessModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(SearchProcessModel.fromJson(item));
      }
    }

    return list;
  }

  @override
  Future<int> deleteAllSearchProcess()async {

    // if (kDebugMode) {
    //   print("Delete item where id is $id");
    // }
    ///Delete product from table.
    await db.rawQuery("DELETE  FROM searchHistory");
    // await db.rawQuery("DELETE  FROM favorite");
    return 200;
  }






}
