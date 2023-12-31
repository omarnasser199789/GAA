class Response {
  int _statusCode;
  dynamic _object;

  Response(this._statusCode, this._object);

  dynamic get object => _object;

  set object(dynamic value) {
    _object = value;
  }

  int get statusCode => _statusCode;

  set statusCode(int value) {
    _statusCode = value;
  }
}