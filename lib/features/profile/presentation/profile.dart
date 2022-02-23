import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/profile/widgets/profile_divider.dart';

import 'custom_app_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //maintainBottomViewPadding: true,
      minimum: EdgeInsets.zero,
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimension.padding_8,
              right: AppDimension.padding_8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    AppSpaces.spaces_height_5,
                    Text(
                      'My Account',
                      style: Get.textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    AppSpaces.spaces_height_5,
                    const Padding(
                      padding: EdgeInsets.only(left: 45.0, right: 45.0),
                      child: ProfileDetailsDivider(),
                    ),
                    AppSpaces.spaces_height_5,
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset('assets/media/image/profile.png'),
                      ),
                    ),
                    AppSpaces.spaces_height_5,
                    Text(
                      'User Name',
                      style: Get.textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/edit.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'Profile Edit',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/customer-service.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'Help and Support',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/privacy-policy.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'Privacy Policy',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/rating.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'Rate',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/share.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'Share Vemate',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                    Row(
                      children: [
                        Image.asset(
                          'assets/media/image/information.png',
                          height: 15,
                          width: 15,
                        ),
                        AppSpaces.spaces_width_10,
                        Text(
                          'About Vemate',
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const ProfileDetailsDivider(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(AppDimension.padding_16),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppDimension.padding_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log Out',
                            style: Get.textTheme.bodyText2,
                          ),
                          AppSpaces.spaces_width_10,
                          Image.asset(
                            'assets/media/image/logout.png',
                            height: 15,
                            width: 15,
                          ),
                        ],
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
  }
}
