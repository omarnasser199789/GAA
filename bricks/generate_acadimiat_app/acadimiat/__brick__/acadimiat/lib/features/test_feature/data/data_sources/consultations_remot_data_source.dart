import 'dart:convert';

import 'package:acadmiat/features/test_feature/data/data_sources/post_api_service.dart';
import 'package:chopper/chopper.dart';
import '../models/built_post.dart';
import 'package:built_collection/built_collection.dart';

import '../models/posts_model.dart';

abstract class TestRemoteDataSource {
  Future<List<PostsModel>> postMyPlan(String params);
  Future<PostsModel> getPostByID(int id);


}

class TestRemoteDataSourceImpl implements TestRemoteDataSource {
  @override
  Future<List<PostsModel>> postMyPlan(String params) async {
    Response response =await PostApiService.create().getPosts();
    List<PostsModel> list = postsModelFromJson(response.body.toString());
    return list;
  }

  @override
  Future<PostsModel> getPostByID(int id) async {
    Response response =await PostApiService.create().getPost(id);
    return PostsModel.fromJson(json.decode(response.body));
  }


}
