import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';

import '../models/built_post.dart';
import 'built_value_converter.dart';


part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);


  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://jsonplaceholder.typicode.com'),
      services: [
        _$PostApiService(),
      ],
      // converter: JsonConverter(),
      // converter: BuiltValueConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$PostApiService(client);
  }
}
