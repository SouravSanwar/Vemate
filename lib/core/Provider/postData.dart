import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/network/base_client.dart';
import 'package:ketemaa/core/network/base_controller.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/_controller/sign_in_controller.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/sign_in_2fa.dart';
import 'package:ketemaa/features/auth/reset_pass/forgot_pass.dart';
import 'package:ketemaa/features/auth/verification/otpPage.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/app_colors/app_colors.dart';

class PostData extends ChangeNotifier with BaseController {
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
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.signUp), body: json.encode(body), headers: requestHeaders);

    //var x = json.decode(response.body);

    //print(x.toString());

    // Map<String, dynamic> js = x;
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      prefs = await SharedPreferences.getInstance();
      Navigator.of(context).pop();
      Get.to(() => OtpPage());
    } else {
      var x = json.decode(response.body);

      print(x.toString());

      Map<String, dynamic> js = x;

      Navigator.of(context).pop();
      if (js.containsKey('nickname')) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.error,
                  color: Colors.purpleAccent,
                  message: js['nickname'][0].toString(),
                ));

        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      }
      if (js.containsKey('email')) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.error,
                  color: Colors.purpleAccent,
                  message: js['email'][0].toString(),
                ));
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      }

      notifyListeners();
    }
  }

  Future verifyCode(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.verifyCode), body: json.encode(body), headers: requestHeaders);

    //var x = json.decode(response.body);

    printInfo(info: response.body.toString());

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Navigator.of(context).pop();
      Get.to(() => const AuthInitialPage());
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Verified Successfully",
              ));

      /*try {
        if (x['code'] == 'True') {

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
        return response.body;
      }*/
    } else {
      var x = json.decode(response.body);
      Map<String, dynamic> js = x;
      Navigator.of(context).pop();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Invalid Information",
              ));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future forgotPassword(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.forgotPass), body: json.encode(body), headers: requestHeaders);

    //var x = json.decode(response.body);

    printInfo(info: response.body.toString());

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Navigator.of(context).pop();
      Get.to(() => const AuthInitialPage());

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Password Updated",
              ));
    } else {
      Map<String, dynamic> js = json.decode(response.body);
      Navigator.of(context).pop();
      js.containsKey('password')
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ResponseMessage(
                    icon: Icons.check_circle,
                    color: AppColors.primaryColor,
                    message: js['password'][0].toString(),
                  ))
          : (js.containsKey('code')
              ? showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponseMessage(
                        icon: Icons.check_circle,
                        color: AppColors.primaryColor,
                        message: js['code'][0].toString(),
                      ))
              : showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ResponseMessage(
                        icon: Icons.check_circle,
                        color: AppColors.primaryColor,
                        message: js['email'][0].toString(),
                      )));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future resendCode(
    BuildContext context,
    var body, {
    bool isResetPass = false,
  }) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await http.post(Uri.parse(Urls.resendCode), body: json.encode(body), headers: requestHeaders);

    var x = json.decode(response.body);

    printInfo(info: response.body.toString());

    Map<String, dynamic> js = x;

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Navigator.of(context).pop();

      isResetPass == true
          ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ResponseMessage(
                    icon: Icons.check_circle,
                    color: AppColors.primaryColor,
                    message: js['msg'],
                  )).whenComplete(
              () => Get.to(
                () => const ForgotPassword(),
              ),
            )
          : showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ResponseMessage(
                    icon: Icons.check_circle,
                    color: AppColors.primaryColor,
                    message: js['msg'],
                  ));
    } else {
      printInfo(info: 'From else');
      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: js['email'][0],
              ));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future logIn(BuildContext context, var body) async {
    /*showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));
*/
    /*final response =
        await BaseClient().post(Urls.logIn, body).catchError(handleError);*/

    final response = await http.post(Uri.parse(Urls.logIn), body: json.encode(body), headers: requestHeaders);

    var x = json.decode(response.body);

    Map<String, dynamic> js = x;

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        if (js['is_email_verified'] == true) {
          // Navigator.of(context).pop();
          prefs = await SharedPreferences.getInstance();
          prefs!.setString('email', js['email'].toString());

          var body = {
            "email": js['email'].toString(),
            "reason": "verify",
          };

          postData = Provider.of<PostData>(context, listen: false);

          js['is_2fa'] == true
              ? postData!.resendCode(context, body).whenComplete(() => Get.to(() => const SignIn2FA()))
              : Store(js, context);

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ResponseMessage(
                    icon: Icons.check_circle,
                    color: AppColors.primaryColor,
                    message: "Login Successful",
                  ));
        } else {
          //Navigator.of(context).pop();
          prefs!.setString('email', js['email'].toString());

          var body = {
            "email": js['email'].toString(),
            "reason": "verify",
          };
          postData = Provider.of<PostData>(context, listen: false);
          postData!.resendCode(context, body).whenComplete(() => Get.to(() => OtpPage()));
        }
      } catch (e) {
        Navigator.of(context).pop();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const ResponseMessage(
                  icon: Icons.error,
                  color: Colors.purpleAccent,
                  message: "Invalid Information",
                ));
      }
    } else {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Invalid Information",
              ));
      /*if (js['username'] == null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.check_circle,
                  color: AppColors.primaryColor,
                  message: 'Password didn\'t match',
                  //message: js['password'][0].toString(),
                ));
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.check_circle,
                  color: AppColors.primaryColor,
                  message: js['username'][0].toString(),
                ));
      }*/
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future logInWith2FA(BuildContext context, var body) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    final response = await BaseClient().post(Urls.logInWith2FA, body).catchError(handleError);

    var x = json.decode(response);
    Map<String, dynamic> js = x;

    if (js['is_email_verified'] == true) {
      Navigator.of(context).pop();
      prefs = await SharedPreferences.getInstance();
      Store(js, context);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Login Successful",
              ));
    } else {
      Navigator.of(context).pop();
      if (js['username'] == null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.check_circle,
                  color: AppColors.primaryColor,
                  message: js['password'][0].toString(),
                ));
      } else {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ResponseMessage(
                  icon: Icons.check_circle,
                  color: AppColors.primaryColor,
                  message: js['username'][0].toString(),
                ));
      }
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future updateProfile(BuildContext context, var body, var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Updating Info.Please wait",
            ));

    printInfo(info: body.toString());

    final response =
        await http.patch(Uri.parse(Urls.updateUserInfo), body: json.encode(body), headers: requestHeadersWithToken);
    print(response.body.toString());
    print(requestHeadersWithToken.toString());
    var x = json.decode(response.body);

    Map<String, dynamic> js = x;
    if (js['is_email_verified'] == true) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.getUserInfo();
      prefs = await SharedPreferences.getInstance();

      prefs!.setString('name', js['name'].toString());
      prefs!.setString('email', js['email'].toString());

      Navigator.of(context).pop();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Info Updated Successfully",
              ));
    } else if (js['is_email_verified'] == false) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.getUserInfo();
      prefs = await SharedPreferences.getInstance();

      prefs!.setString('name', js['name'].toString());
      prefs!.setString('email', js['email'].toString());

      Navigator.of(context).pop();
      prefs!.clear();

      SigninController.to.userNameTextFiledController.clear();
      SigninController.to.passwordTextFiledController.clear();

      Get.offAll(() => const AuthInitialPage());
    } else {
      Navigator.of(context).pop();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Invalid Information",
              ));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future updateFCMToken(BuildContext context, var body, var requestHeadersWithToken) async {
    printInfo(info: body.toString());

    final response =
        await http.patch(Uri.parse(Urls.updateUserInfo), body: json.encode(body), headers: requestHeadersWithToken);
    var x = json.decode(response.body);

    Map<String, dynamic> js = x;
    if (js['is_email_verified'] == true) {}
    notifyListeners();
  }

  Future enDe2FA(BuildContext context, var requestHeadersWithToken) async {
    showDialog(context: context, barrierDismissible: false, builder: (_) => const LoadingExample());

    final response = await http.post(Uri.parse(Urls.check2FA), headers: requestHeadersWithToken);
    printInfo(info: requestHeadersWithToken.toString());
    var x = json.decode(response.body);
    printInfo(info: x.toString());

    Map<String, dynamic> js = x;
    if (js.containsKey('status_2fa')) {
      getData = Provider.of<GetData>(context, listen: false);

      Navigator.of(context).pop();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: js['msg'][0].toString(),
              ));
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
    notifyListeners();
  }

  Future addToWishlist(BuildContext context, var body, int? id, var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await BaseClient().post(Urls.commonStorage, body);

    printInfo(info: response.toString());

    var data = json.decode(response);

    Map<String, dynamic> js = data;

    if (js.containsKey('id')) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.checkWishlist(id!);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Added Successfully",
              )).whenComplete(() => getData!.getWishList());
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: js["detail"],
              ));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future addToSet(BuildContext context, var body, int? id, var requestHeadersWithToken) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    printInfo(info: body.toString());

    final response = await BaseClient().post(Urls.commonStorage, body);

    /*final response = await http.post(Uri.parse(Urls.commonStorage),
        body: json.encode(body), headers: requestHeadersWithToken);*/

    printInfo(info: response.toString());

    var data = json.decode(response);

    Map<String, dynamic> js = data;

    if (js.containsKey('id')) {
      getData = Provider.of<GetData>(context, listen: false);
      await getData!.checkSetList(id!);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Added Successfully",
              )).whenComplete(() => getData!.getSetList(''));
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: js["detail"],
              ));
    }
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future deleteWishlist(BuildContext context, int? alterCheck, int? id, var requestToken, {int? check}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    final response = await http.delete(Uri.parse(Urls.commonStorage + '$id/'), headers: requestToken);

    printInfo(info: response.statusCode.toString());

    getData = Provider.of<GetData>(context, listen: false);

    var x = json.decode(response.body);
    printInfo(info: 'Body: ' + x.toString());

    Map<String, dynamic> js = x;
    if (js.containsKey('msg')) {
      if (check == 12) {
        Navigator.of(context).pop();
      }

      await Provider.of<GetData>(context, listen: false).getWishList();
      await Provider.of<GetData>(context, listen: false).getVaultStats();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: js["msg"],
              )).whenComplete(() => getData!.getWishList());
    } else {
      if (check == 12) {
        Navigator.of(context).pop();
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: js["detail"],
              ));
    }

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();

    notifyListeners();
  }

  Future deleteSetList(BuildContext context, int? id, var requestToken, var type, {int? deleteset}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    final response = await http.delete(Uri.parse(Urls.commonStorage + '$id/'), headers: requestToken);
    var data = json.decode(response.body);

    printInfo(info: data.toString());
    printInfo(info: Urls.commonStorage + '$id/');
    Map<String, dynamic> js = data;

    if (js.containsKey('msg')) {
      await Provider.of<GetData>(context, listen: false).getSetList(type);
      await Provider.of<GetData>(context, listen: false).getVaultStats();

      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: js["msg"],
              )).whenComplete(() => getData!.getSetList(''));
    } else {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Something Went Wrong",
              ));
    }
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context).pop();
    notifyListeners();
  }

  Future createAlert(BuildContext context, var body, String? origin, int? id) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Adding Alert. Please wait",
            ));

    printInfo(info: body.toString());

    getData = Provider.of<GetData>(context, listen: false);

    final response = await BaseClient().post(Urls.alert, body).catchError(handleError);

    var data = json.decode(response);

    printInfo(info: data.toString());

    Map<String, dynamic> js = data;
    if (js.containsKey('id')) {
      Navigator.of(context).pop();

      if (origin == 'allalert') {
        getData!.getAlert();
      }
      if (origin == 'wishlist') {
        getData!.getWishList();
      }
      if (origin == 'details') {
        getData!.getSingleProduct(id);
      }
      if (origin == 'collectible') {
        getData!.getCollectibles();
      }
      if (origin == 'comics') {
        getData!.getComics();
      }
      if (origin == 'search_collectible') {
        getData!.searchCollectibles();
      }
      if (origin == 'search_comics') {
        getData!.searchComics();
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Added Successfully",
              ));
      if (origin == 'allalert') {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Invalid Information",
              ));
    }

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future deleteAlert(BuildContext context, int? id, var requestToken, String? origin, int? pid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Deleting Alert. Please wait",
            ));
    getData = Provider.of<GetData>(context, listen: false);

    final response = await http.delete(Uri.parse(Urls.alert + '$id/'), headers: requestToken);

    printInfo(info: response.statusCode.toString());
    printInfo(info: Urls.alert + '$id/');

    if (response.statusCode == 204 ||
        response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      if (origin == 'allalert') {
        getData!.getAlert();
      }
      if (origin == 'wishlist') {
        getData!.getWishList();
      }
      if (origin == 'details') {
        getData!.getSingleProduct(id);
      }
      if (origin == 'collectible') {
        getData!.getCollectibles();
      }
      if (origin == 'comics') {
        getData!.getComics();
      }
      if (origin == 'search_collectible') {
        getData!.searchCollectibles();
      }
      if (origin == 'search_comics') {
        getData!.searchComics();
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Deleted Successfully",
              ));
      if (origin == 'allalert') {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Something went wrong",
              ));
    }
    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    notifyListeners();
  }

  Future notificationRead(BuildContext context, int? id, var requestToken) async {
    final response = await http.post(Uri.parse(Urls.notification + '$id/make_read_with_id/'), headers: requestToken);
    print("RESPONSE" + response.statusCode.toString());
    if (response.statusCode == 200) {
      getData = Provider.of<GetData>(context, listen: false);

      getData!.notificationListModel = null;
    }
    notifyListeners();
  }

  Future notificationAllRead(BuildContext context, var requestToken) async {
    final response = await http.get(Uri.parse(Urls.notification + 'make_reads/'), headers: requestToken);
    print("RESPONSE" + response.statusCode.toString());
    if (response.statusCode == 200) {
      getData = Provider.of<GetData>(context, listen: false);

      getData!.notificationListModel = null;
    }
    notifyListeners();
  }

  Future PostFeedback(BuildContext context, var body, var requestToken) async {
    final response = await http.post(Uri.parse(Urls.feedback), body: json.encode(body), headers: requestToken);
    print("RESPONSE" + response.body.toString());
    if (response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => ResponseMessage(
                icon: Icons.check_circle,
                color: AppColors.primaryColor,
                message: "Feedback Submitted Successfully",
              ));
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future deletePassCheck(
    BuildContext context,
    var body,
    int? id,
    var requestToken,
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Please wait",
            ));

    /*final response =
        await BaseClient().post(Urls.logIn, body).catchError(handleError);*/

    final response = await http.post(Uri.parse(Urls.logIn), body: json.encode(body), headers: requestHeaders);

    var x = json.decode(response.body);

    Map<String, dynamic> js = x;

    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      try {
        postData = Provider.of<PostData>(context, listen: false);

        postData!.deleteAccount(
          context,
          id,
          requestToken,
        );
      } catch (e) {
        Navigator.of(context).pop();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const ResponseMessage(
                  icon: Icons.error,
                  color: Colors.purpleAccent,
                  message: "Invalid Information",
                ));
      }
    } else {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Invalid Information",
              ));
    }
    notifyListeners();
  }

  Future deleteAccount(
    BuildContext context,
    int? id,
    var requestToken,
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingDialogue(
              message: "Deleting Account Please wait",
            ));
    getData = Provider.of<GetData>(context, listen: false);

    final response = await http.delete(Uri.parse(Urls.deleteAccount + '$id/'), headers: requestToken);

    printInfo(info: response.statusCode.toString());
    printInfo(info: Urls.alert + '$id/');

    if (response.statusCode == 204 ||
        response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 500 ||
        response.statusCode == 201) {
      Get.offAll(() => const AuthInitialPage());
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const ResponseMessage(
                icon: Icons.error,
                color: Colors.purpleAccent,
                message: "Something went wrong",
              ));
    }
    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context).pop();
    Navigator.of(context).pop();

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
    printInfo(info: prefs!.get('token').toString());

    //Get.offAll(() => ControllerPage());

    notifyListeners();
  }
}
