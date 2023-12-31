

import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import '../../../authentication_feature/domain/entities/update_user_info_entity.dart';
import '../../data/models/built_post.dart';
import '../../data/models/posts_model.dart';

abstract class TestState {}

class ProfileInitial extends TestState {}

class Empty extends TestState {}

class Loading extends TestState {}
class SuccessGetEntity extends TestState {
  List<PostsModel> resCode;
  SuccessGetEntity({
    required this.resCode
});
}
class SuccessGetPostEntity extends TestState {
  PostsModel resCode;
  SuccessGetPostEntity({
    required this.resCode
});
}

class Error extends TestState {
  final String message;

  Error({required this.message}); //we use this constructor in ((BLOC & test))

  @override
  List<Object> get props => [message];
}

