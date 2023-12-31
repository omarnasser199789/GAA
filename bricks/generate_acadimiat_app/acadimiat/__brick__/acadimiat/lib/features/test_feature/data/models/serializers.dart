import 'package:acadmiat/features/test_feature/data/models/built_user.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../../../authentication_feature/data/models/authentication.dart';
import '../../../authentication_feature/data/models/authentication_service_params.dart';
import 'built_post.dart';
import 'built_vehicle.dart';

part 'serializers.g.dart';

@SerializersFor( [
  BuiltPost,
  BuiltUser,
  AuthenticationServiceParams,
  BuiltVehicle,
  VehicleType,
  Authentication,
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
