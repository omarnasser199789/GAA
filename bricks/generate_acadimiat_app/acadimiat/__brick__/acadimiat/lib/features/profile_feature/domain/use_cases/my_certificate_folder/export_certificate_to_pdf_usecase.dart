import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/profile_repository.dart';
import 'dart:convert';

class ExportCertificateToPDFUseCase implements UseCase<int, ExportCertificatesToPdfParams> {
  final ProfileRepository repository;
  ExportCertificateToPDFUseCase({required this.repository});

  @override
  Future<Either<Failure,int>> call(ExportCertificatesToPdfParams param) {
    return repository.exportCertificateToPDF(param);
  }
}


ExportCertificatesToPdfParams exportCertificatesToPdfParamsFromJson(String str) => ExportCertificatesToPdfParams.fromJson(json.decode(str));

String exportCertificatesToPdfParamsToJson(ExportCertificatesToPdfParams data) => json.encode(data.toJson());

class ExportCertificatesToPdfParams {
  ExportCertificatesToPdfParams({
  required  this.courseId,
  required  this.id,
  required  this.userId,
  required  this.certificateName,
  });

  int courseId;
  int id;
  String userId;
  String certificateName;

  factory ExportCertificatesToPdfParams.fromJson(Map<String, dynamic> json) => ExportCertificatesToPdfParams(
    courseId: json["courseId"],
    id: json["Id"],
    userId: json["userId"],
    certificateName: json["certificateName"],
  );

  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "Id": id,
    "userId": userId,
    "certificateName": certificateName,
  };
}
