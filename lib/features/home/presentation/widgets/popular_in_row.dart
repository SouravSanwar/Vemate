import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';

class PopularInRow extends StatelessWidget {
  String? type;
  String? popularIn;

  PopularInRow({this.type, this.popularIn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type! + ' ' + popularIn!,
          style: Get.textTheme.bodyText2!
              .copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_drop_down),
        )
      ],
    );
  }
}
