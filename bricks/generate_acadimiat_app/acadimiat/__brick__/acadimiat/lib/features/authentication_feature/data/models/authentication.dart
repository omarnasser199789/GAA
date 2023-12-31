import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../../test_feature/data/models/serializers.dart';

part 'authentication.g.dart';

abstract class Authentication implements Built<Authentication, AuthenticationBuilder> {
  String get id;
  String get email;
  String get name;
  String get avatar;
  String get groupId;
  int? get trainerId;
  String get userId;
  String get jwtToken;

  Authentication._();

  factory Authentication([Function(AuthenticationBuilder b) updates ]) = _$Authentication;

  String toJson(){
    return json.encode(serializers.serializeWith(Authentication.serializer, this));
  }

  static Authentication? fromJson(String jsonString){
    return serializers.deserializeWith(
        Authentication.serializer, json.decode(jsonString));
  }

  static Serializer<Authentication> get serializer => _$authenticationSerializer;
}