import 'package:equatable/equatable.dart';


class UpdateUserInfoEntity extends Equatable {
 final int id;
 final int groupId;
 final int userId;
 final int sex;
 final DateTime dateOfBirth;
 final bool active;
 final String name;
 final String email;
 final String phone;


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

  });

  @override
  List<Object> get props => [id,groupId,userId,sex,dateOfBirth,active,name,email,phone,];
}
