class Auth0UnauthorizedException implements Exception {
  final String message;

  Auth0UnauthorizedException({this.message});

  @override
  String toString() {
    return "Auth0UnauthorizedException($message)";
  }
}
