import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';

class AmenitiesInfo extends StatelessWidget {
  const AmenitiesInfo({Key? key}) : super(key: key);

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
              AppLanguageString.AMENITIES.tr,
              style: Get.textTheme.headline2!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpaces.spaces_height_10,
            SizedBox(
              height: HomeController.to.amenitiesExtended!.value == false
                  ? AppDimension.collupsContainerSize
                  : AppDimension.expandedContainerSize * 9 / 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //mainAxisSpacing: 3.0,
                  //crossAxisSpacing: 3.0,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / .25,
                ),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(
                        Icons.done,
                        color: AppColors.grey,
                        size: 15.0,
                      ),
                      AppSpaces.spaces_width_5,
                      Expanded(
                        child: Text(
                          'Amenities Info $index',
                          maxLines: 2,
                          style: Get.textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Center(
              child: HomeController.to.amenitiesExtended!.value == false
                  ? InkWell(
                      onTap: () {
                        HomeController.to.amenitiesExtended!.value = true;
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
                        HomeController.to.amenitiesExtended!.value = false;
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
