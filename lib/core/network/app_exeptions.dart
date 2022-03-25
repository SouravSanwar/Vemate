import 'package:flutter/cupertino.dart';

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;
  final IconData? iconData;

  AppException([this.message, this.prefix, this.url,this.iconData]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url,IconData? iconData])
      : super(message, 'Unable to process', url,iconData);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized request', url);
}
