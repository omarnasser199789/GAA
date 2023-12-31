import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
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

  UserInfoEntity({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.sex,
    required this.dateOfBirth,
    required this.active,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.notes,
    required this.addedBy,
    required this.addedDate,
    required this.updateAt,
    required this.user,
    required this.group,
    required this.b2Bcourses,
    required this.courses,
    required this.path,
  });

  @override
  List<Object> get props => [id,groupId,userId,sex,dateOfBirth,active,name,email,phone,profileImage,notes,
  addedBy,addedDate,updateAt,user,group,b2Bcourses,courses,path];
}
