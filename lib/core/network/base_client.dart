import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/main.dart';

import 'app_exeptions.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;

  //GET

  Future<dynamic> get(String baseUrl) async {
    var uri = Uri.parse(baseUrl);

    try {
      var response = await http.get(uri, headers: {
        'Authorization': 'token ${prefs!.getString('token')}',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      }) /*.timeout(const Duration(seconds: TIME_OUT_DURATION))*/;
      printInfo(info: uri.toString() + '+ token ${prefs!.getString('token')}');

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Server connection failed', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      throw BadRequestException(
          '{"reason":"your message is incorrect", "reason_code":"invalid_message"}',
          response.request!.url.toString());
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> postWithHeader(
      String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http.post(uri, body: payload, headers: {
        'Authorization': 'token ${prefs!.getString('token')}',
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      throw BadRequestException(
          '{"reason":"your message is incorrect", "reason_code":"invalid_message"}',
          response.request!.url.toString());
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        //print(response.request);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 404:
        throw FetchDataException(
          'Opps! Page Not found',
          response.request!.url.toString(),
        );
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw FetchDataException(
            'Internal Server Error', response.request!.url.toString());
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
