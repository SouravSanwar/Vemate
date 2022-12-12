import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/common_widgets/customButtons.dart';
import 'package:ketemaa/core/utilities/common_widgets/password_input_field.dart';
import 'package:ketemaa/core/utilities/shimmer/loading_dialogue.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/_controller/sign_in_controller.dart';
import 'package:ketemaa/features/home/presentation/change_password.dart';
import 'package:ketemaa/features/profile/feedback/feeback_body.dart';
import 'package:ketemaa/features/profile/feedback/feedback.dart';
import 'package:ketemaa/features/profile/feedback/rating_stars.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../profile/widgets/profileElements.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool? allSelected = true;
  GetData? getData;
  bool profile = true;
  bool rate = false; //bool share, bool about,bool privacy, bool logout, bool delete
  bool share = false;
  bool about = false;
  bool privacy = false;
  bool changePass = false;
  bool logout = false;
  bool delete = false;

  PostData? postData;
  TextEditingController passwordController = TextEditingController();
  Map<String, String> requestHeadersWithToken = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  Map<String, String> requestToken = {
    'Authorization': 'token ${prefs!.getString('token')}',
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //getConnection();
    postData = Provider.of<PostData>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);

    getData!.getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    return Consumer<GetData>(builder: (context, data, child) {
      return data.profileModel != null
          ? Container(
              margin: EdgeInsets.only(right: 50),
              padding: EdgeInsets.only(top: 50),
              color: AppColors.backgroundColor,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: data.profileModel!.profileImage != null
                              ? CircleAvatar(
                                  radius: MediaQuery.of(context).size.width * .06,
                                  backgroundColor: const Color(0xff272E49),
                                  backgroundImage: NetworkImage(
                                    Urls.mainUrl + data.profileModel!.profileImage!.mobile!.src.toString(),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: MediaQuery.of(context).size.width * .06,
                                  backgroundColor: const Color(0xff272E49),
                                  backgroundImage: const AssetImage('assets/media/image/vemate.png'),
                                ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.textColor.withOpacity(0.8),
                              width: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * .05,
                        ),
                        Text(
                          data.profileModel!.nickname.toString(),
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: 'Inter',
                              //fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  const Divider(
                    height: .5,
                    color: Color(0xff0A1671),
                    thickness: 1,
                  ),
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  CustomProfileElements(Icons.person, "Profile", () {
                    setState(() {
                      DrawerItems(true, false, false, false, false,false, false, false);
                    });
                    Get.to(
                      () => EditProfilePage(),
                      arguments: data.profileModel,
                    );
                  }, profile //true or false
                      ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  CustomProfileElements(Icons.rate_review_outlined, "Rate The App", () async {
                    setState(() {
                      DrawerItems(false, true, false, false, false,false, false, false);
                    });
                    FeedbackBody.checkFeedback = 0;
                    RatingStars.ratingValue = 0;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FeedbackScreen();
                        });

                    /*final InAppReview inAppReview = InAppReview.instance;

                          setState(() async {
                            if (await inAppReview.isAvailable()) {
                            inAppReview.requestReview();
                            }
                          });*/
                  }, rate //true or false
                      ),
                  CustomProfileElements(Icons.share, "Share Vemate", () {
                    setState(() {
                      DrawerItems(false, false, true, false, false,false, false, false);
                    });
                      // Share.share('Visit Vemate Website:\n https://www.vemate.com/');
                  }, share //true or false
                      ),
                  CustomProfileElements(Icons.info_outline_rounded, "About Vemate", () async {
                    setState(() {
                      DrawerItems(false, false, false, true, false,false, false, false);
                    });
                    String url = 'https://www.vemate.com/';
                    _launchInApp(url);
                  },
                      //true or false
                      about),
                  CustomProfileElements(Icons.privacy_tip_outlined, "Privacy Policy", () async {
                    setState(() {
                      DrawerItems(false, false, false, false, true,false, false, false);
                    });
                    String url = 'https://pages.flycricket.io/vemate-0/privacy.html';
                    _launchInApp(url);
                  },
                      //true or false
                      privacy),
                  CustomProfileElements(Icons.lock_reset_outlined, "Change Password", () {
                    setState(() {
                      DrawerItems(false, false, false, false, false,true, false, false);
                    });
                    print(data.profileModel!.id.toString());
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const ChangePassword();
                        });
                  },
                      //true or false
                      changePass),
                  SizedBox(height: Get.height * .15),
                  CustomProfileElements(Icons.logout, "Log Out", () {
                    setState(() {
                      DrawerItems(false, false, false, false, false,false, true, false);
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20.0,
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: AppColors.textColor,
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(color: AppColors.textColor, fontSize: 20.sp),
                                ),
                              ],
                            ),
                            content: Text(
                              'Do you really want to exit?',
                              style: TextStyle(color: AppColors.textColor, fontSize: 15.sp),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); //close Dialog
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(color: AppColors.textColor),
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    prefs!.clear();

                                    SigninController.to.userNameTextFiledController.clear();
                                    SigninController.to.passwordTextFiledController.clear();
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => const LoadingDialogue(
                                              message: "Please wait",
                                            ));

                                    await Future.delayed(const Duration(seconds: 2));

                                    Get.offAll(() => const AuthInitialPage());
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: AppColors.greyWhite),
                                  )),
                            ],
                          );
                        });
                  },
                      //true or false
                      logout),
                  CustomProfileElements(Icons.delete_forever_outlined, "Delete Account", () {
                    setState(() {
                      DrawerItems(false, false, false, false, false,false, false, true);
                    });
                    print(data.profileModel!.id.toString());
                    showDialog(
                        context: context,
                        builder: (context) {
                          var w;
                          return Dialog(
                            backgroundColor: AppColors.backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20.0,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: Get.height * .3,
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Please enter your Password to delete account",
                                      style: TextStyle(
                                        color: AppColors.textColor.withOpacity(.7),
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.w,
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
                                      controller: passwordController,
                                    borderRadius: 15,
                                  ),
                                  Container(
                                    // alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context); //close Dialog
                                          },
                                          child: Text(
                                            'No',
                                            style: TextStyle(color: AppColors.textColor),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              var body = {
                                                "username": prefs!.get('email').toString(),
                                                "password": passwordController.text,
                                              };
                                              print("body:"+body.toString());

                                              postData!.deletePassCheck(
                                                context,
                                                body,
                                                data.profileModel!.id,
                                                requestHeadersWithToken,
                                              );

                                              SigninController.to.userNameTextFiledController.clear();
                                              SigninController.to.passwordTextFiledController.clear();

                                              // Get.offAll(() => const AuthInitialPage());
                                            },
                                            child: const Text(
                                              'Delete Account',
                                              style: TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                          /*AlertDialog(
                              backgroundColor: AppColors.backgroundColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              titlePadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: AppColors.textColor,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    child: Text(
                                      "Please enter your Password to delete account",
                                      style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              content: PasswordInputField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Password is required';
                                    }
                                  },
                                  labelText: "Password",
                                  height: Get.height * .04,
                                  textType: TextInputType.text,
                                  controller: passwordController),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      prefs!.clear();

                                      SigninController
                                          .to.userNameTextFiledController
                                          .clear();
                                      SigninController
                                          .to.passwordTextFiledController
                                          .clear();

                                      Get.offAll(() => const AuthInitialPage());
                                    },
                                    child: Text(
                                      'Yes',
                                      style:
                                      TextStyle(color: AppColors.greyWhite),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); //close Dialog
                                  },
                                  child: Text(
                                    'No',
                                    style:
                                    TextStyle(color: AppColors.textColor),
                                  ),
                                )
                              ],
                            );*/
                        });
                  },
                      //true or false
                      delete),

                ],
              ),
            )
          : Container(
              margin: EdgeInsets.only(right: 50),
              padding: EdgeInsets.only(top: 50),
              color: AppColors.backgroundColor,
            );
    });
  }

  void DrawerItems(bool profile, bool rate, bool share, bool about, bool privacy,bool changePass, bool logout, bool delete) {
    this.profile = profile;
    this.rate = rate;
    this.share = share;
    this.about = about;
    this.privacy = privacy;
    this.changePass=changePass;
    this.logout = logout;
    this.delete = delete;
  }
}
