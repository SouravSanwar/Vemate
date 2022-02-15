import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';

class AgencyProfile extends StatelessWidget {
  const AgencyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_16,
        right: AppDimension.padding_16,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            AppLanguageString.AGENCY.tr,
            style: Get.textTheme.headline2!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpaces.spaces_height_10,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name of the Agency',
                    style: Get.textTheme.headline1!.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/media/icon/category.png'),
                    height: 45.0,
                    width: 45.0,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
              AppSpaces.spaces_height_15,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21585',
                          style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RERA ORN',
                          style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21589624',
                          style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'DED License No',
                          style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
