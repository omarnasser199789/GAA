import 'package:flutter/foundation.dart';
// import '../storage/secure_storage_manager.dart';
import 'package:http/http.dart' as http;

import '../error/exceptions.dart';
import '../globals.dart';

class ApiManager {
  static  final Map<String, String> headers={};
  static const String cachedJWTToken = 'CACHED_JWT_TOKEN';
  static const String cachedJWTRefreshToken = 'CACHED_JWT_REFRESH_TOKEN';
  static Future<String?> getAuthToken() async {
    // SecureStorageManager secureStorageManager =  SecureStorageManager();
    // String? result = await secureStorageManager.read( key: cachedJWTToken);
    return globalSH.getString(CACHED_JWT_TOKEN)??"";
  }
  static Future<String> getRefreshToken({String? env}) async {
    // SecureStorageManager secureStorageManager =  SecureStorageManager();
    // String? result = await secureStorageManager.read( key: cachedJWTRefreshToken);
    return "";
  }
  static Future<Map<String, String>> getHeaders() async {
    final authToken = await getAuthToken();
    headers['Content-type'] = 'application/json';
    headers['Authorization'] = 'Bearer $authToken';
    headers['Accept-Language'] = 'en';
    headers['Accept'] = 'application/json';
    return headers;
  }
  static Future<http.Response> get({required String url}) async {
    late http.Response response;
    try{
      final headers = await getHeaders();
      response = await http.get(Uri.parse(url), headers: headers);
      if (kDebugMode) {print(url +" ==> StatusCode: ${response.statusCode}");}
      return response;
    } catch (e) {
      if (kDebugMode) {print(e);}
      throw ServerException();
    }
  }
  static Future<http.Response> post({required String url,Object? body}) async {
    late http.Response response;
    try{
      final headers = await getHeaders();
      response = await http.post(Uri.parse(url), headers: headers,body: body);
      if (kDebugMode) {print(url +" ==> StatusCode: ${response.statusCode}");}
      return response;
    } catch (e) {
      if (kDebugMode) {print(e);}
      throw ServerException();
    }
  }
  static Future<http.Response> patch({required String url,Object? body}) async {
    if (kDebugMode) {print(url);}
    late http.Response response;
    try{
      final headers = await getHeaders();
      response = await http.patch(Uri.parse(url), headers: headers,body: body);
      if (kDebugMode) {print(response.statusCode);}
      return response;
    } catch (e) {
      if (kDebugMode) {print(e);}
      throw ServerException();
    }
  }
  static Future<http.Response> delete({required String url}) async {
    if (kDebugMode) {print(url);}
    late http.Response response;
    try{
      final headers = await getHeaders();
      response = await http.delete(Uri.parse(url), headers: headers);
      if (kDebugMode) {print(response.statusCode);}
      return response;
    } catch (e) {
      if (kDebugMode) {print(e);}
      throw ServerException();
    }
  }

}