import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/latestP_repository.dart';

class CheckPurchaseUseCase implements UseCase<int, CheckPurchaseModel> {
  final HomeRepository repository;
  CheckPurchaseUseCase({required this.repository});

  @override
  Future<Either<Failure,  int>> call(CheckPurchaseModel params) {
    return repository.checkPurchase(params);
  }
}


CheckPurchaseModel checkPurchaseModelFromJson(String str) => CheckPurchaseModel.fromJson(json.decode(str));

String checkPurchaseModelToJson(CheckPurchaseModel data) => json.encode(data.toJson());

class CheckPurchaseModel {
  String subscriberId;
  String productId;
  String userId;

  CheckPurchaseModel({
    required this.subscriberId,
    required this.productId,
    required this.userId,
  });

  factory CheckPurchaseModel.fromJson(Map<String, dynamic> json) => CheckPurchaseModel(
    subscriberId: json["subscriberId"],
    productId: json["productId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "subscriberId": subscriberId,
    "productId": productId,
    "userId": userId,
  };
}
