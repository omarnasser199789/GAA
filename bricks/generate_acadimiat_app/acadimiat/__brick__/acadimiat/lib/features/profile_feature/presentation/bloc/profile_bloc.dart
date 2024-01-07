import 'package:acadmiat/features/profile_feature/domain/use_cases/get_user_info_usecase.dart';
import 'package:acadmiat/features/profile_feature/domain/use_cases/update_my_avatar_usecase.dart';
import 'package:acadmiat/features/profile_feature/presentation/bloc/success_error/either_success_or_error.dart';
import '../../../authentication_feature/domain/use_cases/update_user_info_usecase.dart';
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
import 'bloc.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ChangePasswordUseCase changePasswordUseCase;
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
    required ChangePasswordUseCase concreteChangePasswordUseCase,
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

        changePasswordUseCase = concreteChangePasswordUseCase,
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
