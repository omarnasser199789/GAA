import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../../test_feature/data/models/serializers.dart';

part 'authentication_service_params.g.dart';

abstract class AuthenticationServiceParams implements Built<AuthenticationServiceParams, AuthenticationServiceParamsBuilder> {
  String get loginName;
  String get password;

  AuthenticationServiceParams._();

  factory AuthenticationServiceParams([Function(AuthenticationServiceParamsBuilder b) updates ]) = _$AuthenticationServiceParams;

  String toJson(){
    return json.encode(serializers.serializeWith(AuthenticationServiceParams.serializer, this));
  }

  static AuthenticationServiceParams? fromJson(String jsonString){
    return serializers.deserializeWith(
        AuthenticationServiceParams.serializer, json.decode(jsonString));
  }

  static Serializer<AuthenticationServiceParams> get serializer => _$authenticationServiceParamsSerializer;
}