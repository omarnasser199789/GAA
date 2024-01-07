import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../data/models/my_courses_model.dart';
import '../../repositories/consultations_repository.dart';
import 'dart:convert';

class UpdateMyCoursesInLocalDBUseCase implements UseCase< int, List<MyCoursesModel>> {
  final MyCoursesRepository repository;
  UpdateMyCoursesInLocalDBUseCase({required this.repository});
  @override
  Future<Either<Failure, int>> call(List<MyCoursesModel> params) {

    return repository.updateMyCourses(params);
  }
}



List<UpdateMyCoursesParams> UpdateMyCoursesParamsFromJson(String str) => List<UpdateMyCoursesParams>.from(json.decode(str).map((x) => UpdateMyCoursesParams.fromJson(x)));

String UpdateMyCoursesParamsToJson(List<UpdateMyCoursesParams> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateMyCoursesParams {
  UpdateMyCoursesParams({
    required  this.apiId,
    required  this.image,
    required  this.name,
    required this.percent,
  });

 final int apiId;
 final String image;
 final String name;
 final int percent;


  factory UpdateMyCoursesParams.fromJson(Map<String, dynamic> json) => UpdateMyCoursesParams(
    apiId: json["apiId"],
    image: json["image"],
    name: json["name"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "name": name,
    "percent": percent,
  };
}

