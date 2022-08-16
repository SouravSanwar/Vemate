import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/Provider/postFile.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/googleSignApi.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/utilities/common_widgets/password_input_field.dart';
import '../../../../core/utilities/common_widgets/text_input_field.dart';
import '../sign_in/_controller/sign_in_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class AuthInitialPage extends StatefulWidget {
  const AuthInitialPage({Key? key}) : super(key: key);

  @override
  _AuthInitialPageState createState() => _AuthInitialPageState();
}

class _AuthInitialPageState extends State<AuthInitialPage> {
  PostData? postData;
  File? imageFile;
  List<File>? files = <File>[];
  List<File>? fileList = <File>[];
  PostFile? postFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    postData = Provider.of<PostData>(context, listen: false);
    postFile = Provider.of<PostFile>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const StatusBar();
    Get.put(SigninController());
    printInfo(info: 'Auth Token: ' + prefs!.getString('token').toString());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              SizedBox(
                height: Get.height * .18,
                width: Get.width * .9,
                child: Image.asset(
                  mode == 0
                      ? 'assets/media/image/vemate1.png'
                      : 'assets/media/image/vemate.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: Get.width * .9,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontFamily: 'Inter', color: AppColors.textColor),
                        )),
                    AppSpaces.spaces_height_25,
                    TextInputField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username/Email is required';
                        }
                      },
                      labelText: "Username/Email",
                      height: Get.height * .04,
                      textType: TextInputType.emailAddress,
                      controller:
                          SigninController.to.userNameTextFiledController,
                    ),
                    SizedBox(
                      height: Get.height * .022,
                    ),
                    PasswordInputField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }
                        },
                        labelText: "Password",
                        height: Get.height * .04,
                        textType: TextInputType.text,
                        controller:
                            SigninController.to.passwordTextFiledController),
                    SizedBox(
                      height: Get.height * .025,
                    ),
                    Container(
                      width: Get.width * .9,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.RESET_PASS);
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .025,
                    ),
                    CustomButtons(
                      width: Get.width * .9,
                      height: Get.height * .065,
                      onTap: () {
                        var body = {
                          "username": SigninController
                              .to.userNameTextFiledController.text,
                          "password": SigninController
                              .to.passwordTextFiledController.text,
                        };
                        //getConnection();

                        if (_formKey.currentState!.validate()) {
                          postData!.logIn(context, body);
                        }
                      },
                      text: AppLanguageString.lOG_IN.tr.toUpperCase(),
                      style: Get.textTheme.button!.copyWith(
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    )
                  ],
                ),
              ),
              /*AppSpaces.spaces_height_35,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 45.0, right: 10.0),
                        child: const Divider(
                          color: Colors.grey,
                        )),
                  ),
                  Text(
                    "Or Continue With",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 45.0),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpaces.spaces_height_35,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.height * .1,
                    height: Get.height * .067,
                    child: ElevatedButton(
                      onPressed: () {
                        signIn();

                      },
                      child: Image.asset('assets/media/icon/google.png'),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                  SizedBox(
                    width: Get.height * .1,
                    height: Get.height * .067,
                    child: ElevatedButton(
                      onPressed: () async {
                        AppleSignIn();
                      },
                      child: Image.asset(
                        'assets/media/icon/apple.png',
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                  SizedBox(
                    width: Get.height * .1,
                    height: Get.height * .067,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/media/icon/facebook.png',
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          side: BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                          primary: const Color(0xff272E49)),
                    ),
                  ),
                ],
              ),*/
              SizedBox(
                height: Get.height * .09,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.SIGN_UP);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.grey,
                              fontSize: 15.sp),
                        ),
                        AppSpaces.spaces_width_5,
                        Text(
                          "Register For Free",
                          style: TextStyle(
                              //fontFamily: 'Inter',
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp),
                        ),
                      ]),
                ),
              ),
              AppSpaces.spaces_height_15,
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();
    var body = {
      "nickname": user!.displayName,
      "email": user.email,
      "gender": "0",
      "birth_year": "1852",
      "fcm_device_id": "3",
      //"password": "123",
      "social_provider": 1,
    };

/*    var rng = new Random();
     Directory tempDir = await getTemporaryDirectory();
    File file = new File(rng.nextInt(100).toString() +'.jpg');
    http.Response response = await http.get(Uri.parse(user.photoUrl!));
    await file.writeAsBytes(response.bodyBytes);

    imageFile=file;
    print("fileeeeeeeee"+file.toString());*/
    print("emailcheck" + user.displayName.toString());
    postData!.signUp(context, body);

    //postImage();
  }

  Future postImage() async {
    files!.add(imageFile!);
    fileList!.addAll(files!);

    List<String> fileKey = [];

    for (int i = 0; i < fileList!.length; i++) {
      fileKey.add('image');
    }
    Map<String, String>? body = {};

    postFile!.requestWithFile(
      context,
      url: Urls.updateProfilePic,
      method: Method.POST,
      body: body,
      fileKey: fileKey,
      files: fileList,
    );
  }

  Future AppleSignIn() async {
    AppleIDAuthorizationScopes appleEmail, appleName;
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        appleEmail = AppleIDAuthorizationScopes.email,
        appleName = AppleIDAuthorizationScopes.fullName,
      ],
    );

    var body = {
      "nickname": appleName.toString(),
      //"nickname": credential.familyName,
      "email": appleEmail.toString(),
      // "email": credential.email,
      "gender": "0",
      "birth_year": "1852",
      "fcm_device_id": "3",
      "password": "123",
      "social_provider": 2,
    };
    print("Apple Email:" + appleName.toString());
    print("Apple Email:" + credential.email.toString());

    postData!.signUp(context, body);
  }
}
