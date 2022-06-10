import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  static SigninController to = Get.find();

  //testFiledControllers

  TextEditingController userNameTextFiledController = TextEditingController();
  TextEditingController emailTextFiledController = TextEditingController();
  TextEditingController passwordTextFiledController = TextEditingController();
}
