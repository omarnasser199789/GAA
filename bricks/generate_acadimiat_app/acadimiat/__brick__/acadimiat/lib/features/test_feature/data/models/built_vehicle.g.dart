// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_vehicle;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VehicleType _$car = const VehicleType._('car');
const VehicleType _$motorbike = const VehicleType._('motorbike');
const VehicleType _$train = const VehicleType._('train');
const VehicleType _$plane = const VehicleType._('plane');

VehicleType _$valueOf(String name) {
  switch (name) {
    case 'car':
      return _$car;
    case 'motorbike':
      return _$motorbike;
    case 'train':
      return _$train;
    case 'plane':
      return _$plane;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<VehicleType> _$values =
    new BuiltSet<VehicleType>(const <VehicleType>[
  _$car,
  _$motorbike,
  _$train,
  _$plane,
]);

Serializer<BuiltVehicle> _$builtVehicleSerializer =
    new _$BuiltVehicleSerializer();
Serializer<VehicleType> _$vehicleTypeSerializer = new _$VehicleTypeSerializer();

class _$BuiltVehicleSerializer implements StructuredSerializer<BuiltVehicle> {
  @override
  final Iterable<Type> types = const [BuiltVehicle, _$BuiltVehicle];
  @override
  final String wireName = 'BuiltVehicle';

  @override
  Iterable<Object?> serialize(Serializers serializers, BuiltVehicle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(VehicleType)),
      'brand',
      serializers.serialize(object.brand,
          specifiedType: const FullType(String)),
      'price',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
    ];
    Object? value;
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltUser)));
    }
    value = object.someNullableValue;
    if (value != null) {
      result
        ..add('someNullableValue')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  BuiltVehicle deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltVehicleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltUser))! as BuiltUser);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(VehicleType))! as VehicleType;
          break;
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'someNullableValue':
          result.someNullableValue = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$VehicleTypeSerializer implements PrimitiveSerializer<VehicleType> {
  @override
  final Iterable<Type> types = const <Type>[VehicleType];
  @override
  final String wireName = 'VehicleType';

  @override
  Object serialize(Serializers serializers, VehicleType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  VehicleType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      VehicleType.valueOf(serialized as String);
}

class _$BuiltVehicle extends BuiltVehicle {
  @override
  final BuiltUser? user;
  @override
  final VehicleType type;
  @override
  final String brand;
  @override
  final double price;
  @override
  final bool? someNullableValue;

  factory _$BuiltVehicle([void Function(BuiltVehicleBuilder)? updates]) =>
      (new BuiltVehicleBuilder()..update(updates))._build();

  _$BuiltVehicle._(
      {this.user,
      required this.type,
      required this.brand,
      required this.price,
      this.someNullableValue})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'BuiltVehicle', 'type');
    BuiltValueNullFieldError.checkNotNull(brand, r'BuiltVehicle', 'brand');
    BuiltValueNullFieldError.checkNotNull(price, r'BuiltVehicle', 'price');
  }

  @override
  BuiltVehicle rebuild(void Function(BuiltVehicleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltVehicleBuilder toBuilder() => new BuiltVehicleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltVehicle &&
        user == other.user &&
        type == other.type &&
        brand == other.brand &&
        price == other.price &&
        someNullableValue == other.someNullableValue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, someNullableValue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BuiltVehicle')
          ..add('user', user)
          ..add('type', type)
          ..add('brand', brand)
          ..add('price', price)
          ..add('someNullableValue', someNullableValue))
        .toString();
  }
}

class BuiltVehicleBuilder
    implements Builder<BuiltVehicle, BuiltVehicleBuilder> {
  _$BuiltVehicle? _$v;

  BuiltUserBuilder? _user;
  BuiltUserBuilder get user => _$this._user ??= new BuiltUserBuilder();
  set user(BuiltUserBuilder? user) => _$this._user = user;

  VehicleType? _type;
  VehicleType? get type => _$this._type;
  set type(VehicleType? type) => _$this._type = type;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  bool? _someNullableValue;
  bool? get someNullableValue => _$this._someNullableValue;
  set someNullableValue(bool? someNullableValue) =>
      _$this._someNullableValue = someNullableValue;

  BuiltVehicleBuilder();

  BuiltVehicleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user?.toBuilder();
      _type = $v.type;
      _brand = $v.brand;
      _price = $v.price;
      _someNullableValue = $v.someNullableValue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltVehicle other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BuiltVehicle;
  }

  @override
  void update(void Function(BuiltVehicleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BuiltVehicle build() => _build();

  _$BuiltVehicle _build() {
    _$BuiltVehicle _$result;
    try {
      _$result = _$v ??
          new _$BuiltVehicle._(
              user: _user?.build(),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'BuiltVehicle', 'type'),
              brand: BuiltValueNullFieldError.checkNotNull(
                  brand, r'BuiltVehicle', 'brand'),
              price: BuiltValueNullFieldError.checkNotNull(
                  price, r'BuiltVehicle', 'price'),
              someNullableValue: someNullableValue);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'BuiltVehicle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
