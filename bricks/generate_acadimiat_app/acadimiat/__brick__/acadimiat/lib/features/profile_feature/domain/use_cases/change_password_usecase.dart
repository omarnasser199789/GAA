import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';
class Dss{}

class ChangePasswordUseCase implements UseCase<int, ChangePasswordParams > {
  final ProfileRepository repository;
  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(ChangePasswordParams params) {
    return repository.changePassword(params);
  }
}

@immutable
class ChangePasswordParams extends Equatable{
  final String currentpassword;
  final String newpassword;
  final int userId;
  const ChangePasswordParams({required this.newpassword,required this.currentpassword,required this.userId});
  @override
  // TODO: implement props
  List<Object> get props => [];

}




