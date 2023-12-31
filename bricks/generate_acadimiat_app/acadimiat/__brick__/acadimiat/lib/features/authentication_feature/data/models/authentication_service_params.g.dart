// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_service_params.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthenticationServiceParams>
    _$authenticationServiceParamsSerializer =
    new _$AuthenticationServiceParamsSerializer();

class _$AuthenticationServiceParamsSerializer
    implements StructuredSerializer<AuthenticationServiceParams> {
  @override
  final Iterable<Type> types = const [
    AuthenticationServiceParams,
    _$AuthenticationServiceParams
  ];
  @override
  final String wireName = 'AuthenticationServiceParams';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AuthenticationServiceParams object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'loginName',
      serializers.serialize(object.loginName,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  AuthenticationServiceParams deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthenticationServiceParamsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'loginName':
          result.loginName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthenticationServiceParams extends AuthenticationServiceParams {
  @override
  final String loginName;
  @override
  final String password;

  factory _$AuthenticationServiceParams(
          [void Function(AuthenticationServiceParamsBuilder)? updates]) =>
      (new AuthenticationServiceParamsBuilder()..update(updates))._build();

  _$AuthenticationServiceParams._(
      {required this.loginName, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loginName, r'AuthenticationServiceParams', 'loginName');
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthenticationServiceParams', 'password');
  }

  @override
  AuthenticationServiceParams rebuild(
          void Function(AuthenticationServiceParamsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticationServiceParamsBuilder toBuilder() =>
      new AuthenticationServiceParamsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthenticationServiceParams &&
        loginName == other.loginName &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, loginName.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthenticationServiceParams')
          ..add('loginName', loginName)
          ..add('password', password))
        .toString();
  }
}

class AuthenticationServiceParamsBuilder
    implements
        Builder<AuthenticationServiceParams,
            AuthenticationServiceParamsBuilder> {
  _$AuthenticationServiceParams? _$v;

  String? _loginName;
  String? get loginName => _$this._loginName;
  set loginName(String? loginName) => _$this._loginName = loginName;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AuthenticationServiceParamsBuilder();

  AuthenticationServiceParamsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loginName = $v.loginName;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthenticationServiceParams other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthenticationServiceParams;
  }

  @override
  void update(void Function(AuthenticationServiceParamsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthenticationServiceParams build() => _build();

  _$AuthenticationServiceParams _build() {
    final _$result = _$v ??
        new _$AuthenticationServiceParams._(
            loginName: BuiltValueNullFieldError.checkNotNull(
                loginName, r'AuthenticationServiceParams', 'loginName'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'AuthenticationServiceParams', 'password'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
