import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:built_collection/built_collection.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/built_post.dart';
import '../../data/models/posts_model.dart';



abstract class TestRepository{

  Future<Either<Failure,List<PostsModel>>> postMyPlan(String params);
  Future<Either<Failure,PostsModel>> getPostByID(int id);


}