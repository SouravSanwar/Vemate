import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';

class PropertyInfo extends StatelessWidget {
  const PropertyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.padding_16,
        right: AppDimension.padding_16,
      ),
      child: Obx(() {
        return ListView(
          shrinkWrap: true,
          children: [
            Text(
              AppLanguageString.PROPERTY_INFO.tr,
              style: Get.textTheme.headline2!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpaces.spaces_height_15,
            SizedBox(
              height: HomeController.to.descriptionExtended!.value == false
                  ? AppDimension.expandedContainerSize
                  : AppDimension.collupsContainerSize * 5,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.info_outline_rounded),
                                AppSpaces.spaces_width_5,
                                Text(
                                  'Information $index',
                                  style: Get.textTheme.bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text('Des of $index'),
                          ],
                        ),
                        AppSpaces.spaces_height_10,
                        const Divider(
                          height: 1.0,
                        ),
                        AppSpaces.spaces_height_10,
                      ],
                    );
                  }),
            ),
            Center(
              child: HomeController.to.descriptionExtended!.value == false
                  ? InkWell(
                      onTap: () {
                        HomeController.to.descriptionExtended!.value = true;
                      },
                      child: Text(
                        AppLanguageString.SHOWMORE.tr,
                        style: Get.textTheme.bodyText2!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        HomeController.to.descriptionExtended!.value = false;
                      },
                      child: Text(
                        AppLanguageString.SHOWLESS.tr,
                        style: Get.textTheme.bodyText2!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            )
          ],
        );
      }),
    );
  }
}
