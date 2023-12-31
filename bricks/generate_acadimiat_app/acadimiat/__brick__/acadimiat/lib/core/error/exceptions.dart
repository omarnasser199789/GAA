class ServerException implements Exception {
  // ServerException({this.error});
  // ErrorModel ? error;
}

class CacheException implements Exception {}
class NotActiveSubscription implements Exception {}

class EException implements Exception {
  EException({required this.statusCode});
   int statusCode;
}