import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final int id;
  final int groupId;
  final int userId;
  final int sex;
  final String dateOfBirth;
  final bool active;
   String name;
   String email;
   dynamic phone;
  final String profileImage;
  final dynamic notes;
  final int addedBy;
  final String addedDate;
  final String updateAt;
  final dynamic user;
  final dynamic group;
  final dynamic b2Bcourses;
  final dynamic courses;
  final dynamic path;

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
