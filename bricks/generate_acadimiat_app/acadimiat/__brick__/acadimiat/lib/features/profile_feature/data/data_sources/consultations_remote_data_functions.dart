import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'dart:core';
import 'package:path/path.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/globals.dart';
import '../../../authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import '../../../my_courses_feature/data/models/files_model.dart';
import '../../../my_courses_feature/domain/use_cases/local_db_usecase/add_file_in_local_db_usecase.dart';
import '../../../my_courses_feature/domain/use_cases/local_db_usecase/get_file_by_name_usecase.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import '../../domain/use_cases/my_notes/add_new_note_usecase.dart';
import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';
import '../../domain/use_cases/register_new_account_usecase.dart';
import '../models/add_new_note_model.dart';
import '../models/my_certificates_model.dart';
import '../models/my_notes_model.dart';
import '../models/my_payments_model.dart';
import '../models/my_plans_model.dart';
import '../../../authentication_feature/data/models/update_user_mode_info.dart';
import '../models/user_info_model.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as d;
import 'package:sqflite/sqflite.dart';

class ProfileRemoteDataFunctions {
  Future<int> getResendActivationEmail(String url) async {
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> resetPassword(String url, String email) async {
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    Map<String, dynamic> data = {
      'email': email,
    };
    try {
      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(data);
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> changePassword(String url, ChangePasswordParams params) async {
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    Map<String, dynamic> data = {
      'userId': params.userId,
      'currentpassword': params.currentpassword,
      'newpassword': params.newpassword,
    };
    print(JWT);
    try {
      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(data);
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> registerNewAccount(
      String url, RegisterNewAccountParams params) async {
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    Map<String, dynamic> data = {
      'fullName': params.fullName,
      'email': params.email,
      'password': params.password,
      'phone': params.phone,
    };
    print(JWT);
    try {
      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<UserInfoModel> getUserInfo(String url) async {
    print(url);
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();

    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(response.body);
        return UserInfoModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<UpdateUserInfoModel> updateUserInfo(
      String url, UserInfoParams params) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    Map<String, dynamic> data = {
      'email': params.email,
      'id': params.userId,
      'name': params.name,
      'phone': params.phone,
      'birthdate': params.birthDate,
    };
    print(data);
    try {
      final response = await post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer ' + JWT,
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(response.body);

        return UpdateUserInfoModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  Future<List<MyPaymentsModel>> getMyPaymentsList(String url) async {
    JWT =  globalSH.getString(CACHED_JWT_TOKEN).toString();

    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var MyPaymentsModel = myPaymentsModelFromJson(response.body);
        return MyPaymentsModel;
            } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> updateMyAvatar(String url, String image) async {
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();

    print(image);
    File file = new File(image);

    var stream = new ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse(url);
    var request = new MultipartRequest("POST", uri);
    request.headers.addAll({
      'content-type': 'application/json',
      'Authorization': 'Bearer ' + JWT,
    });

    var multipartFile = new MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    try {
      final response = await request.send().timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<List<MyCertificatesModel>> getCertificatesList(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return myCertificatesModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> exportCertificateToPDF(
      String url, ExportCertificatesToPdfParams params) async {
    FilesModel filesModel =
        await getFileByUrl(GetFileParams(index: 0, url: url));

    if (filesModel.items.isEmpty) {
      if (kDebugMode) {
        print(url);
      }

      d.Dio dio = d.Dio();
      try {
        var response = await dio.post(url,
            data: exportCertificatesToPdfParamsToJson(params),
            options: d.Options(
              responseType: d.ResponseType.bytes,
              headers: {'Authorization': 'Bearer ' + JWT},
              contentType: 'application/json',
            ), onSendProgress: (int sent, int total) {
          counterNotifier.value = (sent / total * 100).toStringAsFixed(0) + "%";
        });
        // await Future.delayed(const Duration(milliseconds: 50000));
        if (response.statusCode == 200) {
          var dir = await getApplicationDocumentsDirectory();
          File file = File("${dir.path}/data.pdf");
          file.writeAsBytesSync(response.data, flush: true);

          storeInLocalDB(AddFileParams(name: '', path: file.path, url: url));

          try {
            OpenFilex.open(file.path);
          } catch (e) {
            if (kDebugMode) {
              print("ERROR");
              print(e);
            }
          }
          return 200;
        } else {
          print(response.statusCode);
          return response.statusCode!;
        }
      } catch (e) {
        print(e);
        throw ServerException();
      }
    } else {
      try {
        OpenFilex.open(filesModel.items[0].path);
      } catch (e) {
        if (kDebugMode) {
          print("ERROR");
          print(e);
        }
      }
      return 200;
    }
  }

  Future<MyNotesModel> getMyNotes(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);

        return myNotesModelFromJson(response.body);
      } else {
        print("fdfdcfdf");
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<List<MyPlansModel>> getMyPlans(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        print(response.body);
        return myPlansModelFromJson(response.body);
      } else {
        throw ServerException(
            // error: errorModelFromJson(response.body)
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  Future<void> storeInLocalDB(AddFileParams params) async {
    /// Get a reference to the database.
    final db = await database;
    await db.insert(
      'dogs',
      params.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<FilesModel> getFileByUrl(GetFileParams params) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM dogs WHERE url='${params.url}'");

    FilesModel filesModel = FilesModel(
      index: params.index,
      items: List<Item>.from(maps.map((x) => Item.fromJson(x))),
    );

    return filesModel;
  }

  Future<int> deleteNote(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await delete(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 200;
      } else {
        print("fdfdcfdf");
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> deletePlan(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();
    try {
      final response = await delete(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 200;
      } else {
        print("fdfdcfdf");
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<AddNewNoteModel> addNewNote(
      String url, AddNewNoteParams params) async {
    var client = Client();
    if (kDebugMode) {
      print(url);
      print(addNewNoteParamsToJson(params));
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      final response = await client
          .post(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ' + JWT,
            },
            body: addNewNoteParamsToJson(params),
          )
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        var model = addNewNoteModelFromJson(response.body);
        return model;
            } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<int> postMyPlan(String url, PostMyPlanParams params) async {
    var client = Client();
    if (kDebugMode) {
      print(url);
      print(postMyPlanParamsToJson(params));
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;

    try {
      final response = await client
          .post(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ' + JWT,
            },
            body: postMyPlanParamsToJson(params),
          )
          .timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        // var model = addNewNoteModelFromJson(response.body);
        return 200;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
