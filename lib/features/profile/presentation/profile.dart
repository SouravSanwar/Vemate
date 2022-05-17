import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/presentation/sign_in/_controller/sign_in_controller.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/profile/widgets/profile_divider.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

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

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
   final _dialog = RatingDialog(
      starSize: 35.0,
      initialRating: 5.0,
      title: Text(
        'Rate Us On App Store or Play Store',
        textAlign: TextAlign.center,
        style: Get.textTheme.headlineMedium!,
      ),
      message: Text(
        '',
        textAlign: TextAlign.center,
        style: Get.textTheme.bodyMedium!,
      ),
      image: Image.asset('assets/media/image/vemate.png'),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
        } else {
          StoreRedirect.redirect(
              androidAppId: 'com.vemateltd.vemate', iOSAppId: 'com.vemateltd.vemate');
        }
      },
    );

    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Consumer<GetData>(builder: (context, data, child) {
        return data.profileModel != null
            ? Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: Padding(
                  padding: EdgeInsets.only(
                    left: AppDimension.padding_8,
                    right: AppDimension.padding_8,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // SizedBox(height: Get.height * .05),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Shader(
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: data.profileModel!.profileImage != null
                                  ? CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              .15,
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
                                          MediaQuery.of(context).size.width *
                                              .15,
                                      backgroundColor: const Color(0xff272E49),
                                      backgroundImage: const AssetImage(
                                          'assets/media/image/vemate.png'),
                                    ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.greyWhite,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            Text(
                              data.profileModel!.nickname.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                      /*CustomProfileElements(
                          Icons.privacy_tip_outlined, "Privacy Policy", () async {
                        String url = 'https://pages.flycricket.io/vemate-0/privacy.html';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),*/
                      CustomProfileElements(Icons.rate_review_outlined, "Rate",
                          () {
                        showDialog(
                          context: context,
                          builder: (context) => _dialog,
                        );
                      }),
                      CustomProfileElements(Icons.share, "Share Vemate", () {
                        Share.share(
                            'Visit Vemate Website:\n https://www.vemate.com/');
                      }),
                      CustomProfileElements(
                          Icons.info_outline_rounded, "About Vemate", () async {
                        String url = 'https://www.vemate.com/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }),
                      CustomProfileElements(
                          Icons.toggle_off_outlined,
                          data.profileModel!.fa == true
                              ? "Two FA Enabled"
                              : 'Two FA Disabled', () {
                        Get.dialog(
                          Dialog(
                            backgroundColor: const Color(0xff272E49),
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
                                            'assets/media/icon/logo v.png',
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
                                                  color: AppColors.white,
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
                                                .copyWith(color: Colors.white),
                                          )
                                        : Text(
                                            'Two Factor Authentication is Disabled',
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.bodyLarge!
                                                .copyWith(color: Colors.white),
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
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Disable',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Enable',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                      }),
                      CustomProfileElements(Icons.logout, "Log Out", () {
                        prefs!.clear();

                        SigninController.to.userNameTextFiledController.clear();
                        SigninController.to.passwordTextFiledController.clear();

                        Get.offAll(() => const AuthInitialPage());
                      }),
                    ],
                  ),
                ),
              )
            : const LoadingExample();
      }),
    );
  }
}
