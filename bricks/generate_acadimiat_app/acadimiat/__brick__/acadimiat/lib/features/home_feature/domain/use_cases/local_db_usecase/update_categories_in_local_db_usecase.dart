import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';
import 'dart:convert';

class UpdateCategoriesInLocalDBUseCase implements UseCase<int, List<UpdateCategoriesParams>> {
  final HomeRepository repository;
  UpdateCategoriesInLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(List<UpdateCategoriesParams> params) {
    return repository.updateCategories(params);
  }
}



List<UpdateCategoriesParams> UpdateCategoriesParamsFromJson(String str) => List<UpdateCategoriesParams>.from(json.decode(str).map((x) => UpdateCategoriesParams.fromJson(x)));

String UpdateCategoriesParamsToJson(List<UpdateCategoriesParams> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateCategoriesParams {
  UpdateCategoriesParams({
    required  this.categoryId,
    required  this.image,
    required  this.name,
    required  this.numberOfCourses,
  });

  int categoryId;
  String image;
  String name;
  int numberOfCourses;


  factory UpdateCategoriesParams.fromJson(Map<String, dynamic> json) => UpdateCategoriesParams(
    categoryId: json["categoryId"],
    image: json["image"],
    name: json["name"],
    numberOfCourses: json["numberOfCourses"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "image": image,
    "name": name,
    "numberOfCourses": numberOfCourses,
  };
}



