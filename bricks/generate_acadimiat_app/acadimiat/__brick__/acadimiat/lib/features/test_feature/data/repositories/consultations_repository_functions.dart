import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/posts_model.dart';

typedef Future<List<PostsModel>> _StatusCodeInfoChooser();
typedef Future<PostsModel> _StatusCodeInfoChooserr();
typedef Future<int> _StatusCodeInfoChooser2();


class TestRepositoryFunctions {


  Future<Either<Failure, List<PostsModel>>> statusCode(
      _StatusCodeInfoChooser _statusCodeInfoChooser) async {
    try{
    final remotePhysician = await _statusCodeInfoChooser();
    return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }


  Future<Either<Failure, PostsModel>> statusCodee(
      _StatusCodeInfoChooserr _statusCodeInfoChooser) async {
    try{
      final remotePhysician = await _statusCodeInfoChooser();
      return Right(remotePhysician);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure,int>> statusCode2(
      _StatusCodeInfoChooser2 _statusCodeInfoChooser2) async {
    try{
    final remotePhysician = await _statusCodeInfoChooser2();
    return Right(remotePhysician);
  } on ServerException {
  return Left(ServerFailure());
}
  }


}
