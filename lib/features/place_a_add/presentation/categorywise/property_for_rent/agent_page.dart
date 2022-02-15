import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';

class PropertyAgentPage extends StatelessWidget {
  const PropertyAgentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSpaces.spaces_height_30,
            Text(
              AppLanguageString.PROPERTY_AGENT_TITLE.tr,
              style: Get.textTheme.headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            AppSpaces.spaces_height_25,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _agentCard(
                  AppAsset.demo_category,
                  AppLanguageString.PROPERTY_LANDLORD,
                ),
                _agentCard(
                  AppAsset.demo_category,
                  AppLanguageString.PROPERTY_AGENT,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _agentCard(var image, var name) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoutes.PROPERTY_LISTING_PAGE);
      },
      child: SizedBox(
        height: AppSizes.width45,
        width: AppSizes.width45,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: AppDimension.category_image_height,
                width: AppDimension.category_image_width,
              ),
              AppSpaces.spaces_height_10,
              Padding(
                padding: EdgeInsets.only(
                  left: AppDimension.padding_8,
                  right: AppDimension.padding_8,
                ),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style:
                      Get.textTheme.bodyText1!.copyWith(color: AppColors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
