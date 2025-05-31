class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'An error occured. Please try again later']);
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
