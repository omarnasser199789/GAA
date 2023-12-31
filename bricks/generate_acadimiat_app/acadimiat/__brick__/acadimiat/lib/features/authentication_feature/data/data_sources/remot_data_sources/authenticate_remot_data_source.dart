import 'package:http/http.dart' as http;
import '../../../../../core/globals.dart';
import '../../../domain/use_cases/facheck_usecase.dart';
import '../../../domain/use_cases/login_usecase.dart';
import '../../../domain/use_cases/register_usecase.dart';
import '../../../domain/use_cases/update_user_info_usecase.dart';
import '../../models/authenticate_model.dart';
import '../../models/check_password_model.dart';
import '../../models/update_user_mode_info.dart';
import 'authenticate_remote_data_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';


// This abstract class defines the contract for a remote data source that handles authentication-related operations.
abstract class AuthenticateRemoteDataSource {

  // This method sends a login request to the server using the given login parameters and returns the status code of the response.
  Future<AuthenticateModel> login(LoginParams params);

  // This method sends a registration request to the server using the given registration parameters and returns the status code of the response.
  Future<int> register(RegisterParams params);

  Future<int> facheck(FacheckParams params);

  // This method sends a password reset request to the server using the given email and returns the status code of the response.
  Future<int> resetPassword(String email);

  // This method sends a check password request to the server using the given login parameters and returns a CheckPasswordModel.
  Future<CheckPasswordModel> checkPassword(LoginParams params);

  // This method sends a change password request to the server using the given login parameters and returns the status code of the response.
  Future<int> changePassword(LoginParams params);

  // This method registers a user in Firebase using the given phone authentication credentials and returns the status code of the response.
  Future<int> registerUserInFirebase(PhoneAuthCredential params);

  // This method updates user information on the server using the given UserInfoParams and returns an UpdateUserInfoModel.
  Future<UpdateUserInfoModel> updateUserInfo(UserInfoParams params);
}


// This class is responsible for implementing the remote data source for authentication-related operations.
class AuthenticateRemoteDataSourceImpl implements AuthenticateRemoteDataSource {
  final http.Client client;

  AuthenticateRemoteDataSourceImpl({required this.client});

  // Instantiate a new instance of AuthenticateRemoteDataFunctions to handle API requests.
  AuthenticateRemoteDataFunctions functions = AuthenticateRemoteDataFunctions();

  // Calls the login API endpoint to authenticate the user and return a JWT token.
  @override
  Future<AuthenticateModel> login(LoginParams params) async {
    return functions.login('$baseUrl/account/authenticate', params);
  }

  @override
  Future<int> facheck(FacheckParams params) {
    return functions.facheck('$baseUrl/account/2facheck', params);
  }

  // Calls the register API endpoint to create a new user account.
  @override
  Future<int> register(RegisterParams params) {
    return functions.register('$baseUrl/account/register_via_mobile', params);
  }

  // Calls the checkpassword API endpoint to check if a user's password is valid.
  @override
  Future<CheckPasswordModel> checkPassword(LoginParams params) {
    return functions.checkPassword('$baseUrl/users/checkpassword', params);
  }

  // Calls the changepassword API endpoint to change a user's password.
  @override
  Future<int> changePassword(LoginParams params) {
    return functions.changePassword('$baseUrl/users/changepassword', params);
  }

  // Calls the registerUserInFirebase API endpoint to register a user in Firebase.
  @override
  Future<int> registerUserInFirebase(PhoneAuthCredential params) {
    return functions.registerUserInFirebase(params);
  }

  // Calls the updateinfo API endpoint to update a user's information.
  @override
  Future<UpdateUserInfoModel> updateUserInfo(UserInfoParams params) {
    return functions.updateUserInfo('$baseUrl/v1/updateinfo', params);
  }

  // Calls the reset API endpoint to reset a user's password.
  @override
  Future<int> resetPassword(String email) {
    return functions.resetPassword('$baseUrl/account/reset', email);
  }

}

