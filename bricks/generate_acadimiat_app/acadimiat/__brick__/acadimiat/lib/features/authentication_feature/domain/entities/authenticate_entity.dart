
import 'package:equatable/equatable.dart';

class AuthenticateEntity extends Equatable{
  String email;
  String userId;

  AuthenticateEntity({
    required this.email,
    required this.userId,
  });

  @override
  List<Object?> get props => [email, userId];

}