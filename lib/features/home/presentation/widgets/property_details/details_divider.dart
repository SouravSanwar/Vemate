import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class PropertyDetailsDivider extends StatelessWidget {
  const PropertyDetailsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.spaces_height_25,
        Divider(
          color: AppColors.greyWhite,
          thickness: 5.0,
        ),
        AppSpaces.spaces_height_25,
      ],
    );
  }
}
