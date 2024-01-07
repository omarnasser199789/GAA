import 'dart:convert';
import '../../domain/entities/authenticate_entity.dart';

AuthenticateModel authenticateModelFromJson(String str) =>
    AuthenticateModel.fromJson(json.decode(str));

String authenticateModelToJson(AuthenticateModel data) =>
    json.encode(data.toJson());

class AuthenticateModel extends AuthenticateEntity {
 final String email;
 final String userId;

  AuthenticateModel({
    required this.email,
    required this.userId,
  }) : super(email: email, userId: userId);

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) =>
      AuthenticateModel(
        email: json["email"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userId": userId,
      };
}
