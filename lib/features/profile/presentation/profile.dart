import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/shimmer/loading.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';
import 'package:ketemaa/features/auth/presentation/auth_initial_page/auth_initial_page.dart';
import 'package:ketemaa/features/auth/reset_pass/enter_new_pass.dart';
import 'package:ketemaa/features/auth/verification/otpPage.dart';
import 'package:ketemaa/features/profile/presentation/edit_profile_page.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';
import 'package:ketemaa/features/profile/widgets/profile_divider.dart';
import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final _dialog = RatingDialog(
      title: const Text('Rate Us On App Store or Play Store'),
      message: const Text(''),
      image: Image.asset('slider/12.png'),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
        } else {
          StoreRedirect.redirect(
              androidAppId: 'com.xinxian.shop', iOSAppId: 'com.xinxian.shop');
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
                      SizedBox(
                        height: Get.height * .05,
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
                                          'assets/media/image/profile.png'),
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
                      CustomProfileElements(
                          Icons.help_outline, "Help and Support", () {}),
                      CustomProfileElements(
                          Icons.privacy_tip_outlined, "Privacy Policy", () {}),
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
                          Icons.info_outline_rounded, "About Vemate", () {}),
                      CustomProfileElements(Icons.logout, "Log Out", () {
                        Get.offAll(() => const AuthInitialPage());
                        prefs!.clear();
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
