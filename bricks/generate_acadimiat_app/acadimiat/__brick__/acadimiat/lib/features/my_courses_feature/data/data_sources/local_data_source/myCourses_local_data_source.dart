import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../../domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/files_model.dart';
import '../../models/my_courses_model.dart';

abstract class MyCoursesLocalDataSource {
  Future<int> addFile(AddFileParams params);
  Future<FilesModel> getFileByUrl(GetFileParams params);
  Future<FilesModel> getAllFiles(String noParams);
  Future<int> deleteFile(FilesModel files);
  Future<int> deleteAllFiles(FilesModel files);
  Future<int> updateMyCourses(List<MyCoursesModel> params);
  Future<List<MyCoursesModel>> getMyCoursesFromLocalDb(String noParams);
}

class MyCoursesLocalDataSourceImpl implements MyCoursesLocalDataSource {
// Define a function that inserts files into the database
  @override
  Future<int> addFile(AddFileParams params) async {
    /// Get a reference to the database.
    final db = await database;

    /// Insert the Files into the correct table. You might also specify the
    /// `conflictAlgorithm` to use in case the same dog is inserted twice.
    ///
    /// In this case, replace any previous data.
    await db.insert(
      'files',
      params.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (kDebugMode) {
      print("File Add it in DATABASE");
    }
    
    return 200;
  }

  @override
  Future<FilesModel> getFileByUrl(GetFileParams params) async {
    /// Get a reference to the database.
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM files WHERE name='${params.url}'");

    FilesModel filesModel = FilesModel(
      index: params.index,
      items: List<Item>.from(maps.map((x) => Item.fromJson(x))),
    );

    return filesModel;
  }

  @override
  Future<FilesModel> getAllFiles(String noParams) async {
    /// Get a reference to the database.
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM files");

    FilesModel filesModel = FilesModel(
      index: 0,
      items: List<Item>.from(maps.map((x) => Item.fromJson(x))),
    );

    return filesModel;
  }

  @override
  Future<int> deleteFile(FilesModel files) async {
    await deleteFileFromInternalStorage(files.items);
    /// Get a reference to the database.
    final db = await database;
    await db.rawQuery("DELETE  FROM files WHERE url='${files.items[0].url}'");
    return 200;
  }

  @override
  Future<int> deleteAllFiles(FilesModel files) async {
    await deleteFileFromInternalStorage(files.items);
    /// Get a reference to the database.
    final db = await database;
    await db.rawQuery("DELETE  FROM files"); // files WHERE url=$url
    return 200;
  }

  Future<void> deleteFileFromInternalStorage(List<Item> pathsList) async {
    for (var item in pathsList) {
      try {
        File(item.path).delete();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Future<int> updateMyCourses(List<MyCoursesModel> params) async{
    ///Get a reference to the database.
    final db = await database;

    ///Delete all item from table.
    await db.rawQuery("DELETE  FROM myCourses");


    ///Insert new items
    for(var item in params){
      await db.insert(
        'myCourses',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return 200;
  }

  @override
  Future<List<MyCoursesModel>> getMyCoursesFromLocalDb(String noParams) async {

    ///Get a reference to the database.
    final db = await database;

    ///Get items
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM myCourses");

    ///Generate list of diplomas and packages
    List<MyCoursesModel> list=[];
    ///Put item in diplomas and packages list
    if(maps.isNotEmpty) {
      for (var item in maps) {
        list.add(MyCoursesModel.fromJson(item));
      }
    }

    return list;
  }
 
}
