import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/globals.dart';
import '../../domain/use_cases/present_section/get_room_hours_usecase.dart';
import '../../domain/use_cases/present_section/reserve_meeting_usecase.dart';
import '../models/consultancies_model.dart';
import '../models/consultancy_model.dart';
import '../models/consultationSessionsModel.dart';
import '../models/reserve_meeting_model.dart';
import '../models/room_calender_model.dart';
import '../models/room_hour_model.dart';


class MyConsultanciesRemoteDataFunctions {



  Future<List<MyConsultanciesModel>> getMyConsultancies(
    String url
  ) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
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
        var model = myConsultanciesModelFromJson(response.body);
          return model;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }



  Future<ConsultancyModel> getConsultancy(String url) async {
    if (kDebugMode) {
      print(url);
    }
    // JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        var models = consultancyModelFromJson(response.body);

          return models;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<List<ConsultationsSessionsModel>> getConsultationSession(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      if (kDebugMode) {
        print("response.body:${response.body}");
      }
      if (response.statusCode == 200) {
        var models = consultationsSessionsModelFromJson(response.body);

          return models;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
  Future<List<int>> getRoomCalendar(String url) async {
    if (kDebugMode) {
      print(url);

    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));

      if (response.statusCode == 200) {
        var models = roomCalendarModelFromJson(response.body);


          return models;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
  Future<String> getRoomTimezone(String url) async {
    if (kDebugMode) {
      print(url);
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
      ).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {



          return response.body;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
  Future<List<RoomHoursModel>> getRoomHour(String url,RoomHoursParams params) async {
    if (kDebugMode) {
      print(url);
      print(roomHoursParamsToJson(params));
    }
    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: roomHoursParamsToJson(params),
      ).timeout(Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        var models = roomHoursModelFromJson(response.body);


          return models;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
  Future<int> reserveMeeting(String url,ReserveMeetingParams params) async {

    if (kDebugMode) {
      print(url);
      print(reserveMeetingParamsToJson(params));
    }


    JWT = globalSH.getString(CACHED_JWT_TOKEN)!;
    try {

      final response = await post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + JWT,
        },
        body: reserveMeetingParamsToJson(params),
      ).timeout(Duration(seconds: timeout));
      print("fdjknvjkfnvkjdnfvkjdfn");
      print(response.body);
      if(response.body=="false"){return 501;}
      if (response.statusCode == 200) {

        return 200;
        // var models = reserveMeetingModelFromJson(response.body);
        //
        //
        // print("bjhbjhbhjbhbhb");
        //   return models;


      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
