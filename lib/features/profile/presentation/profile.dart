import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/common_widgets/status_bar.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/shimmer/response_message.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/_controller/sign_in_controller.dart';
import 'package:ketemaa/features/profile/feedback/feeback_body.dart';
import 'package:ketemaa/features/profile/feedback/feedback.dart';
import 'package:ketemaa/features/profile/feedback/rating_stars.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/profile/widgets/profileElements.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_checker/store_checker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostData? postData;
  GetData? getData;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
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
  Widget build(BuildContext context) {

    const StatusBar();
    final appStyleMode = Provider.of<AppColors>(context);
    Get.put(SigninController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        actions: const [
         // const ToggleButton(),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.zero,
        child: Consumer<GetData>(builder: (context, data, child) {
          return data.profileModel != null
              ? ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: Get.height * .05),

                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: data.profileModel!.profileImage != null
                                ? CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.width * .15,
                                    backgroundColor: const Color(0xff272E49),
                                    backgroundImage: NetworkImage(
                                      Urls.mainUrl +
                                          data.profileModel!.profileImage!
                                              .mobile!.src
                                              .toString(),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.width * .15,
                                    backgroundColor: const Color(0xff272E49),
                                    backgroundImage: const AssetImage(
                                        'assets/media/image/vemate.png'),
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
                            height: Get.height * .01,
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
                        ]),
                    SizedBox(
                      height: Get.height * .07,
                    ),

                    CustomProfileElements(Icons.person, "Profile Edit", () {
                      Get.to(
                        () => EditProfilePage(),
                        arguments: data.profileModel,
                      );
                    }),
                    /* CustomProfileElements(
                            Icons.help_outline, "Help and Support", () {}),*/
                    CustomProfileElements(
                            Icons.privacy_tip_outlined, "Privacy Policy", () async {
                          String url = 'https://pages.flycricket.io/vemate-0/privacy.html';
                          _launchInApp(url);
                        }),
                    CustomProfileElements(Icons.rate_review_outlined, "Rate",
                        () async {
                          FeedbackBody.checkFeedback=0;
                          RatingStars.ratingValue=0;
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
                    }),
                    CustomProfileElements(Icons.share, "Share Vemate", () {
                      Share.share(
                          'Visit Vemate Website:\n https://www.vemate.com/');
                    }),
                   /* CustomProfileElements(Icons.share, "Check Vemate", () async {
                      Source installationSource = await StoreChecker.getSource;

                      String source = "";
                      switch (installationSource) {
                        case Source.IS_INSTALLED_FROM_PLAY_STORE:
                        // Installed from Play Store
                          source = "Play Store";
                          break;
                        case Source.IS_INSTALLED_FROM_LOCAL_SOURCE:
                        // Installed using adb commands or side loading or any cloud service
                          source = "Local Source";
                          break;
                        case Source.IS_INSTALLED_FROM_AMAZON_APP_STORE:
                        // Installed from Amazon app store
                          source = "Amazon Store";
                          break;
                        case Source.IS_INSTALLED_FROM_HUAWEI_APP_GALLERY:
                        // Installed from Huawei app store
                          source = "Huawei App Gallery";
                          break;
                        case Source.IS_INSTALLED_FROM_SAMSUNG_GALAXY_STORE:
                        // Installed from Samsung app store
                          source = "Samsung Galaxy Store";
                          break;
                        case Source.IS_INSTALLED_FROM_SAMSUNG_SMART_SWITCH_MOBILE:
                        // Installed from Samsung Smart Switch Mobile
                          source = "Samsung Smart Switch Mobile";
                          break;
                        case Source.IS_INSTALLED_FROM_XIAOMI_GET_APPS:
                        // Installed from Xiaomi app store
                          source = "Xiaomi Get Apps";
                          break;
                        case Source.IS_INSTALLED_FROM_OPPO_APP_MARKET:
                        // Installed from Oppo app store
                          source = "Oppo App Market";
                          break;
                        case Source.IS_INSTALLED_FROM_VIVO_APP_STORE:
                        // Installed from Vivo app store
                          source = "Vivo App Store";
                          break;
                        case Source.IS_INSTALLED_FROM_OTHER_SOURCE:
                        // Installed from other market store
                          source = "Other Source";
                          break;
                        case Source.IS_INSTALLED_FROM_APP_STORE:
                        // Installed from app store
                          source = "App Store";
                          break;
                        case Source.IS_INSTALLED_FROM_TEST_FLIGHT:
                        // Installed from Test Flight
                          source = "Test Flight";
                          break;
                        case Source.UNKNOWN:
                        // Installed from Unknown source
                          source = "Unknown Source";
                          break;
                      }
                     setState(() async {
                       showDialog(
                           context: context,
                           barrierDismissible: false,
                           builder: (_) => ResponseMessage(
                             icon: Icons.info,
                             color: AppColors.primaryColor,
                             message: source,
                           ));
                       await Future.delayed(const Duration(seconds: 1));
                       Navigator.of(context).pop();
                     });
                    }),*/
                    CustomProfileElements(
                        Icons.info_outline_rounded, "About Vemate", () async {
                      String url = 'https://www.vemate.com/';
                      _launchInApp(url);
                    }),
                    /*CustomProfileElements(
                        Icons.toggle_off_outlined,
                        data.profileModel!.fa == true
                            ? "Two FA Enabled"
                            : 'Two FA Disabled', () {
                      Get.dialog(
                        Dialog(
                          backgroundColor: AppColors.backgroundColor,
                          child: Container(
                            width: Get.height * .25,
                            decoration: BoxDecoration(
                              gradient: AppColors.cardGradient,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: Get.height * .02,
                                        width: Get.height * .02,
                                        child: Image.asset(
                                          'assets/media/icon/logo_v.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.height * .01,
                                      ),
                                      Text(
                                        "Vemate",
                                        style: Get.textTheme.headline1!
                                            .copyWith(
                                                color: AppColors.textColor,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  AppSpaces.spaces_height_25,
                                  data.profileModel!.fa == true
                                      ? Text(
                                          'Two Factor Authentication is Enabled',
                                          textAlign: TextAlign.center,
                                          style: Get.textTheme.bodyLarge!
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        )
                                      : Text(
                                          'Two Factor Authentication is Disabled',
                                          textAlign: TextAlign.center,
                                          style: Get.textTheme.bodyLarge!
                                              .copyWith(
                                                  color: AppColors.textColor),
                                        ),
                                  AppSpaces.spaces_height_25,
                                  data.profileModel!.fa == true
                                      ? InkWell(
                                          onTap: () {
                                            Get.back();
                                            postData = Provider.of<PostData>(
                                                context,
                                                listen: false);
                                            Map<String, String>
                                                requestHeadersWithToken = {
                                              'Content-type':
                                                  'application/json',
                                              'Accept': 'application/json',
                                              'Authorization':
                                                  'token ${prefs!.getString('token')}',
                                            };
                                            postData!.enDe2FA(context,
                                                requestHeadersWithToken);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.purpleGradient,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Disable',
                                                style: TextStyle(
                                                    color: AppColors.textColor),
                                              ),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Get.back();
                                            postData = Provider.of<PostData>(
                                                context,
                                                listen: false);
                                            Map<String, String>
                                                requestHeadersWithToken = {
                                              'Content-type':
                                                  'application/json',
                                              'Accept': 'application/json',
                                              'Authorization':
                                                  'token ${prefs!.getString('token')}',
                                            };
                                            postData!.enDe2FA(context,
                                                requestHeadersWithToken);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.purpleGradient,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 3,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Enable',
                                                style: TextStyle(
                                                    color: AppColors.textColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),*/
                    CustomProfileElements(Icons.logout, "Log Out", () {
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              titlePadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
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
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              content: Text(
                                'Do you really want to exit?',
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 15.sp),
                              ),
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
                            );
                          });
                    }),
                  ],
                )
              : const LoadingExample();
        }),
      ),
    );
  }
}
