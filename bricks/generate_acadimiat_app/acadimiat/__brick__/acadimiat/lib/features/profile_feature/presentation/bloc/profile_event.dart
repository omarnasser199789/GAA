

import '../../domain/use_cases/my_certificate_folder/export_certificate_to_pdf_usecase.dart';
import '../../domain/use_cases/my_notes/add_new_note_usecase.dart';
import '../../domain/use_cases/my_plans/post_my_plan_usecase.dart';

abstract class ProfileEvent {}

class ResendActivationEmail extends ProfileEvent {
  final String email;
  ResendActivationEmail({required this.email});
}

class ResetPassword extends ProfileEvent {
  final String email;
  ResetPassword({required this.email});
}

class ChangePassword extends ProfileEvent {
  final String currentpassword;
  final String newpassword;
  final int useId;
  ChangePassword({required this.currentpassword,required this.newpassword, required this.useId});
}

class RegisterNewAccount extends ProfileEvent {
  final String fullName;
  final String email;
  final String password;
  final String phone;

  RegisterNewAccount({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
  });
}

class GetMyQuizzesList extends ProfileEvent {
  final String userId;
  GetMyQuizzesList({required this.userId});
}

class GetMyAssignmentList extends ProfileEvent {
  final String userId;
  GetMyAssignmentList({required this.userId});
}

class GetMyCertificates extends ProfileEvent {
  final int userId;
  GetMyCertificates({required this.userId});
}
class GetMyNotes extends ProfileEvent {
  final int userId;
  GetMyNotes({required this.userId});
}
class GetMyPlans extends ProfileEvent {
  final int userId;
  GetMyPlans({required this.userId});
}
class DeletePlan extends ProfileEvent {
  final int planId;
  DeletePlan({required this.planId});
}
class PostMyPlanEvent extends ProfileEvent {
  final PostMyPlanParams postMyPlanParams;
  PostMyPlanEvent({required this.postMyPlanParams});
}
class DeleteNote extends ProfileEvent {
  final int id;
  DeleteNote({required this.id});
}
class AddNewNoteEvent extends ProfileEvent {
  final AddNewNoteParams params;
  AddNewNoteEvent({required this.params});
}

class ExportCertificateToPdfEvent extends ProfileEvent {
  final ExportCertificatesToPdfParams params;
  ExportCertificateToPdfEvent({required this.params});
}


class GteMyBookmarksList extends ProfileEvent {
  final String userId;
  GteMyBookmarksList({required this.userId});
}

class GetUserInfo extends ProfileEvent {
  final int userId;
  GetUserInfo({required this.userId});
}

class UpdateUserInfo extends ProfileEvent {
  final String email;
  final int id;
  final String name;
  final String phone;
  final String birthdate;

  UpdateUserInfo({
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.birthdate,
  });
}

class GetMyPayments extends ProfileEvent {
  final String userId;
  GetMyPayments({required this.userId});
}

class UpdateMyAvatar extends ProfileEvent {
  final String userId;
  final String image;
  UpdateMyAvatar({required this.image, required this.userId});
}
