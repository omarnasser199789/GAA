import 'package:dartz/dartz.dart';
import 'package:built_collection/built_collection.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/built_post.dart';
import '../../../data/models/posts_model.dart';
import '../../repositories/profile_repository.dart';
import 'dart:convert';

class GetPostByIdUseCase implements UseCase<PostsModel,int> {
  final TestRepository repository;
  GetPostByIdUseCase({required this.repository});


  @override
  Future<Either<Failure, PostsModel>> call(int id) {
    return repository.getPostByID(id);
  }


}






