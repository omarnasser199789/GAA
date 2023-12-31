import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/consultations_remot_data_source.dart';
import '../models/posts_model.dart';
import 'consultations_repository_functions.dart';

class TestRepositoryImpl implements TestRepository {
  final TestRemoteDataSource testRemoteDataSource;
  // final PostApiService postApiService;
  TestRepositoryFunctions functions = TestRepositoryFunctions();

  TestRepositoryImpl({
    required this.testRemoteDataSource,
   // required this.postApiService
  });





  @override
  Future<Either<Failure, List<PostsModel>>> postMyPlan(String params) async{
    return await functions.statusCode(() {
      return testRemoteDataSource.postMyPlan(params);
      // return postApiService.getPosts();
    },  );
  }

  @override
  Future<Either<Failure, PostsModel>> getPostByID(int id) async {
    return await functions.statusCodee(() {
      return testRemoteDataSource.getPostByID(id);
    },  );
  }
}
