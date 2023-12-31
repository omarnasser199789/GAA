// This class represents a JSON serialization/deserialization model for user registration,
// and maps to the `RegisterEntity` entity class defined in the domain layer.
//
// To parse JSON data into an instance of this class, use the `registerModelFromJson` function.
// To encode an instance of this class into a JSON string, use the `registerModelToJson` function.
import 'dart:convert';
import '../../domain/entities/register_entity.dart';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  // The constructor takes in the required parameters for user registration.
  RegisterModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.groupId,
    required this.trainerId,
    required this.userId,
    required this.jwtToken,
    required this.refreshToken,
  });

  // Fields that represent the data associated with a user registration.
  String id;
  String email;
  String name;
  dynamic avatar;
  String groupId;
  dynamic trainerId;
  String userId;
  String jwtToken;
  String refreshToken;

  // The `fromJson` factory method creates an instance of `RegisterModel` from a
  // `Map<String, dynamic>` object, assuming that the keys correspond to the field names.
  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    avatar: (json["avatar"]!=null)?json["avatar"]:"",
    groupId: json["groupId"],
    trainerId:(json["trainerId"]!=null)?json["trainerId"]:"",
    userId: json["userId"],
    jwtToken: json["jwtToken"],
    refreshToken: json["refreshToken"],
  );

  // The `toJson` method converts the `RegisterModel` instance to a `Map<String, dynamic>`
  // object, suitable for encoding as JSON. The keys correspond to the field names.
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "avatar": avatar,
    "groupId": groupId,
    "trainerId": trainerId,
    "userId": userId,
    "jwtToken": jwtToken,
    "refreshToken": refreshToken,
  };
}
