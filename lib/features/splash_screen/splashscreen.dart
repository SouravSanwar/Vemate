import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ketemaa/core/functions/version_control.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    VersionControl.initConfig();
    VersionControl.initPackageInfo();
    /*prefs!.getString('token') != null
        ? Get.to(() => ControllerPage())
        : Get.to(() => const AuthInitialPage());*/
  }

  @override
  void initState() {
    super.initState();

    const simpleBehavior = false;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: AppColors.onBoardGradient
        ),
        child: Center(
          child: Container(
            height: Get.width*.8,
            width: Get.width*.8,
            child: Image.asset(
              'assets/media/image/splash_logo.png',
              width: animation.value * 450,
              height: animation.value * 450,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
