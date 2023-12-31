import 'package:acadmiat/features/profile_feature/domain/entities/add_new_note_entity.dart';
import 'package:acadmiat/features/profile_feature/domain/entities/my_plans_entity.dart';
import 'package:acadmiat/features/profile_feature/domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import 'package:acadmiat/features/profile_feature/domain/use_cases/my_notes/add_new_note_usecase.dart';
import 'package:acadmiat/features/profile_feature/domain/use_cases/my_plans/post_my_plan_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication_feature/domain/use_cases/update_user_info_usecase.dart';
import '../../domain/entities/my_assignments_entity.dart';
import '../../domain/entities/my_bookmarks_entity.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/entities/my_notes_entity.dart';
import '../../domain/entities/my_payments_entity.dart';
import '../../domain/entities/my_quizzes_entity.dart';
import '../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../../domain/entities/user_info_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/register_new_account_usecase.dart';
import '../../domain/use_cases/update_my_avatar_usecase.dart';
import '../../domain/use_cases/update_user_info_usecase.dart';
import '../data_sources/consultations_remot_data_source.dart';
import 'consultations_repository_functions.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // final    ;
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryFunctions functions = ProfileRepositoryFunctions();

  ProfileRepositoryImpl({
    // required this. ,
    required this.profileRemoteDataSource,
  });
  @override
  Future<Either<Failure, int>> resendActivationEmail(String email) async {
    return await functions.resendActivationEmail(() {
      return profileRemoteDataSource.resendActivationEmail(email);
    }, );
  }

  @override
  Future<Either<Failure, int>> resetPassword(String email) async {
    return await functions.resetPassword(() {
      return profileRemoteDataSource.resetPassword(email);
    },  );
  }

  @override
  Future<Either<Failure, int>> changePassword(
      ChangePasswordParams params) async {
    return await functions.changePassword(() {
      return profileRemoteDataSource.changePassword(params);
    },
        );
  }

  @override
  Future<Either<Failure, int>> registerNewAccount(
      RegisterNewAccountParams params) async {
    return await functions.registerNewAccount(() {
      return profileRemoteDataSource.registerNewAccount(params);
    }, );
  }





  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo(int userId) async {
    return await functions.getUserInfo(() {
      return profileRemoteDataSource.getUserInfo(userId);
    },  );
  }

  @override
  Future<Either<Failure, UpdateUserInfoEntity>> updateUserInfo(
      UserInfoParams params) async {
    return await functions.updateUserInfo(() {
      return profileRemoteDataSource.updateUserInfo(params);
    },  );
  }

  @override
  Future<Either<Failure, List<MyPaymentEntity>>> getMyPaymentsList(
      String userId) async {
    return await functions.getMyPaymentsList(() {
      return profileRemoteDataSource.getMyPaymentsList(userId);
    },  );
  }

  @override
  Future<Either<Failure, int>> updateMyAvatar(UpdateMyAvatarParam param) async {
    return await functions.updateMyAvatar(() {
      return profileRemoteDataSource.updateMyAvatar(param);
    },  );
  }

  @override
  Future<Either<Failure, List<MyCertificatesEntity>>> getCertificatesList(int userId) async {
    return await functions.myCertificatesEntity(() {
      return profileRemoteDataSource.getCertificatesList(userId);
    },  );
  }

  @override
  Future<Either<Failure, int>> exportCertificateToPDF(ExportCertificatesToPdfParams param) async {
    return await functions.statusCode(() {
      return profileRemoteDataSource.exportCertificateToPDF(param);
    },  );
  }

  @override
  Future<Either<Failure, MyNoteEntity>> getMyNotes(int userId)async {
    return await functions.myNoteEntity(() {
      return profileRemoteDataSource.getMyNotes(userId);
    },  );
  }

  @override
  Future<Either<Failure, int>> deleteNote(int id) async {
    return await functions.statusCode(() {
      return profileRemoteDataSource.deleteNote(id);
    },  );
  }

  @override
  Future<Either<Failure, AddNewNoteEntity>> addNewNote(AddNewNoteParams params)async {
    return await functions.addNewNoteEntity(() {
      return profileRemoteDataSource.addNewNote(params);
    },  );
  }

  @override
  Future<Either<Failure, List<MyPlansEntity>>> getMyPlans(int userId) async {
    return await functions.getMyPlans(() {
      return profileRemoteDataSource.getMyPlans(userId);
    },  );
  }

  @override
  Future<Either<Failure, int>> deletePlan(int planId) async {
    return await functions.statusCode(() {
      return profileRemoteDataSource.deletePlan(planId);
    },  );
  }

  @override
  Future<Either<Failure, int>> postMyPlan(PostMyPlanParams params) async{
    return await functions.statusCode(() {
      return profileRemoteDataSource.postMyPlan(params);
    },  );
  }
}
