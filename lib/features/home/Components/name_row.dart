import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utilities/app_colors/app_colors.dart';
import '../../../core/utilities/app_spaces/app_spaces.dart';

class NameRow extends StatelessWidget {
  String? name;

  NameRow({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name.toString(),
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyText1!.copyWith(color: AppColors.black),
        ),
        AppSpaces.spaces_width_5,
        Expanded(
          child: Column(
            children: [
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
