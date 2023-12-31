
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import '../entities/add_new_note_entity.dart';
import '../entities/my_assignments_entity.dart';
import '../entities/my_bookmarks_entity.dart';
import '../entities/my_certificates_entity.dart';
import '../entities/my_notes_entity.dart';
import '../entities/my_payments_entity.dart';
import '../entities/my_plans_entity.dart';
import '../entities/my_quizzes_entity.dart';
import '../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../entities/user_info_entity.dart';
import '../use_cases/change_password_usecase.dart';
import '../use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import '../use_cases/my_notes/add_new_note_usecase.dart';
import '../use_cases/my_plans/post_my_plan_usecase.dart';
import '../use_cases/register_new_account_usecase.dart';
import '../use_cases/update_my_avatar_usecase.dart';
import '../use_cases/update_user_info_usecase.dart';

abstract class ProfileRepository{

  Future<Either<Failure,int>> resendActivationEmail(String email);
  Future<Either<Failure,int>> resetPassword(String email);
  Future<Either<Failure,int>> changePassword(ChangePasswordParams params);
  Future<Either<Failure,List<MyCertificatesEntity>>> getCertificatesList(int  userId);
  Future<Either<Failure,int>> registerNewAccount(RegisterNewAccountParams params);

  Future<Either<Failure,List<MyPaymentEntity>>> getMyPaymentsList(String userId);

  Future<Either<Failure,UserInfoEntity>> getUserInfo(int userId);
  Future<Either<Failure,UpdateUserInfoEntity>> updateUserInfo(UserInfoParams params);
  Future<Either<Failure,int>> updateMyAvatar(UpdateMyAvatarParam param);
  Future<Either<Failure,int>> exportCertificateToPDF(ExportCertificatesToPdfParams param);
  Future<Either<Failure,MyNoteEntity>> getMyNotes(int userId);
  Future<Either<Failure,List<MyPlansEntity>>> getMyPlans(int userId);
  Future<Either<Failure,int>> deleteNote(int id);
  Future<Either<Failure,int>> deletePlan(int planId);
  Future<Either<Failure,AddNewNoteEntity>> addNewNote(AddNewNoteParams params);
  Future<Either<Failure,int>> postMyPlan(PostMyPlanParams params);


}