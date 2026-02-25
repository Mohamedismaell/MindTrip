class NoInternetException implements Exception {
  final String message;
  const NoInternetException([this.message = 'No internet connection']);
}
