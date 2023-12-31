import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../../../../../core/classes/Response.dart' as R;
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/facheck_usecase.dart';
import '../../../domain/use_cases/login_usecase.dart';
import '../../../domain/use_cases/register_usecase.dart';
import '../../../domain/use_cases/update_user_info_usecase.dart';
import '../../models/authenticate_model.dart';
import '../../models/check_password_model.dart';
import '../../models/login_model.dart';
import '../../models/register_model.dart';
import '../../models/update_user_mode_info.dart';
import '../local_data_source/authentication_local_data_sources.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateRemoteDataFunctions {
  /// Login function that sends a POST request to the server with login data and caches authentication data
  Future<AuthenticateModel> login(String url, LoginParams params) async {
    /// Print the URL in debug mode
    if (kDebugMode) {
      print(url);
    }

    /// Create a map with the login name and password
    Map<String, dynamic> data = {
      "loginName": params.loginName,
      "password": params.password,
    };

    /// Store the login name and password in SharedPreferences
    globalSH.setString(CACHED_UN, params.loginName);
    globalSH.setString(CACHED_UP, params.password);

    /// Print the data in debug mode
    if (kDebugMode) {
      print(data);
    }

    try {
      /// Send a POST request with the login data
      final response = await post(
        Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(Duration(seconds: timeout));

      /// If the response status code is 200, cache the authentication data and return 200
      if (response.statusCode == 200) {
        // AuthenticationLocalDataSourceImpl authenticationLocalDataSourcesImpl = AuthenticationLocalDataSourceImpl();
        // await authenticationLocalDataSourcesImpl.cacheAuthentication(loginModelFromJson(response.body));
        return authenticateModelFromJson(response.body);
      } else {
        /// If the response status code is not 200, throw a ServerException
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw ServerException();
      }
    } catch (e) {
      /// If an error occurs, throw a ServerException
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  Future<int> facheck(String url, FacheckParams params) async {
    /// Print the URL in debug mode
    if (kDebugMode) {
      print(url);
    }

    /// Store the login name and password in SharedPreferences
    globalSH.setString(CACHED_UN, params.email);
    globalSH.setString(CACHED_UP, params.code);
    globalSH.setString(USER_ID, params.userId);

    /// Print the data in debug mode
    if (kDebugMode) {
      print(facheckParamsToJson(params));
    }

    try {
      /// Send a POST request with the login data
      final response = await post(
        Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: facheckParamsToJson(params),
      ).timeout(Duration(seconds: timeout));

      print(response.statusCode);
      print(response.body);
      /// If the response status code is 200, cache the authentication data and return 200
      if (response.statusCode == 200) {
        AuthenticationLocalDataSourceImpl authenticationLocalDataSourcesImpl = AuthenticationLocalDataSourceImpl();
        await authenticationLocalDataSourcesImpl.cacheAuthentication(loginModelFromJson(response.body));
        return 200;
      } else {
        /// If the response status code is not 200, throw a ServerException
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw ServerException();
      }
    } catch (e) {
      /// If an error occurs, throw a ServerException
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  /// Registration function that sends a POST request to the server with registration data and caches authentication data
  Future<int> register(String url, RegisterParams params) async {
    /// print the url in debug mode
    if (kDebugMode) {
      print(url);
    }

    /// create a map containing the registration data
    Map<String, dynamic> data = {
      "email": params.email,
      "password": params.password,
      "fullname": params.fullName,
      "repassword": params.rePassword,
      "acceptterms": params.acceptTerms,
      "phone": params.phone
    };

    /// store the email and password in shared preferences
    globalSH.setString(CACHED_UN, params.email);
    globalSH.setString(CACHED_UP, params.password);

    /// print the registration data in debug mode
    if (kDebugMode) {
      print(data);
    }

    try {
      final response = await post(Uri.parse(url),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));

      /// check if the response body contains "existed"
      if (response.body.contains("existed")) {
        /// return a status code of 600 to indicate that the email already exists
        return 600;
      } else {
        /// check if the response status code is 200
        if (response.statusCode == 200) {
          /// create a RegisterModel from the response body
          RegisterModel model = registerModelFromJson(response.body);

          /// create a LoginModel from the RegisterModel
          LoginModel loginModel = LoginModel(
              id: model.id,
              email: model.email,
              name: model.name,
              avatar: model.avatar,
              groupId: model.groupId,
              trainerId: model.trainerId,
              userId: model.userId,
              jwtToken: model.jwtToken,
              myCourses: [],
              refreshToken: model.refreshToken);

          /// cache the LoginModel using the local data source
          AuthenticationLocalDataSourceImpl authenticationLocalDataSourcesImpl =
              AuthenticationLocalDataSourceImpl();
          await authenticationLocalDataSourcesImpl
              .cacheAuthentication(loginModel);

          /// return a status code of 200 to indicate successful registration
          return 200;
        } else {
          /// throw a ServerException if the response status code is not 200
          if (kDebugMode) {
            print(response.statusCode);
          }
          throw ServerException();
        }
      }
    } catch (e) {
      /// print the error in debug mode and throw a ServerException
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  /// Check if the username and password combination is correct
  Future<CheckPasswordModel> checkPassword(String url, LoginParams params) async {
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await post(Uri.parse(url),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
                'Authorization':
                    'Bearer ' + globalSH.getString(CACHED_JWT_TOKEN)!,
              },
              body: jsonEncode([params.loginName, params.password]))
          .timeout(Duration(seconds: timeout));
      print("statusCode=${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        /// Return the check password model if the response is successful
        return checkPasswordModelFromJson(response.body);
      } else {
        /// If the response is unsuccessful, throw a server exception
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  /// Change the password for the given user
  Future<int> changePassword(String url, LoginParams params) async {
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await post(Uri.parse(url),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
                'Authorization':
                    'Bearer ' + globalSH.getString(CACHED_JWT_TOKEN)!,
              },
              body: jsonEncode([params.loginName, params.password]))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        /// If the response is successful, return 200
        return 200;
      } else {
        /// If the response is unsuccessful, throw a server exception
        if (kDebugMode) {
          print(response.statusCode);
        }
        throw ServerException();
      }
    } catch (e) {
      debugPrint("$e");
      throw ServerException();
    }
  }

  /// Update user information with the given URL and UserInfoParams
  Future<UpdateUserInfoModel> updateUserInfo(String url, UserInfoParams params) async {
    if (kDebugMode) {
      print(url);
    }

    /// Get JWT token from local storage
    JWT = await globalSH.getString(CACHED_JWT_TOKEN).toString();

    /// Prepare request data
    Map<String, dynamic> data = {
      'email': params.email,
      'id': params.userId,
      'name': params.name,
      'phone': params.phone,
      'birthdate': params.birthDate,
    };

    /// Print data for debugging purposes
    if (kDebugMode) {
      print(data);
    }
    try {
      /// Make POST request to server
      final response = await post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer ' + JWT,
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));

      /// Check if response is successful
      if (response.statusCode == 200) {
        /// Parse response data and return as UpdateUserInfoModel
        var data = jsonDecode(response.body);
        return UpdateUserInfoModel.fromJson(data);
      } else {
        /// Throw ServerException if response is not successful
        throw ServerException();
      }
    } catch (e) {
      /// Print error message for debugging purposes and rethrow ServerException
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  /// Reset the password for the given email using the given URL
  Future<int> resetPassword(String url, String email) async {
    if (kDebugMode) {
      print(url);
    }

    /// Get JWT token from local storage
    JWT = globalSH.getString(CACHED_JWT_TOKEN).toString();

    /// Prepare request data
    Map<String, dynamic> data = {
      'email': email,
    };

    /// Print data for debugging purposes
    if (kDebugMode) {
      print(data);
    }
    try {
      /// Make POST request to server
      final response = await post(Uri.parse(url),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer ' + JWT,
              },
              body: jsonEncode(data))
          .timeout(Duration(seconds: timeout));

      /// Check if response is successful
      if (response.statusCode == 200) {
        /// Check if response body contains "not found"
        if (response.body.contains("not found")) {
          return 404;
        }
        return 200;
      } else {
        /// Throw ServerException if response is not successful
        throw ServerException();
      }
    } catch (e) {
      /// Print error message for debugging purposes and rethrow ServerException
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }

  /// Register the user with Firebase using the given PhoneAuthCredential
  Future<int> registerUserInFirebase(PhoneAuthCredential phoneAuthCredential) async {
    /// Initialize Firebase Authentication
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      /// Sign in with the given PhoneAuthCredential
      final authCredential = await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        /// Get the ID token from Firebase and print it (for debugging purposes)
        authCredential.user!.getIdToken().then((token) async {
          if (kDebugMode) {
            print("FIREBASE TOKEN: $token");
          }

          ////Save data in locale storage
          /// AuthenticationLocalDataSourceImpl authenticationLocalDataSourcesImpl =
          /// AuthenticationLocalDataSourceImpl();
          /// await authenticationLocalDataSourcesImpl.cacheFirebaseToken(
          ///     token, authCredential.user!.phoneNumber.toString());
        });

        /// Return a status code of 200 if sign-in is successful
        return 200;
      }

      /// Return a status code of 400 if user is null
      return 400;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      /// Return a status code of 403 if there is a FirebaseAuthException
      return 403;
    }
  }

  /// Refresh the authentication token. If the current token has expired
  Future<int> testRefreshToken() async {
    String url = '$baseUrl/account/refresh-token';

    /// Print debug information
    if (kDebugMode) {
      print("££££££££££££££££££££  *** RefreshToken ***  £££££££££££££££££");
      print(url);
    }

    Map<String, String> headersss = {};

    /// Get refresh token from local storage
    REFRESH = globalSH.getString(CACHED_Refresh_TOKEN).toString();

    /// Set headers with refresh token
    headersss['cookie'] = "refreshToken=$REFRESH; Path=/; HttpOnly; Expires=Tue, 23 Nov 2021 04:08:04 GMT;";

    try {
      /// Send request to server
      var response = await post(
        Uri.parse(url),
        headers: headersss,
      ).timeout(Duration(seconds: timeout));
      var res = json.decode(response.body);

      if (kDebugMode) {
        print("RefreshToken:${response.statusCode}");
      }
      /// Check server response status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        /// Update refresh token in local storage
        AuthenticationLocalDataSourceImpl authenticationLocalDataSourcesImpl = AuthenticationLocalDataSourceImpl();
        await authenticationLocalDataSourcesImpl.cacheAuthentication(loginModelFromJson(response.body));
        return 200;
      } else if (response.statusCode == 401) {
        return 401;
      } else {
        return 401;
      }
    } catch (e) {
      return 401;
    }
  }
}
