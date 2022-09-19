import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/main.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../utilities/app_colors/app_colors.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class PostFile extends ChangeNotifier {
  http.MultipartRequest? request;
  var result;
  static Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  Future requestWithTwoFiles(BuildContext context,
      {@required String? url,
      Map<String, String>? body,
      List<String>? fileKey,
      List<File>? files,
      List<String>? fileKey1,
      List<File>? files1,
      Method method = Method.POST}) async {
    var uri = Uri.parse(url!);

    if (method == Method.POST) {
      request = http.MultipartRequest("POST", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
    }
    if (method == Method.PUT) {
      request = http.MultipartRequest("PUT", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
    } else if (method == Method.PATCH) {
      request = http.MultipartRequest("PATCH", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
    } else if (method == Method.PATCH) {
      request = http.MultipartRequest("PATCH", uri)
        ..headers.addAll(requestHeadersWithToken)
        ..fields.addAll(body!);
    }

    for (int i = 0; i < fileKey!.length; i++) {
      var stream =
          http.ByteStream(DelegatingStream.typed(files![i].openRead()));
      var length = await files[i].length();
      var multipartFile = http.MultipartFile(fileKey[i], stream, length,
          filename: basename(files[i].path));
      request!.files.add(multipartFile);
    }

    for (int i = 0; i < fileKey1!.length; i++) {
      var stream =
          http.ByteStream(DelegatingStream.typed(files1![i].openRead()));
      var length = await files1[i].length();
      var multipartFile = http.MultipartFile(fileKey1[i], stream, length,
          filename: basename(files1[i].path));
      request!.files.add(multipartFile);
    }
    try {
      var response = await request!.send();
      if (response.statusCode == 200 ||
          response.statusCode == 401 ||
          response.statusCode == 422 ||
          response.statusCode == 500) {
        response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        });
        showData(
            url: url, body: body, method: method, response: result.toString());
        return json.decode(result);
      } else if (response.statusCode == 413) {
        print('Big File');

        print(response);

        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              'File too large',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);

        return {'error': 'file_too_large'};
      } else {
        return {'error': 'something_went_wrong'};
      }
    } catch (e) {
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            'check your internet connection',
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);

      return {'error': 'check_your_internet_connection'};
    }
  }

  Future requestWithFile(BuildContext context,
      {@required String? url,
      Map<String, String>? body,
      List<String>? fileKey,
      List<File>? files,
      Method method = Method.POST}) async {
    print("paise                  paise");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Uploading Profile Picture",
            ));
    print('New Body: $body');
    //bool loading = false;
    var uri = Uri.parse(url!);
    if (method == Method.POST) {
      request = http.MultipartRequest("POST", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
      //loading = true;
    }
    if (method == Method.PUT) {
      request = http.MultipartRequest("PUT", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
    } else if (method == Method.PATCH) {
      request = http.MultipartRequest("PATCH", uri)
        ..fields.addAll(body!)
        ..headers.addAll(requestHeadersWithToken);
    } else if (method == Method.PATCH) {
      request = http.MultipartRequest("PATCH", uri)
        ..headers.addAll(requestHeadersWithToken)
        ..fields.addAll(body!);
    }

    for (int i = 0; i < fileKey!.length; i++) {
      var stream =
          http.ByteStream(DelegatingStream.typed(files![i].openRead()));
      var length = await files[i].length();
      var multipartFile = http.MultipartFile(fileKey[i], stream, length,
          filename: basename(files[i].path));
      request!.files.add(multipartFile);
    }
    try {
      var response = await request!.send();
      if (response.statusCode == 200 ||
          response.statusCode == 401 ||
          response.statusCode == 422 ||
          response.statusCode == 500) {
        response.stream.transform(utf8.decoder).listen((value) {
          result = value;
        });
        showData(
            url: url, body: body, method: method, response: result.toString());

        Navigator.of(context).pop();
        Map<String, String> requestToken = {
          'Authorization': 'token ${prefs!.getString('token')}',
        };

        var getData = Provider.of<GetData>(context, listen: false);
        await getData.getUserInfo();



        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) =>  ResponseMessage(
              icon: Icons.check_circle,
              color: AppColors.primaryColor,
              message: "Image Updated Successfully",
            ));

      } else if (response.statusCode == 413) {
        print('Big File');

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) =>  const ResponseMessage(
              icon: Icons.file_copy_outlined,
              color: Colors.purpleAccent,
              message: "File is too Large",
            ));

        return {'error': 'file_too_large'};
      } else {
        return {'error': 'something_went_wrong'};
      }
    } catch (e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) =>  const ResponseMessage(
            icon: Icons.wifi,
            color: Colors.purpleAccent,
            message: "Please Check Your Internet",
          ));

      return {'error': 'check_your_internet_connection'};
    }
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();

    notifyListeners();
  }

  static void showData(
      {String? url, var body, String? response, Method? method}) {
    if (!kReleaseMode) {
      print("URL = $url");
      print("Body = $body");
      print("Method = $method");
      print("Response = $response");
      print("token = ${prefs!.getString('token')}");
    }
  }
}
