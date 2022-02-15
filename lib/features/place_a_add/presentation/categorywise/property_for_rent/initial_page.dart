import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/place_a_add/_controller/place_a_add_controller.dart';

class PropertyInitialPage extends StatelessWidget {
  const PropertyInitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PlaceAddController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text(
          AppLanguageString.PLACE_A_ADD.tr,
          style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Image.asset(
            AppAsset.back_icon,
            height: 18.0,
            width: 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppDimension.padding_16,
          right: AppDimension.padding_16,
        ),
        child: Column(
          children: [
            AppSpaces.spaces_height_25,
            Text(
              AppLanguageString.PROPERTY_ADD_TITLE.tr,
              style: Get.textTheme.headline4!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            AppSpaces.spaces_height_10,
            Text(
              AppLanguageString.PROPERTY_ADD_DISCRIPTION.tr,
              style: Get.textTheme.bodyText2!.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            AppSpaces.spaces_height_25,
            TextField(
              onChanged: (value) {
                value != ""
                    ? PlaceAddController.to.titleSubmitButton.value = true
                    : PlaceAddController.to.titleSubmitButton.value = false;
              },
              controller:
                  PlaceAddController.to.propertyRentTitleFieldController,
              decoration: InputDecoration(
                focusColor: AppColors.black,
                hintText: AppLanguageString.PROPERTY_ADD_TITLE_HINT.tr,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.propertyRentTitleRadius),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            AppSpaces.spaces_height_20,
            Obx(() {
              return PlaceAddController.to.titleSubmitButton.value == true
                  ? Container(
                      height: Get.height * .09,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppDimension.propertyRentTitleRadius),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.PROPERTY_AGENT_PAGE);
                          printInfo(
                              info:
                                  'Clicked after submit : ${PlaceAddController.to.titleSubmitButton.value} ');
                        },
                        child: Text(
                          AppLanguageString.LETS_GO.tr.toUpperCase(),
                          style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height * .09,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.grey, // set border width
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppDimension.propertyRentTitleRadius),
                        ), // set rounded corner radius
                      ),
                      child: Center(
                        child: Text(
                          AppLanguageString.LETS_GO.tr.toUpperCase(),
                          style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
