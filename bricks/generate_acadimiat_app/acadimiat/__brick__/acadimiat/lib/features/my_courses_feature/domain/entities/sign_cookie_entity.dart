
import 'package:acadmiat/features/my_courses_feature/data/models/sign_cookie_model.dart';
import 'package:equatable/equatable.dart';

class SignCookieEntity extends Equatable {
  final Cookie cookie;



  SignCookieEntity({required this.cookie});

  @override
  List<Object> get props =>[cookie];
}


