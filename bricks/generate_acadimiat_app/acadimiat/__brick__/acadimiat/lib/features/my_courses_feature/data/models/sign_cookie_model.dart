import 'dart:convert';
import '../../domain/entities/sign_cookie_entity.dart';

SignCookieModel signCookieModelFromJson(String str) => SignCookieModel.fromJson(json.decode(str));

String signCookieModelToJson(SignCookieModel data) => json.encode(data.toJson());

class SignCookieModel extends SignCookieEntity{
  SignCookieModel({
    required this.cookie,
  }):super(cookie:cookie);

  final Cookie cookie;

  factory SignCookieModel.fromJson(Map<String, dynamic> json) => SignCookieModel(cookie: Cookie.fromJson(json["cookie"]));

  Map<String, dynamic> toJson() => {"cookie": cookie.toJson()};
}
class Cookie {
  Cookie({
    this.policy,
    this.keyPairId,
    this.signature,
  });

  KeyPairId? policy;
  KeyPairId? keyPairId;
  KeyPairId? signature;

  factory Cookie.fromJson(Map<String, dynamic> json) => Cookie(
    policy: KeyPairId.fromJson(json["policy"]),
    keyPairId: KeyPairId.fromJson(json["keyPairId"]),
    signature: KeyPairId.fromJson(json["signature"]),
  );

  Map<String, dynamic> toJson() => {
    "policy": policy!.toJson(),
    "keyPairId": keyPairId!.toJson(),
    "signature": signature!.toJson(),
  };
}

class KeyPairId {
  KeyPairId({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory KeyPairId.fromJson(Map<String, dynamic> json) => KeyPairId(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}