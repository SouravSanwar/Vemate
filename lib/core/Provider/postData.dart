import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/sign_in_2fa.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/verify_2fa.dart';
import 'package:ketemaa/features/auth/verification/otpPage.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostData extends ChangeNotifier {
  GetData? getData;
  PostData? postData;
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };
  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  Future signUp(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.signUp),
        body: json.encode(body), headers: requestHeaders);

    var x = json.decode(response.body);

    printInfo(info: x.toString());

    Map<String, dynamic> js = x;
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        if (js.containsKey('id')) {
          prefs = await SharedPreferences.getInstance();
          prefs!.setString(
              'is_email_verified', js['is_email_verified'].toString());
          prefs!.setString('email', js['email'].toString());

          printInfo(info: prefs!.getString('is_email_verified').toString());

          Get.to(() => OtpPage());

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Registration Successful",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        } else {
          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        }
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: Text(
            js.toString(),
            style: const TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future verifyCode(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.verifyCode),
        body: json.encode(body), headers: requestHeaders);

    var x = json.decode(response.body);

    //printInfo(info: response.body.toString());

    Map<String, dynamic> js = x;

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Get.to(() => const AuthInitialPage());
      try {
        /*if (x['code'] == 'True') {

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: Text(
                x['message'],
                style: const TextStyle(fontSize: 16.0, color: Colors.green),
              ))
            .show(context);
        } else {
          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              ))
            .show(context);
        }*/
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
        return response.body;
      }
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: Text(
            js['code'].toString() ,
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
  }

  Future forgotPassword(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.forgotPass),
        body: json.encode(body), headers: requestHeaders);

    //var x = json.decode(response.body);

    printInfo(info: response.body.toString());

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Get.to(() => const AuthInitialPage());
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          title: "Password Updated",
          messageText: const Text(
            "Please Login Again",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      Map<String, dynamic> js = json.decode(response.body);
      Navigator.of(context).pop();
      js.containsKey('password')
          ? Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 5),
              messageText: Text(
                js['password'][0].toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context)
          : (js.containsKey('code')
              ? Flushbar(
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  isDismissible: false,
                  duration: const Duration(seconds: 5),
                  messageText: Text(
                    js['code'][0].toString(),
                    style: const TextStyle(fontSize: 16.0, color: Colors.green),
                  )).show(context)
              : Flushbar(
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  isDismissible: false,
                  duration: const Duration(seconds: 5),
                  messageText: Text(
                    js['email'][0].toString(),
                    style: const TextStyle(fontSize: 16.0, color: Colors.green),
                  )).show(context));
    }
  }

  Future resendCode(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.resendCode),
        body: json.encode(body), headers: requestHeaders);

    /*var x = json.decode(response.body);

    printInfo(info: response.body.toString());*/

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Code send successfully",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      printInfo(info: 'From else');
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
  }

  Future logIn(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());
    Map<String, dynamic> js;

    final response = await http.post(Uri.parse(Urls.logIn),
        body: json.encode(body), headers: requestHeaders);
    print(response.body.toString());
    var x = json.decode(response.body);

    js = x;

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        if (js['is_email_verified'] == true) {
          prefs = await SharedPreferences.getInstance();
          prefs!.setString('email', js['email'].toString());
          var body = {
            "email": js['email'].toString(),
            "reason": "verify",
          };

          postData = Provider.of<PostData>(context, listen: false);

          js['is_2fa'] == true
              ? postData!
                  .resendCode(context, body)
                  .whenComplete(() => Get.to(() => const SignIn2FA()))
              : Store(js, context);

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Login Successful",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        } else {
          prefs!.setString('email', js['email'].toString());

          var body = {
            "email": js['email'].toString(),
            "reason": "verify",
          };
          postData = Provider.of<PostData>(context, listen: false);
          postData!
              .resendCode(context, body)
              .whenComplete(() => Get.to(() => OtpPage()));
          /*Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);*/
        }
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    } else {
      Navigator.of(context).pop();
      if (js['username'] == null) {
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: Text(
              js['password'].toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      } else {
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: Text(
              js['username'].toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    }
    notifyListeners();
  }

  Future logInWith2FA(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());
    printInfo(info: Urls.logInWith2FA.toString());

    final response = await http.post(Uri.parse(Urls.logInWith2FA),
        body: json.encode(body), headers: requestHeaders);
    var x = json.decode(response.body);

    printInfo(info: x);

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        Map<String, dynamic> js = x;
        if (js['is_email_verified'] == true) {
          prefs = await SharedPreferences.getInstance();
          Store(js, context);

          //Get.to(() => ControllerPage());

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Login Successful",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        } else {
          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        }
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future updateProfile(
      BuildContext context, var body, var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.patch(Uri.parse(Urls.updateUserInfo),
        body: json.encode(body), headers: requestHeadersWithToken);
    print(response.body.toString());
    print(requestHeadersWithToken.toString());
    var x = json.decode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        Map<String, dynamic> js = x;
        if (js['is_email_verified'] == true) {
          getData = Provider.of<GetData>(context, listen: false);
          await getData!.getUserInfo();
          prefs = await SharedPreferences.getInstance();

          prefs!.setString('name', js['name'].toString());
          prefs!.setString('email', js['email'].toString());

          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Update Successful",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        } else {
          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        }
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future enDe2FA(BuildContext context, var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    final response = await http.post(Uri.parse(Urls.check2FA),
        headers: requestHeadersWithToken);
    printInfo(info: requestHeadersWithToken.toString());
    var x = json.decode(response.body);
    printInfo(info: x.toString());

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        Map<String, dynamic> js = x;
        if (js.containsKey('status_2fa')) {
          getData = Provider.of<GetData>(context, listen: false);
          await getData!.getUserInfo();

          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: Text(
                js['msg'].toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        } else {
          Navigator.of(context).pop();

          Flushbar(
              flushbarPosition: FlushbarPosition.BOTTOM,
              isDismissible: false,
              duration: const Duration(seconds: 3),
              messageText: const Text(
                "Invalid Information",
                style: TextStyle(fontSize: 16.0, color: Colors.green),
              )).show(context);
        }
      } catch (e) {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: const Duration(seconds: 3),
            messageText: const Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            )).show(context);
      }
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future addToWishlist(BuildContext context, var body, int? id,
      var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.commonStorage),
        body: json.encode(body), headers: requestHeadersWithToken);
    print(response.body.toString());
    var x = json.decode(response.body);

    printInfo(info: requestHeadersWithToken.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.checkWishlist(id!);
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Success",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: Text(
            x["detail"],
            style: const TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future addToSet(BuildContext context, var body, int? id,
      var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.commonStorage),
        body: json.encode(body), headers: requestHeadersWithToken);
    print(response.body.toString());
    var x = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.checkSetList(id!);
      Navigator.of(context).pop();

      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Success",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future deleteWishlist(BuildContext context, int? id) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    final response = await http.delete(Uri.parse(Urls.commonStorage + '$id/'),
        headers: requestToken);

    printInfo(info: response.statusCode.toString());
    printInfo(info: Urls.commonStorage + '$id/');

    if (response.statusCode == 204) {
      Navigator.of(context).pop();
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.getWishList();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Success",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Future deleteSetList(BuildContext context, int? id) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingExample());

    final response = await http.delete(Uri.parse(Urls.commonStorage + '$id/'),
        headers: requestToken);

    printInfo(info: response.statusCode.toString());
    printInfo(info: Urls.commonStorage + '$id/');

    if (response.statusCode == 204) {
      Navigator.of(context).pop();
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.getSetList();
      await getData!.getVaultStats(0);
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Success",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: const Duration(seconds: 3),
          messageText: const Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
    notifyListeners();
  }

  Store(var mat, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('user_id', mat['user_id'].toString());
    prefs!.setString('id', mat['id'].toString());
    prefs!.setString('name', mat['name'].toString());
    prefs!.setString('email', mat['email'].toString());
    prefs!.setString('phone', mat['phone'].toString());
    prefs!.setString('user_name', mat['user_name'].toString());
    prefs!.setString('user_type', mat['user_type'].toString());
    prefs!.setString('image', mat['image'].toString());
    prefs!.setString('is_email_verified', mat['is_email_verified'].toString());
    prefs!.setString('token', mat['token'].toString());
    prefs!.setBool('is_2fa', mat['is_2fa']);
    prefs!.setBool("is_login", true);

    print(prefs!.get('token'));

    getData = Provider.of<GetData>(context, listen: false);
    await getData!.getUserInfo();

    Get.to(() => ControllerPage());
  }
}
