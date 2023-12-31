import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';

import '../repositories/authenticate_repository.dart';

class FacheckUseCase implements UseCase<int, FacheckParams> {
  final AuthenticateRepository repository;
  FacheckUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(FacheckParams params) {
    return repository.facheck(params);
  }
}


String facheckParamsToJson(FacheckParams data) => json.encode(data.toJson());

class FacheckParams {
  String email;
  String userId;
  String code;

  FacheckParams({
    required this.email,
    required this.userId,
    required this.code,
  });


  Map<String, dynamic> toJson() => {
    "email": email,
    "userId": userId,
    "code": code,
  };
}
