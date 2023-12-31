import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';
import 'dart:convert';

class UpdateDiplomasAndPackagesInLocaleDBUseCase implements UseCase<int, List<UpdateDiplomasAndPackagesParams>> {
  final HomeRepository repository;
  UpdateDiplomasAndPackagesInLocaleDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(List<UpdateDiplomasAndPackagesParams> params) {
    return repository.updateDiplomasAndPackages(params);
  }
}



List<UpdateDiplomasAndPackagesParams> updateDiplomasAndPackagesParamsFromJson(String str) => List<UpdateDiplomasAndPackagesParams>.from(json.decode(str).map((x) => UpdateDiplomasAndPackagesParams.fromJson(x)));

String updateDiplomasAndPackagesParamsToJson(List<UpdateDiplomasAndPackagesParams> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateDiplomasAndPackagesParams {
  UpdateDiplomasAndPackagesParams({
  required  this.apiId,
  required  this.image,
  required  this.courseName,
  required  this.trainerName,
  required  this.newPrice,
  required  this.oldPrice,
  required  this.fav,
    required this.isCourse,
    required this.numberOfCourses,
  });

  int apiId;
  String image;
  String courseName;
  String trainerName;
  double newPrice;
  double oldPrice;
  int fav;
  int isCourse;
  int numberOfCourses;

  factory UpdateDiplomasAndPackagesParams.fromJson(Map<String, dynamic> json) => UpdateDiplomasAndPackagesParams(
    apiId: json["apiId"],
    image: json["image"],
    courseName: json["courseName"],
    trainerName: json["trainerName"],
    newPrice: json["newPrice"].toDouble(),
    oldPrice: json["oldPrice"].toDouble(),
    fav: json["fav"],
    isCourse: json["isCourse"],
    numberOfCourses: json["numberOfCourses"],
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "courseName": courseName,
    "trainerName": trainerName,
    "newPrice": newPrice,
    "oldPrice": oldPrice,
    "fav": fav,
    "isCourse": isCourse,
    "numberOfCourses": numberOfCourses,
  };
}



