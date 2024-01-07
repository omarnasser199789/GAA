import 'package:acadmiat/features/home_feature/data/models/consultancies_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/check_purchase_usecase.dart';
import '../../models/banners_model.dart';
import '../../models/card_by_id_model.dart';
import '../../models/categories_model.dart';
import '../../models/latest_model.dart';
import '../../models/latestp_model.dart';
import '../../models/package_model.dart';
import '../../models/search_model.dart';
import 'home_remot_data_source_function.dart';

abstract class HomeRemoteDataSource {
  Future<List<LatestPModel>> getLatestP();
  Future<List<LatestModel>> getLatest(bool isNew);
  Future<List<ConsultanciesModel>> getConsultancies();
  Future<CardByIdModel> getCardbyId( int id);
  Future<List<CategoriesModel>> getCategories(String params);
  Future<PackageModel> getPackageById(int id);
  Future<List<SearchModel>> search(String text);
  Future< List<BannersModel>> getBanners();
  Future<int> checkPurchase(CheckPurchaseModel params);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});
  HomeRemoteDataFunctions function = HomeRemoteDataFunctions();
  @override
  Future<CardByIdModel> getCardbyId(int id) {
    return function.getCardByIdRequest('$baseUrl/v1/cardbyid/$id');
  }
  @override
  Future<List<LatestPModel>> getLatestP() async {
    return function.getLatestPRequest('$baseUrl/v1/latestp');
  }

  @override
  Future<List<LatestModel>> getLatest(bool isNew) {
    if(isNew){
      return function.getLatestRequest('$baseUrl/v1/latestc');
    }else{
      return function.getLatestRequest('$baseUrl/v1/latest');
    }
  }

  @override
  Future<List<ConsultanciesModel>> getConsultancies() {
    return function.getConsultanciesRequest('$baseUrl/v1/consultancies');
  }

  @override
  Future<List<CategoriesModel>> getCategories(String params) {
    return function.getCategories('$baseUrl/v1/categories/');
  }

  @override
  Future<PackageModel> getPackageById(int id) {
    return function.getPackageById('$baseUrl/v1/package/$id');
  }

  @override
  Future<List<SearchModel>> search(String text) {
    return function.search('$baseUrl/v1/search/$text');
  }

  @override
  Future< List<BannersModel>> getBanners() {
    return function.getBanners('$baseUrl/v2/banners');
  }

  @override
  Future<int> checkPurchase(CheckPurchaseModel params) {
    return function.checkPurchase('$baseUrl/v1/check-purchase', params);
  }
}
