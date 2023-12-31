import 'package:acadmiat/features/authentication_feature/data/models/authentication_service_params.dart';
import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import '../../../../../core/globals.dart';
import '../../../../test_feature/data/data_sources/built_value_converter.dart';
import '../../models/authentication.dart';



part 'authentication_service.chopper.dart';

@ChopperApi(baseUrl: '/account/authenticate')
abstract class AuthenticationService extends ChopperService {
  @Post()
  Future<Response<Authentication>> login( @Body() AuthenticationServiceParams body,);


  static AuthenticationService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [
        _$AuthenticationService(),
      ],
      // converter: JsonConverter(),
      converter: BuiltValueConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    return _$AuthenticationService(client);
  }
}
