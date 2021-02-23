import 'package:dio/dio.dart';

class AuthException implements Exception {
  final String name;
  final String description;
  final Response<dynamic> response;

  AuthException(
      {this.name = 'a0.response.invalid', this.description = 'unknown error', this.response});


  @override
  String toString() {
    return "$name $description";
  }
}
