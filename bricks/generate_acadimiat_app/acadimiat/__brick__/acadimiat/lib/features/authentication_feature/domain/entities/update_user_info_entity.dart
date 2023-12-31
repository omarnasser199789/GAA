// import 'package:emastery/feature/profile_feature/data/models/update_user_mode_info.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/update_user_mode_info.dart';

class UpdateUserInfoEntity extends Equatable {
  int id;
  int groupId;
  int userId;
  int sex;
  DateTime dateOfBirth;
  bool active;
  String name;
  String email;
  String phone;
  // String profileImage;
  // String notes;
  // int addedBy;
  // DateTime addedDate;
  // DateTime updateAt;
  // User_ user;
  // dynamic group;
  // dynamic b2Bcourses;
  // dynamic courses;
  // dynamic path;

  UpdateUserInfoEntity({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.sex,
    required this.dateOfBirth,
    required this.active,
    required this.name,
    required this.email,
    required this.phone,
    // required this.profileImage,
    // required this.notes,
    // required this.addedBy,
    // required this.addedDate,
    // required this.updateAt,
    // required this.user,
    // required this.group,
    // required this.b2Bcourses,
    // required this.courses,
    // required this.path,
  });

  @override
  // TODO: implement props
  List<Object> get props => [id,groupId,userId
    ,sex,dateOfBirth,active,name,email,phone,
    // profileImage,notes,
  //   addedBy,
  // addedDate,updateAt,
    // user,
    // group,b2Bcourses,courses,path
  ];
}
