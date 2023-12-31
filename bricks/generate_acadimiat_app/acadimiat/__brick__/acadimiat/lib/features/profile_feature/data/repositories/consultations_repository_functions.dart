import 'package:acadmiat/features/profile_feature/domain/entities/my_certificates_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/add_new_note_entity.dart';
import '../../domain/entities/my_assignments_entity.dart';
import '../../domain/entities/my_bookmarks_entity.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/entities/my_certificates_entity.dart';
import '../../domain/entities/my_notes_entity.dart';
import '../../domain/entities/my_payments_entity.dart';
import '../../domain/entities/my_plans_entity.dart';
import '../../domain/entities/my_quizzes_entity.dart';
import '../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../../domain/entities/user_info_entity.dart';

typedef Future<int> _ResendActivationEmailInfoChooser();
typedef Future<int> _StatusCodeInfoChooser();
typedef Future<UpdateUserInfoEntity> _UpdateUserInfoEntityInfoChooser();
typedef Future< List<MyCertificatesEntity>> _MyCertificatesEntityInfoChooser();

typedef Future<List<MyQuizzesEntity>> _MyQuizzesListModelInfoChooser();
typedef Future<List<MyAssignmentsEntity>> _MyAssignmentsEntityInfoChooser();
typedef Future<List<MyBookmarksEntity>> _MyBookmarksEntityInfoChooser();
typedef Future<UserInfoEntity> _UserInfoEntityInfoChooser();
typedef Future<List<MyPaymentEntity>> _MyPaymentEntityInfoChooser();
typedef Future<MyNoteEntity> _MyNoteEntityInfoChooser();
typedef Future<AddNewNoteEntity> _AddNewNoteEntityInfoChooser();
typedef Future<List<MyPlansEntity>> _MyPlansEntityInfoChooser();


class ProfileRepositoryFunctions {
  Future<Either<Failure, int>> resendActivationEmail(
      _ResendActivationEmailInfoChooser _resendActivationEmailInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _resendActivationEmailInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }
  Future<Either<Failure, int>> resetPassword(
      _ResendActivationEmailInfoChooser _resendActivationEmailInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _resendActivationEmailInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }

  Future<Either<Failure, int>> changePassword(
      _ResendActivationEmailInfoChooser _resendActivationEmailInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _resendActivationEmailInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }
  Future<Either<Failure, int>> registerNewAccount(
      _ResendActivationEmailInfoChooser _resendActivationEmailInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _resendActivationEmailInfoChooser();
    //
        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }
  Future<Either<Failure, List<MyQuizzesEntity>>> getMyQuizzesList(
      _MyQuizzesListModelInfoChooser _myQuizzesListModelInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _myQuizzesListModelInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }
   Future<Either<Failure, List<MyAssignmentsEntity>>> getMyAssignmentsList(
      _MyAssignmentsEntityInfoChooser _myAssignmentsEntityInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _myAssignmentsEntityInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }
   Future<Either<Failure, List<MyBookmarksEntity>>> getMyBookmarksList(
      _MyBookmarksEntityInfoChooser _myBookmarksEntityInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _myBookmarksEntityInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }



   Future<Either<Failure,UserInfoEntity>> getUserInfo(
      _UserInfoEntityInfoChooser _userInfoEntityInfoChooser) async {
    // if (await networkInfo.isConnected) {
      try {
        final remotePhysician = await _userInfoEntityInfoChooser();

        return Right(remotePhysician);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
    //   return Left(ServerFailure());
    // }
  }


   Future<Either<Failure,UpdateUserInfoEntity>> updateUserInfo(
      _UpdateUserInfoEntityInfoChooser _updateUserInfoEntityInfoChooser) async {
    // if (await networkInfo.isConnected) {
       try {
        final remotePhysician = await _updateUserInfoEntityInfoChooser();

        return Right(remotePhysician);
   } on ServerException {
  return Left(ServerFailure());
}
  }


   Future<Either<Failure,List<MyPaymentEntity>>> getMyPaymentsList(
      _MyPaymentEntityInfoChooser _myPaymentEntityInfoChooser) async {
    try {
        final remotePhysician = await _myPaymentEntityInfoChooser();

        return Right(remotePhysician);
   } on ServerException {
  return Left(ServerFailure());
}
  }


  Future<Either<Failure,List<MyCertificatesEntity>>> myCertificatesEntity(
      _MyCertificatesEntityInfoChooser _myCertificatesEntityInfoChooser) async {
    try{
    final remotePhysician = await _myCertificatesEntityInfoChooser();
    return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }
  Future<Either<Failure,int>> statusCode(
      _StatusCodeInfoChooser _statusCodeInfoChooser) async {
    try{
    final remotePhysician = await _statusCodeInfoChooser();
    return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }


  Future<Either<Failure,int>> updateMyAvatar(
      _ResendActivationEmailInfoChooser _resendActivationEmailInfoChooser) async {
    try{
        final remotePhysician = await _resendActivationEmailInfoChooser();
        return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }
  Future<Either<Failure,MyNoteEntity>> myNoteEntity(
      _MyNoteEntityInfoChooser _myNoteEntityInfoChooser) async {
    try{
        final remotePhysician = await _myNoteEntityInfoChooser();
        return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }
  Future<Either<Failure,AddNewNoteEntity>> addNewNoteEntity(
      _AddNewNoteEntityInfoChooser _addNewNoteEntityInfoChooser) async {
    try{
        final remotePhysician = await _addNewNoteEntityInfoChooser();
        return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }
  Future<Either<Failure,List<MyPlansEntity>>> getMyPlans(
      _MyPlansEntityInfoChooser _myPlansEntityInfoChooser) async {
    try {
        final remotePhysician = await _myPlansEntityInfoChooser();
        print("fdjnvjkfnvkjnjkfnvkjdvjf");
        print(remotePhysician);
        return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }

}
