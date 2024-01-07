// To parse this JSON data, do
//
//     final updateUserInfoModel = updateUserInfoModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/update_user_info_entity.dart';

// This function takes a JSON string 'str' as input, decodes it using `json.decode`,
// and returns an instance of `UpdateUserInfoModel` by calling its `fromJson` method.
// Assumes that the `UpdateUserInfoModel` class has a `fromJson` method that takes
// a `Map<String, dynamic>` as input and returns an instance of the class.
UpdateUserInfoModel updateUserInfoModelFromJson(String str) => UpdateUserInfoModel.fromJson(json.decode(str));

// This function takes an instance of the `UpdateUserInfoModel` class `data` as input,
// calls its `toJson` method to get a `Map<String, dynamic>` representation of the object,
// and returns a JSON-encoded string using `json.encode`.
// Assumes that the `UpdateUserInfoModel` class has a `toJson` method that returns
// a `Map<String, dynamic>` representation of the object.
String updateUserInfoModelToJson(UpdateUserInfoModel data) => json.encode(data.toJson());

// This class represents an update to the user information, and extends the
// `UpdateUserInfoEntity` class which defines the common fields for user updates.
class UpdateUserInfoModel extends UpdateUserInfoEntity {
  // The constructor takes in the required parameters for an update to the user information,
  // and calls the superclass constructor with the same parameters to initialize the common fields.
  UpdateUserInfoModel({
    required  this.id,
    required  this.groupId,
    required  this.userId,
    required  this.sex,
    required  this.dateOfBirth,
    required  this.active,
    required  this.name,
    required  this.email,
    required  this.phone,

  }):super(id: id,groupId: groupId,userId: userId,
    sex: sex,dateOfBirth: dateOfBirth,
    active: active,name: name,email: email,phone: phone,
  );

  // Fields that represent the specific information to update for a user.
 final int id;
 final int groupId;
 final int userId;
 final int sex;
 final DateTime dateOfBirth;
 final bool active;
 final String name;
 final String email;
 final String phone;

  // The `fromJson` factory method creates an instance of `UpdateUserInfoModel` from a
  // `Map<String, dynamic>` object, assuming that the keys correspond to the field names.
  factory UpdateUserInfoModel.fromJson(Map<String, dynamic> json) => UpdateUserInfoModel(
    id: (json["id"]!=null)?json["id"]:-1,
    groupId:( json["groupId"]!=null)? json["groupId"]:-1,
    userId: (json["userId"]!=null)?json["userId"]:-1,
    sex: (json["sex"]!=null)?json["sex"]:0,
    dateOfBirth: (json["dateOfBirth"]!=null)?DateTime.parse(json["dateOfBirth"]):DateTime.now(),
    active:( json["active"]!=null)? json["active"]:false,
    name: (json["name"]!=null)?json["name"]:"",
    email: (json["email"]!=null)?json["email"]:"",
    phone: (json["phone"]!=null)?json["phone"]:"",

  );

  // The `toJson` method converts the `UpdateUserInfoModel` instance to a `Map<String, dynamic>`
  // object, suitable for encoding as JSON. The keys correspond to the field names, and the
  // `dateOfBirth` field is converted to an ISO 8601 string representation.
  Map<String, dynamic> toJson() => {
    "id": id,
    "groupId": groupId,
    "userId": userId,
    "sex": sex,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "active": active,
    "name": name,
    "email": email,
    "phone": phone,

  };
}

