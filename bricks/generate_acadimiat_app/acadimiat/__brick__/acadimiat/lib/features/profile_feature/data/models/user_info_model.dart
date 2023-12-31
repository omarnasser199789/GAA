// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/user_info_entity.dart';


UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel extends UserInfoEntity{
    UserInfoModel({
      required  this.id,
      required  this.groupId,
      required  this.userId,
      required  this.sex,
      required  this.dateOfBirth,
      required  this.active,
      required  this.name,
      required  this.email,
      required  this.phone,
      required  this.profileImage,
      required  this.notes,
      required  this.addedBy,
      required  this.addedDate,
      required  this.updateAt,
      required  this.user,
      required  this.group,
      required  this.b2Bcourses,
      required  this.courses,
      required  this.path,
    }):super(id: id,group: group,userId: userId,groupId: groupId,sex: sex,dateOfBirth: dateOfBirth,active: active,
    name: name,email: email,phone: phone,profileImage: profileImage,notes: notes,addedBy: addedBy,addedDate: addedDate,
    updateAt: updateAt,user: user,b2Bcourses: b2Bcourses,courses: courses,path: path);

    int id;
    int groupId;
    int userId;
    int sex;
    String dateOfBirth;
    bool active;
    String name;
    String email;
    dynamic phone;
    String profileImage;
    dynamic notes;
    int addedBy;
    String addedDate;
    String updateAt;
    dynamic user;
    dynamic group;
    dynamic b2Bcourses;
    dynamic courses;
    dynamic path;

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: (json["id"]!=null)?json["id"]:-1,
        groupId: (json["groupId"]!=null)?json["groupId"]:-1,
        userId: (json["userId"]!=null)?json["userId"]:-1,
        sex: (json["sex"]!=null)?json["sex"]:-1,
        dateOfBirth:( json["dateOfBirth"]!=null)? json["dateOfBirth"]:"",
        active: (json["active"]!=null)?json["active"]:false,
        name: (json["name"]!=null)?json["name"]:"",
        email:( json["email"]!=null)? json["email"]:"",
        phone: (json["phone"]!=null)?json["phone"]:"",
        profileImage: (json["profileImage"]!=null)?json["profileImage"]:"",
        notes: (json["notes"]!=null)?json["notes"]:"",
        addedBy: (json["addedBy"]!=null)?json["addedBy"]:-1,
        addedDate: (json["addedDate"]!=null)?json["addedDate"]:"",
        updateAt: (json["updateAt"]!=null)?json["updateAt"]:"",
        user: json["user"],
        group: json["group"],
        b2Bcourses: json["b2bcourses"],
        courses: json["courses"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "userId": userId,
        "sex": sex,
        "dateOfBirth": dateOfBirth,
        "active": active,
        "name": name,
        "email": email,
        "phone": phone,
        "profileImage": profileImage,
        "notes": notes,
        "addedBy": addedBy,
        "addedDate": addedDate,
        "updateAt": updateAt,
        "user": user,
        "group": group,
        "b2bcourses": b2Bcourses,
        "courses": courses,
        "path": path,
    };
}
