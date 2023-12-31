import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/latestP_repository.dart';
import 'dart:convert';

class UpdateConsultanciesInLocalDBUseCase implements UseCase<int, List<UpdateConsultanciesParams>> {
  final HomeRepository repository;
  UpdateConsultanciesInLocalDBUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(List<UpdateConsultanciesParams> params) {
    return repository.updateConsultancies(params);
  }
}



List<UpdateConsultanciesParams> UpdateConsultanciesParamsFromJson(String str) => List<UpdateConsultanciesParams>.from(json.decode(str).map((x) => UpdateConsultanciesParams.fromJson(x)));

String UpdateConsultanciesParamsToJson(List<UpdateConsultanciesParams> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateConsultanciesParams {
  UpdateConsultanciesParams({
    required  this.apiId,
    required  this.image,
    required  this.trainerName,
    required  this.name,
  });

  int apiId;
  String image;
  String trainerName;
  String name;


  factory UpdateConsultanciesParams.fromJson(Map<String, dynamic> json) => UpdateConsultanciesParams(
    apiId: json["apiId"],
    image: json["image"],
    name: json["name"],
    trainerName: json["trainerName"],
  );

  Map<String, dynamic> toJson() => {
    "apiId": apiId,
    "image": image,
    "name": name,
    "trainerName": trainerName,
  };
}



