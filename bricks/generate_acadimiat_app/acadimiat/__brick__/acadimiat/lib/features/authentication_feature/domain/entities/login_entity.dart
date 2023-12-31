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

  String id;
  String email;
  String name;
  String avatar;
  String groupId;
  dynamic trainerId;
  String userId;
  String jwtToken;
  List<MyCourse> myCourses;
  String refreshToken;


}