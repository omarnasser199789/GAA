
import 'package:equatable/equatable.dart';

class AuthenticateEntity extends Equatable{
 final String email;
 final String userId;

  AuthenticateEntity({
    required this.email,
    required this.userId,
  });

  @override
  List<Object?> get props => [email, userId];

}