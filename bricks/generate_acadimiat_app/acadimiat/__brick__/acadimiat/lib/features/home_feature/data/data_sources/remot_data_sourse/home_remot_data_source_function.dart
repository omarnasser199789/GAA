import 'dart:convert';

import 'package:acadmiat/features/home_feature/data/models/consultancies_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/globals.dart';
import '../../../../../core/network/api_manager.dart';
import '../../../../consultancies_feature/data/models/consultancies_model.dart';
import '../../../domain/use_cases/check_purchase_usecase.dart';
import '../../models/banners_model.dart';
import '../../models/card_by_id_model.dart';
import '../../models/categories_model.dart';
import '../../models/latest_model.dart';
import '../../models/latestp_model.dart';
import '../../models/package_model.dart';
import '../../models/search_model.dart';

class HomeRemoteDataFunctions {
  Future<List<ConsultanciesModel>> getConsultanciesRequest(String url) async {
    try {
      final response = await get(
        Uri.parse(url),
        headers: {},
      ).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var LatestModels = consultanciesModelFromJson(response.body);
        if (LatestModels != null) {
          return LatestModels;
        } else {
          throw ServerException();
        }

        // return LatestPModel.fromJson(data);
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

  Future<List<CategoriesModel>> getCategories(String url) async {
    Response response = await ApiManager.get(url:url);
    if (response.statusCode == 200) {
      return categoriesModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }

  Future<PackageModel> getPackageById(String url) async {
    try {
      final response = await get(
        Uri.parse(url),
        headers: {},
      ).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var v = packageModelFromJson(response.body);

          return v;

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

  Future<List<SearchModel>> search(String url) async {
    print(url);
    try {
      final response = await get(
        Uri.parse(url),
        headers: {},
      ).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var v = searchModelFromJson(response.body);

          return v;

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

  Future< List<BannersModel>> getBanners(String url) async {
    Response response = await ApiManager.get(url:url);
    if (response.statusCode == 200) {
      return bannersModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }

  Future<List<LatestModel>> getLatestRequest(String url) async {
    Response response = await ApiManager.get(url:url);
    if (response.statusCode == 200) {
      return latestModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }

  Future<CardByIdModel> getCardByIdRequest(String url) async {
    Response response = await ApiManager.get(url:url);
    if (response.statusCode == 200) {
      return cardByIdModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }

  Future<List<LatestPModel>> getLatestPRequest(String url) async {
    try {
      final response = await get(
        Uri.parse(url),
        headers: {},
      ).timeout(Duration(seconds: timeout));
      // if (kDebugMode) {
      //   print(response.body);
      // }
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(milliseconds: 9000));
        var LatestPModels = latestpModelFromJson(response.body);
        if (LatestPModels != null) {
          return LatestPModels;
        } else {
          throw ServerException();
        }

        // return LatestPModel.fromJson(data);
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


  Future<int> checkPurchase(String url, CheckPurchaseModel params) async {
    try {
      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: checkPurchaseModelToJson(params),
      ).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        return response.statusCode;
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

}
