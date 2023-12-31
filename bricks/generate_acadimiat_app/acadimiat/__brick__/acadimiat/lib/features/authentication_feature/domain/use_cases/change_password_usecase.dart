// import 'package:dartz/dartz.dart';
// import '../../../../../../core/error/failures.dart';
// import '../../../../../../core/usecases/usecase.dart';
// import '../entities/check_password_entity.dart';
// import '../repositories/authenticate_repository.dart';
// import 'login_usecase.dart';
// import 'package:equatable/equatable.dart';
// class ChangePasswordUseCase implements UseCase<int, LoginParams> {
//   final AuthenticateRepository repository;
//   ChangePasswordUseCase({required this.repository});
//   @override
//   Future<Either<Failure, int>> call(LoginParams params) {
//     return repository.changePassword(params);
//   }
// }
//
// // @immutable
// // class ChangePasswordParams extends Equatable{
// //   final String currentpassword;
// //   final String newpassword;
// //   final int userId;
// //   const ChangePasswordParams({required this.newpassword,required this.currentpassword,required this.userId});
// //   @override
// //   // TODO: implement props
// //   List<Object> get props => [];
// //
// // }