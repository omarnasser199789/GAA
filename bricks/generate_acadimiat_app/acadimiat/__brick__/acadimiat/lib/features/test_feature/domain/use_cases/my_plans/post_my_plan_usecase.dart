import 'package:dartz/dartz.dart';
import 'package:built_collection/built_collection.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/built_post.dart';
import '../../../data/models/posts_model.dart';
import '../../repositories/profile_repository.dart';
import 'dart:convert';

class GetTestUseCase implements UseCase<List<PostsModel>,String> {
  final TestRepository repository;
  GetTestUseCase({required this.repository});


  @override
  Future<Either<Failure, List<PostsModel>>> call(String params) {
    return repository.postMyPlan(params);
  }


}






