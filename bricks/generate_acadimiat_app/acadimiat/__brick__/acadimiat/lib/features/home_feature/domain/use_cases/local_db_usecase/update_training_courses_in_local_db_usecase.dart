import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';
import 'dart:convert';

class UpdateTrainingCoursesInLocaleDBUseCase implements UseCase<int, List<UpdateTrainingCoursesParams>> {
  final HomeRepository repository;
  UpdateTrainingCoursesInLocaleDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(List<UpdateTrainingCoursesParams> params) {
    return repository.updateTrainingCourses(params);
  }
}



List<UpdateTrainingCoursesParams> UpdateTrainingCoursesParamsFromJson(String str) => List<UpdateTrainingCoursesParams>.from(json.decode(str).map((x) => UpdateTrainingCoursesParams.fromJson(x)));

String UpdateTrainingCoursesParamsToJson(List<UpdateTrainingCoursesParams> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateTrainingCoursesParams {
  UpdateTrainingCoursesParams({
    required  this.apiId,
    required  this.image,
    required  this.courseName,
    required  this.trainerName,
    required  this.newPrice,
    required  this.oldPrice,
    required  this.fav,

  });

  int apiId;
  String image;
  String courseName;
  String trainerName;
  double newPrice;
  double oldPrice;
  int fav;

  factory UpdateTrainingCoursesParams.fromJson(Map<String, dynamic> json) => UpdateTrainingCoursesParams(
    apiId: json["apiId"],
    image: json["image"],
    courseName: json["courseName"],
    trainerName: json["trainerName"],
    newPrice: json["newPrice"].toDouble(),
    oldPrice: json["oldPrice"].toDouble(),
    fav: json["fav"]
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "courseName": courseName,
    "trainerName": trainerName,
    "newPrice": newPrice,
    "oldPrice": oldPrice,
    "fav": fav
  };
}



