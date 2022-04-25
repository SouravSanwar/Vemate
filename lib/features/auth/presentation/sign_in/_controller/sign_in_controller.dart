import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/auth/data/models/user_login_model.dart';

class SigninController extends GetxController {
  static SigninController to = Get.find();

  //testFiledControllers

  TextEditingController userNameTextFiledController = TextEditingController();
  TextEditingController emailTextFiledController = TextEditingController();
  TextEditingController passwordTextFiledController = TextEditingController();


  RxString responseValue = "".obs;
  RxBool loading = false.obs;

  Rx<UserLoginModel> userLogin = UserLoginModel().obs;


}
