import 'package:equatable/equatable.dart';

import '../../data/models/login_model.dart';
class LoginEntity extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

  LoginEntity({
    required  this.id,
    required  this.email,
    required  this.name,
    required  this.avatar,
    required  this.groupId,
    required  this.trainerId,
    required  this.userId,
    required  this.jwtToken,
    required  this.myCourses,
    required  this.refreshToken,
  });

 final String id;
 final String email;
 final String name;
 final String avatar;
 final String groupId;
 final dynamic trainerId;
 final String userId;
 final String jwtToken;
 final List<MyCourse> myCourses;
 final String refreshToken;


}