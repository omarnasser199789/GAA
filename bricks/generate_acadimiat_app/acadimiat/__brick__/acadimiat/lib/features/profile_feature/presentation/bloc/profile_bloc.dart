
import 'package:acadmiat/features/profile_feature/domain/use_cases/get_user_info_usecase.dart';
import 'package:acadmiat/features/profile_feature/domain/use_cases/update_my_avatar_usecase.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/success_error/either_success_or_error.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication_feature/domain/use_cases/change_password_usecase.dart';


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

import '../../domain/use_cases/change_password_usecase.dart';
import '../../domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';

import '../../domain/use_cases/my_certificate_folder/get_my_certificates_usecase.dart';
import '../../domain/use_cases/my_notes/add_new_note_usecase.dart';
import '../../domain/use_cases/my_notes/delete_note_usecase.dart';
import '../../domain/use_cases/my_notes/get_my_notes_usecase.dart';
import '../../domain/use_cases/get_my_payments_usecase.dart';

import '../../domain/use_cases/my_plans/delete_plan_usecase.dart';
import '../../domain/use_cases/my_plans/get_my_plans_usecase.dart';
import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';
import '../../domain/use_cases/register_new_account_usecase.dart';
import '../../domain/use_cases/resend_activation_email_usecase.dart';
import '../../domain/use_cases/reset_password_usecase.dart';
import '../../domain/use_cases/update_user_info_usecase.dart';
import 'bloc.dart';



const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // final ResentActivationEmailUseCase resentActivationEmailUseCase;
  // final ResetPasswordUseCase resetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  // final RegisterNewAccountUseCase registerNewAccountUseCase;
  // final GetMyQuizzesListUseCase getMyQuizzesListUseCase;
  // final GetMyAssignmentsListUseCase getMyAssignmentsListUseCase;
  // final GetMyBookmarksUseCase getMyBookmarksUseCase;
  final GetMyPaymentsUseCase getMyPaymentsUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserInfoUseCase updateUserInfoUseCase;
  final UpdateMyAvatarUseCase updateMyAvatarUseCase;
  final GetMyCertificatesUseCase getMyCertificatesUseCase;
  final ExportCertificateToPDFUseCase exportCertificateToPDFUseCase;
  final GetMyNotesUseCase getMyNotesUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  final GetMyPlansUseCase getMyPlansUseCase;
  final DeletePlanUseCase deletePlanUseCase;
  final PostMyPlanUseCase postMyPlanUseCase;


  ProfileBloc({
    // required ResentActivationEmailUseCase concreteResentActivationEmailUseCase,
    // required ResetPasswordUseCase concreteResetPasswordUseCase,
    required ChangePasswordUseCase concreteChangePasswordUseCase,
    // required RegisterNewAccountUseCase concreteRegisterNewAccountUseCase,
    // required GetMyQuizzesListUseCase concreteGetMyQuizzesListUseCase,
    // required GetMyAssignmentsListUseCase concreteGetMyAssignmentsListUseCase,
    // required GetMyBookmarksUseCase concreteGetMyBookmarksUseCase,
    required GetUserInfoUseCase concreteGetUserInfoUseCase,
    required UpdateUserInfoUseCase concreteUpdateUserInfoUseCase,
    required GetMyPaymentsUseCase concreteGetMyPaymentsUseCase,
    required UpdateMyAvatarUseCase concreteUpdateMyAvatarUseCase,
    required GetMyCertificatesUseCase concreteGetMyCertificatesUseCase,
    required ExportCertificateToPDFUseCase concreteExportCertificateToPDFUseCase,
    required GetMyNotesUseCase concreteGetMyNotesUseCase,
    required DeleteNoteUseCase concreteDeleteNoteUseCase,
    required AddNewNoteUseCase concreteAddNewNoteUseCase,
    required GetMyPlansUseCase concreteGetMyPlansUseCase,
    required DeletePlanUseCase concreteDeletePlanUseCase,
    required PostMyPlanUseCase concretePostMyPlanUseCase,
  })  :
        // assert(concreteResentActivationEmailUseCase != null),
        // assert(concreteResetPasswordUseCase != null),
        assert(concreteChangePasswordUseCase != null),
        // assert(concreteRegisterNewAccountUseCase != null),
        // assert(concreteGetMyQuizzesListUseCase != null),
        assert(concreteUpdateUserInfoUseCase != null),
        // assert(concreteGetMyAssignmentsListUseCase != null),
        // assert(concreteGetMyBookmarksUseCase != null),
        // assert(concreteGetUserInfoUseCase != null),
        assert(concreteGetMyPaymentsUseCase != null),
        // assert(concreteUpdateMyAvatarUseCase != null),
        // assert(concreteUpdateMyAvatarUseCase != null),
        assert(concreteGetMyCertificatesUseCase != null),
        // getMyAssignmentsListUseCase = concreteGetMyAssignmentsListUseCase,
        // resentActivationEmailUseCase = concreteResentActivationEmailUseCase,
        // resetPasswordUseCase = concreteResetPasswordUseCase,
        changePasswordUseCase = concreteChangePasswordUseCase,
        // registerNewAccountUseCase = concreteRegisterNewAccountUseCase,
        // getMyQuizzesListUseCase = concreteGetMyQuizzesListUseCase,
        // getMyBookmarksUseCase = concreteGetMyBookmarksUseCase,
        getUserInfoUseCase = concreteGetUserInfoUseCase,
        updateUserInfoUseCase = concreteUpdateUserInfoUseCase,
        getMyPaymentsUseCase = concreteGetMyPaymentsUseCase,
        updateMyAvatarUseCase = concreteUpdateMyAvatarUseCase,
        deletePlanUseCase = concreteDeletePlanUseCase,
        getMyPlansUseCase = concreteGetMyPlansUseCase,
        getMyCertificatesUseCase = concreteGetMyCertificatesUseCase,
        exportCertificateToPDFUseCase = concreteExportCertificateToPDFUseCase,
        getMyNotesUseCase = concreteGetMyNotesUseCase,
        deleteNoteUseCase = concreteDeleteNoteUseCase,
        addNewNoteUseCase = concreteAddNewNoteUseCase,
        postMyPlanUseCase = concretePostMyPlanUseCase,
        super(Empty());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
 //    if (event is ResendActivationEmail) {
 //
 //      yield Loading();
 //      final failureOrPhysician =
 //          await resentActivationEmailUseCase(event.email);
 //
 //      yield* _eitherResendActivationEmailLoadedOrErrorState(failureOrPhysician);
 //    }
 //    else if (event is ResetPassword) {
 //      yield Loading();
 //      final failureOrPhysician = await resetPasswordUseCase(event.email);
 //
 //      yield* _eitherResetPasswordLoadedOrErrorState(failureOrPhysician);
 //    }
     if (event is ChangePassword) {
      yield Loading();
      final failureOrPhysician =
          await changePasswordUseCase(ChangePasswordParams(
        userId: event.useId,
        currentpassword: event.currentpassword,
        newpassword: event.newpassword,
      ));

      yield* eitherChangePasswordLoadedOrErrorState(failureOrPhysician);
    }
 //    else if (event is RegisterNewAccount) {
 //      final failureOrPhysician =
 //          await registerNewAccountUseCase(RegisterNewAccountParams(
 //        phone: event.phone,
 //        password: event.password,
 //        fullName: event.fullName,
 //        email: event.email,
 //      ));
 //
 //      yield* _eitherLoadedOrErrorState(failureOrPhysician);
 //    }

 //
 //    else if (event is GetMyQuizzesList) {
 //      final failureOrPhysician = await getMyQuizzesListUseCase(event.userId);
 //
 //      yield* _getMyQuizzesListEitherLoadedOrErrorState(failureOrPhysician);
 //    }
 //    else if (event is GetMyAssignmentList) {
 //      final failureOrPhysician =
 //          await getMyAssignmentsListUseCase(event.userId);
 //
 //      yield* _getMyAssignmentsListEitherLoadedOrErrorState(failureOrPhysician);
 //    }
 //    else if (event is GteMyBookmarksList) {
 //      final failureOrPhysician = await getMyBookmarksUseCase(event.userId);
 //      yield* _getMyBookmarksListEitherLoadedOrErrorState(failureOrPhysician);
 //    }

     if (event is UpdateUserInfo) {
      yield Loading();
      final failureOrPhysician = await updateUserInfoUseCase(UserInfoParams(
        birthDate: event.birthdate,
        email: event.email,
        name: event.name,
        phone: event.phone,
        userId: event.id,
      ));
      yield* updateUserInfoUseCaseEitherLoadedOrErrorState(failureOrPhysician);
    }
     if (event is GetMyPayments) {
       yield Loading();
         final failureOrPhysician = await getMyPaymentsUseCase(event.userId);
      yield* getMyPaymentsUseCaseEitherLoadedOrErrorState(failureOrPhysician);
    }
     if(event is UpdateMyAvatar){
      yield Loading();
 final failureOrPhysician = await updateMyAvatarUseCase(
   UpdateMyAvatarParam(image: event.image, userId: event.userId));
      yield* updateMyAvatarEitherLoadedOrErrorState(failureOrPhysician);
    }

        if (event is GetMyCertificates) {
          yield Loading();
         final failureOrPhysician = await getMyCertificatesUseCase(event.userId);

         yield* getMyCertificatesUseCaseEitherLoadedOrErrorState(failureOrPhysician);
       }
        if (event is ExportCertificateToPdfEvent) {
          final failureOrPhysician = await exportCertificateToPDFUseCase(event.params);
          yield* exportCertificateToPDFEitherLoadedOrErrorState(failureOrPhysician);
        }
        if (event is GetMyNotes) {
          yield Loading();
          final failureOrPhysician = await getMyNotesUseCase(event.userId);
          yield* getMyNotesEitherLoadedOrErrorState(failureOrPhysician);
        }
        if (event is DeleteNote) {
          yield Loading();
          final failureOrPhysician = await deleteNoteUseCase(event.id);
          yield* deleteNoteSuccessOrErrorState(failureOrPhysician);
        }
        if (event is AddNewNoteEvent) {
          yield Loading();
          final failureOrPhysician = await addNewNoteUseCase(event.params);
          yield* addNewNoteSuccessOrErrorState(failureOrPhysician);
        }
        if (event is GetMyPlans) {
          yield Loading();
          final failureOrPhysician = await getMyPlansUseCase(event.userId);
          print("fdkjvndfknvkjfnvkjndf");
          print(failureOrPhysician);
          yield* getMyPlansSuccessOrErrorState(failureOrPhysician);
        }
        if (event is DeletePlan) {
          yield Loading();
          final failureOrPhysician = await deletePlanUseCase(event.planId);
          yield* deletePlanSuccessOrErrorState(failureOrPhysician);
        }
        if (event is PostMyPlanEvent) {
          yield Loading();
          final failureOrPhysician = await postMyPlanUseCase(event.postMyPlanParams);
          yield* postMyPlanSuccessOrErrorState(failureOrPhysician);
        }
        if (event is GetUserInfo) {
          final failureOrPhysician = await getUserInfoUseCase(event.userId);
          yield* getUserInfoUseCaseEitherLoadedOrErrorState(failureOrPhysician);
        }
  }


}
