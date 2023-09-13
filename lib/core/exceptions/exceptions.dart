class PrimaryServerException implements Exception {
  final String message;

  PrimaryServerException({
    required this.message,
  });
}

class ServerException implements Exception {}

class OfflineException implements Exception {}
