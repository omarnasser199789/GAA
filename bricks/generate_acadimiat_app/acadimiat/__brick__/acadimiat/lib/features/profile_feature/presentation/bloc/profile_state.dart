

import '../../domain/entities/add_new_note_entity.dart';
import '../../domain/entities/my_assignments_entity.dart';
import '../../domain/entities/my_bookmarks_entity.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/entities/my_notes_entity.dart';
import '../../domain/entities/my_payments_entity.dart';
import '../../domain/entities/my_plans_entity.dart';
import '../../domain/entities/my_quizzes_entity.dart';
import '../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../../domain/entities/user_info_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class Empty extends ProfileState {}

class Loading extends ProfileState {}

class Error extends ProfileState {
  final String message;

  Error({required this.message}); //we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [message];
}

class SuccessSendActivationEmail extends ProfileState {
  final int statusCode;
  SuccessSendActivationEmail({required this.statusCode});
}
class SuccessGetMyCertificatesEntity extends ProfileState {
  final List<MyCertificatesEntity> myCertificatesListEntity;
  SuccessGetMyCertificatesEntity({required this.myCertificatesListEntity});
}

class SuccessResetPassword extends ProfileState {
  final int statusCode;
  SuccessResetPassword({required this.statusCode});
}
class ExportCertificateToPDFEntity extends ProfileState {
  final int statusCode;
  ExportCertificateToPDFEntity({required this.statusCode});
}
class MyNotesEntity extends ProfileState {
  final MyNoteEntity myNoteEntity;
  MyNotesEntity({required this.myNoteEntity});
}
class SuccessDeleteNoteEntity extends ProfileState {
  final int statusCode;
  SuccessDeleteNoteEntity({required this.statusCode});
}
class SuccessChangePassword extends ProfileState {
  final int statusCode;
  SuccessChangePassword({required this.statusCode});
}

class SuccessGetMyQuizzesListEntity extends ProfileState {
  final List<MyQuizzesEntity> myQuizzesListEntity;
  SuccessGetMyQuizzesListEntity({required this.myQuizzesListEntity});
}
class SuccessAddNoteEntity extends ProfileState {
  final AddNewNoteEntity addNewNoteEntity;
  SuccessAddNoteEntity({required this.addNewNoteEntity});
}
class SuccessGetMyPlansEntity extends ProfileState {
  final List<MyPlansEntity> myPlans;
  SuccessGetMyPlansEntity({required this.myPlans});
}
class SuccessDeletePlanEntity extends ProfileState {
  final int statusCode;
  SuccessDeletePlanEntity({required this.statusCode});
}
class SuccessPostMyPlanEntity extends ProfileState {
  final int statusCode;
  SuccessPostMyPlanEntity({required this.statusCode});
}

class SuccessgetMyAssignmentsListEntity extends ProfileState {
  final List<MyAssignmentsEntity> myAssignmentsListEntity;
  SuccessgetMyAssignmentsListEntity({required this.myAssignmentsListEntity});
}

class SuccessGetMyBookmarksListEntity extends ProfileState {
  final List<MyBookmarksEntity> myBookmarksListEntity;
  SuccessGetMyBookmarksListEntity({required this.myBookmarksListEntity});
}

class SuccessGetUserInfoEntity extends ProfileState {
  final UserInfoEntity userInfoEntity;

  SuccessGetUserInfoEntity({required this.userInfoEntity});
}

class SuccessUpdateUserInfoEntity extends ProfileState {
  final UpdateUserInfoEntity updateUserInfoEntity;
  SuccessUpdateUserInfoEntity({required this.updateUserInfoEntity});
}

class SuccessgetMyPaymentsEntity extends ProfileState {
  final List<MyPaymentEntity> myPaymentListEntity;
  SuccessgetMyPaymentsEntity({required this.myPaymentListEntity});
}

class SuccessUpdateUserAvtarEntity extends ProfileState {
  final int resCode;
  SuccessUpdateUserAvtarEntity({required this.resCode});
}
