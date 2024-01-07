// To parse this JSON data, do
//
//     final checkPasswordModel = checkPasswordModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/check_password_entity.dart';


// This function deserializes a JSON string into a `CheckPasswordModel` object.
CheckPasswordModel checkPasswordModelFromJson(String str) => CheckPasswordModel.fromJson(json.decode(str));

// This function serializes a `CheckPasswordModel` object into a JSON string.
String checkPasswordModelToJson(CheckPasswordModel data) => json.encode(data.toJson());


// This class represents a `CheckPasswordModel` model, which contains the result of a password check.
class CheckPasswordModel extends CheckPasswordEntity {
  // The `CheckPasswordModel` constructor takes in the required `result` parameter and initializes the corresponding field.
  CheckPasswordModel({
    required this.result,
  }):super(
      result: result
  );

  // Field that represents the password check result.
  final String result;

  // The `fromJson` factory method creates an instance of `CheckPasswordModel` from a
  // `Map<String, dynamic>` object, assuming that the keys correspond to the field names.
  factory CheckPasswordModel.fromJson(Map<String, dynamic> json) => CheckPasswordModel(
    result: json["result"],
  );

  // The `toJson` method converts the `CheckPasswordModel` instance to a `Map<String, dynamic>`
  // object, suitable for encoding as JSON. The keys correspond to the field names.
  Map<String, dynamic> toJson() => {
    "result": result,
  };
}
