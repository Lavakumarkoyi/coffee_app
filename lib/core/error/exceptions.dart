class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Error occured in Api call"]);
}
