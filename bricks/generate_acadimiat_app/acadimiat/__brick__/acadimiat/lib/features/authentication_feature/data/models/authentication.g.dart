// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Authentication> _$authenticationSerializer =
    new _$AuthenticationSerializer();

class _$AuthenticationSerializer
    implements StructuredSerializer<Authentication> {
  @override
  final Iterable<Type> types = const [Authentication, _$Authentication];
  @override
  final String wireName = 'Authentication';

  @override
  Iterable<Object?> serialize(Serializers serializers, Authentication object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'avatar',
      serializers.serialize(object.avatar,
          specifiedType: const FullType(String)),
      'groupId',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'userId',
      serializers.serialize(object.userId,
          specifiedType: const FullType(String)),
      'jwtToken',
      serializers.serialize(object.jwtToken,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.trainerId;
    if (value != null) {
      result
        ..add('trainerId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Authentication deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthenticationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'avatar':
          result.avatar = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'groupId':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'trainerId':
          result.trainerId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'jwtToken':
          result.jwtToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Authentication extends Authentication {
  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String avatar;
  @override
  final String groupId;
  @override
  final int? trainerId;
  @override
  final String userId;
  @override
  final String jwtToken;

  factory _$Authentication([void Function(AuthenticationBuilder)? updates]) =>
      (new AuthenticationBuilder()..update(updates))._build();

  _$Authentication._(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatar,
      required this.groupId,
      this.trainerId,
      required this.userId,
      required this.jwtToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Authentication', 'id');
    BuiltValueNullFieldError.checkNotNull(email, r'Authentication', 'email');
    BuiltValueNullFieldError.checkNotNull(name, r'Authentication', 'name');
    BuiltValueNullFieldError.checkNotNull(avatar, r'Authentication', 'avatar');
    BuiltValueNullFieldError.checkNotNull(
        groupId, r'Authentication', 'groupId');
    BuiltValueNullFieldError.checkNotNull(userId, r'Authentication', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        jwtToken, r'Authentication', 'jwtToken');
  }

  @override
  Authentication rebuild(void Function(AuthenticationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticationBuilder toBuilder() =>
      new AuthenticationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Authentication &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        avatar == other.avatar &&
        groupId == other.groupId &&
        trainerId == other.trainerId &&
        userId == other.userId &&
        jwtToken == other.jwtToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jc(_$hash, groupId.hashCode);
    _$hash = $jc(_$hash, trainerId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, jwtToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Authentication')
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('avatar', avatar)
          ..add('groupId', groupId)
          ..add('trainerId', trainerId)
          ..add('userId', userId)
          ..add('jwtToken', jwtToken))
        .toString();
  }
}

class AuthenticationBuilder
    implements Builder<Authentication, AuthenticationBuilder> {
  _$Authentication? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  String? _groupId;
  String? get groupId => _$this._groupId;
  set groupId(String? groupId) => _$this._groupId = groupId;

  int? _trainerId;
  int? get trainerId => _$this._trainerId;
  set trainerId(int? trainerId) => _$this._trainerId = trainerId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _jwtToken;
  String? get jwtToken => _$this._jwtToken;
  set jwtToken(String? jwtToken) => _$this._jwtToken = jwtToken;

  AuthenticationBuilder();

  AuthenticationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _avatar = $v.avatar;
      _groupId = $v.groupId;
      _trainerId = $v.trainerId;
      _userId = $v.userId;
      _jwtToken = $v.jwtToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Authentication other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Authentication;
  }

  @override
  void update(void Function(AuthenticationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Authentication build() => _build();

  _$Authentication _build() {
    final _$result = _$v ??
        new _$Authentication._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'Authentication', 'id'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'Authentication', 'email'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'Authentication', 'name'),
            avatar: BuiltValueNullFieldError.checkNotNull(
                avatar, r'Authentication', 'avatar'),
            groupId: BuiltValueNullFieldError.checkNotNull(
                groupId, r'Authentication', 'groupId'),
            trainerId: trainerId,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Authentication', 'userId'),
            jwtToken: BuiltValueNullFieldError.checkNotNull(
                jwtToken, r'Authentication', 'jwtToken'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
