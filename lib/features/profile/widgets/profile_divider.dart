import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class ProfileDetailsDivider extends StatelessWidget {
  const ProfileDetailsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.spaces_height_5,
        Divider(
          color: AppColors.greyWhite,
          thickness: 1.0,
        ),
        AppSpaces.spaces_height_5,
      ],
    );
  }
}
