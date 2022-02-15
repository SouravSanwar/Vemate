import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class PropertyTopDescription extends StatelessWidget {
  const PropertyTopDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_16,
        right: AppDimension.padding_16,
      ),
      child: Column(
        children: [
          Text(
            'Price',
            style: Get.textTheme.headline3!.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.spaces_height_10,
          Text(
            'Title will be here like a short description'.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.headline6!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.spaces_height_10,
          const Divider(
            height: 1.0,
          ),
          AppSpaces.spaces_height_10,
          Row(
            children: const [
              Expanded(
                child: Text('Attribute 1'),
              ),
              Expanded(
                child: Text('Attribute 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
