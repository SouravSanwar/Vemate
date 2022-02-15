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
        appBar: CustomAppBar(
          height: 150,
          color: Colors.transparent,
          child: Column(
            children: [
              AppSpaces.spaces_height_5,
              Text(
                'My Account',
                style: Get.textTheme.headline2,
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
                  child: Image.asset('assets/media/icon/facebook.png'),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimension.padding_8,
              right: AppDimension.padding_8,
            ),
            child: ListView(
              children: [
                const ProfileDetailsDivider(),
                Row(
                  children: [
                    Image.asset(
                      'assets/media/icon/category.png',
                      height: 15,
                      width: 15,
                    ),
                    AppSpaces.spaces_width_10,
                    Text(
                      'My Ads',
                      style: Get.textTheme.bodyText2,
                    ),
                  ],
                ),
                const ProfileDetailsDivider(),
                Row(
                  children: [
                    Image.asset(
                      'assets/media/icon/category.png',
                      height: 15,
                      width: 15,
                    ),
                    AppSpaces.spaces_width_10,
                    Text(
                      'My Saved Searches',
                      style: Get.textTheme.bodyText2,
                    ),
                  ],
                ),
                const ProfileDetailsDivider(),
                AppSpaces.spaces_height_30,
                Text(
                  'Settings',
                  style: Get.textTheme.headline1,
                ),
                const ProfileDetailsDivider(),
                Row(
                  children: [
                    Image.asset(
                      'assets/media/icon/category.png',
                      height: 15,
                      width: 15,
                    ),
                    AppSpaces.spaces_width_10,
                    Text(
                      'My Profile',
                      style: Get.textTheme.bodyText2,
                    ),
                  ],
                ),
                const ProfileDetailsDivider(),
                Row(
                  children: [
                    Image.asset(
                      'assets/media/icon/category.png',
                      height: 15,
                      width: 15,
                    ),
                    AppSpaces.spaces_width_10,
                    Text(
                      'City',
                      style: Get.textTheme.bodyText2,
                    ),
                  ],
                ),
                const ProfileDetailsDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
