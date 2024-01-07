import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/globals.dart';
import '../../models/login_model.dart';

// This abstract class defines the interface for a local data source that provides
// authentication-related functionality.
abstract class AuthenticationLocalDataSource {

  // This method returns a `LoginModel` object representing the currently authenticated user's JWT token,
  // or throws an error if no token is available.
  Future<LoginModel> getUserJWTToken();

// This method caches a `LoginModel` object to be used for future authentication requests.
// Future<void> cacheAuthentication(LoginModel loginModel);

// This method updates the currently authenticated user's refresh token and JWT token,
// based on the provided `refreshToken` and `jwtToken` parameters.
// Future<void> updateRefreshToken(String refreshToken, String jwtToken);
}

// This class implements the `AuthenticationLocalDataSource` interface,
// providing a concrete implementation of its methods to interact with
// the local device storage for authentication-related functionality.
class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {

  // Default constructor.
  AuthenticationLocalDataSourceImpl();

  // Implementation of the `getUserJWTToken()` method defined in the `AuthenticationLocalDataSource` interface.
  // Retrieves the cached JWT token for the authenticated user, and returns it as a `LoginModel` object.
  // Throws a `CacheException` if the JWT token is not available in cache.
  @override
  Future<LoginModel> getUserJWTToken() async {
    globalSH = await SharedPreferences.getInstance();

    final jsonString = globalSH.getString(CACHED_JWT_TOKEN);

    if (jsonString != null) {
      return Future.value(LoginModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  // Implementation of the `cacheAuthentication()` method defined in the `AuthenticationLocalDataSource` interface.
  // Caches the provided `LoginModel` object to be used for future authentication requests.
  Future<void> cacheAuthentication(LoginModel loginModel) async {
    globalSH = await SharedPreferences.getInstance();
    // Store the JWT token
    globalSH.setString(CACHED_JWT_TOKEN, loginModel.jwtToken,);
    // Store the Customer ID
    globalSH.setString(CUSTOMER_ID, loginModel.id.toString(),);
    // Store the user email
    globalSH.setString(CUSTOMER_EMAIL, loginModel.email,);
    // Store the refresh token
    globalSH.setString(CACHED_Refresh_TOKEN, loginModel.refreshToken,);
    // Store the User ID
    globalSH.setString(USER_ID, loginModel.userId.toString(),);

    // Store the courses that the user has already purchased
    List<int> myCoursesList=[];
    for(var item in loginModel.myCourses){
      myCoursesList.add(item.courseId);
    }
    final jsonString = jsonEncode(myCoursesList);
    globalSH.setString(MY_COURSES_List, jsonString);
  }
}
