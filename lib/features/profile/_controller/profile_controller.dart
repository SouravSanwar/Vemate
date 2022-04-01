import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/ProfileModel.dart';

class ProfileController extends GetxController {
  static ProfileController to = Get.find();

  TextEditingController userNameTextFiledController = TextEditingController();
  TextEditingController emailTextFiledController = TextEditingController();
  TextEditingController passwordTextFiledController = TextEditingController();

  ProfileImage? sellerImageUrl;
}
