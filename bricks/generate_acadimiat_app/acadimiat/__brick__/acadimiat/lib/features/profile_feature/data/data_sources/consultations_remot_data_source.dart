import 'package:http/http.dart' as http;

import '../../../../core/functions.dart';
import '../../../../core/globals.dart';
import '../../../authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import '../../domain/entities/my_payments_entity.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import '../../domain/use_cases/my_notes/add_new_note_usecase.dart';
import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';
import '../../domain/use_cases/register_new_account_usecase.dart';
import '../../domain/use_cases/update_my_avatar_usecase.dart';
import '../../domain/use_cases/update_user_info_usecase.dart';
import '../models/add_new_note_model.dart';
import '../models/my_assignments_model.dart';
import '../models/my_bookmarks_model.dart';
import '../models/my_certificates_model.dart';
import '../models/my_notes_model.dart';
import '../models/my_plans_model.dart';
import '../models/my_quizzes_model.dart';
import '../../../authentication_feature/data/models/update_user_mode_info.dart';
import '../models/user_info_model.dart';
import 'consultations_remote_data_functions.dart';

abstract class ProfileRemoteDataSource {
  Future<int> resendActivationEmail(String email);
  Future<int> resetPassword(String email);
  Future<int> changePassword(ChangePasswordParams params);
  Future<int> registerNewAccount(RegisterNewAccountParams params);

  Future<UserInfoModel> getUserInfo(int userId);
  Future<UpdateUserInfoModel> updateUserInfo(UserInfoParams params);
  Future<List<MyPaymentEntity>> getMyPaymentsList(String userId);
  Future<int> updateMyAvatar(UpdateMyAvatarParam param);
  Future<List<MyCertificatesModel>> getCertificatesList(int userId);
  Future<int> exportCertificateToPDF(ExportCertificatesToPdfParams params);
  Future<MyNotesModel> getMyNotes(int userId);
  Future<int> deleteNote(int id);
  Future<int> deletePlan(int id);
  Future<AddNewNoteModel> addNewNote(AddNewNoteParams params);
  Future<List<MyPlansModel>> getMyPlans(int userId);
  Future<int> postMyPlan(PostMyPlanParams params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  ProfileRemoteDataFunctions functions = ProfileRemoteDataFunctions();

  @override
  Future<int> resendActivationEmail(String email) async {
    return functions
        .getResendActivationEmail('$baseUrl/account/reactivate/{$email}');
  }

  @override
  Future<int> resetPassword(String email) async {
    return functions.resetPassword('$baseUrl/account/reset', email);
  }

  @override
  Future<int> changePassword(ChangePasswordParams params) async {
    return functions.changePassword('$baseUrl/v1/changepassword', params);
  }

  @override
  Future<int> registerNewAccount(RegisterNewAccountParams params) async {
    return functions.registerNewAccount('$baseUrl/account/register', params);
  }

  @override
  Future<UserInfoModel> getUserInfo(int userId) {
    return functions.getUserInfo('$baseUrl/v1/info/$userId');
  }

  @override
  Future<UpdateUserInfoModel> updateUserInfo(UserInfoParams params) {
    return functions.updateUserInfo('$baseUrl/v1/updateinfo', params);
  }

  @override
  Future<List<MyPaymentEntity>> getMyPaymentsList(String userId) {
    return functions.getMyPaymentsList('$baseUrl/v1/mypayments/$userId');
  }

  @override
  Future<int> updateMyAvatar(UpdateMyAvatarParam param) {
    return functions.updateMyAvatar(
        '$baseUrl/v1/avatar/${param.userId}', param.image);
  }

  @override
  Future<List<MyCertificatesModel>> getCertificatesList(int userId) {
    return functions.getCertificatesList('$baseUrl/v1/mycertificates/$userId');
  }

  @override
  Future<int> exportCertificateToPDF(ExportCertificatesToPdfParams params) {
    return functions.exportCertificateToPDF('$baseUrl/v1/exportpdf', params);
  }

  @override
  Future<MyNotesModel> getMyNotes(int userId) {
    return functions.getMyNotes('$baseUrl/v1/notes/$userId');
  }

  @override
  Future<int> deleteNote(int id) {
    return functions.deleteNote('$baseUrl/v1/note/$id');
  }

  @override
  Future<AddNewNoteModel> addNewNote(AddNewNoteParams params) {
    return functions.addNewNote('$baseUrl/v1/note/', params);
  }

  @override
  Future<List<MyPlansModel>> getMyPlans(int userId) {
    return functions.getMyPlans('$baseUrl/v1/myplans/$userId');
  }

  @override
  Future<int> deletePlan(int planId) {
    return functions.deletePlan('$baseUrl/v1/plan/$planId-${userId()}');
  }

  @override
  Future<int> postMyPlan(PostMyPlanParams params) {
    return functions.postMyPlan('$baseUrl/v1/myplan', params);
  }
}
