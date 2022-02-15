import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_loading.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';
import 'package:ketemaa/core/utilities/common_widgets/category_card.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: ListView(
        children: [
          Column(
            children: [
              AppSpaces.spaces_height_5,
              Text(
                AppLanguageString.SELECT_CATEGORY.tr,
                style: Get.textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppSpaces.spaces_height_5,
              Text(
                AppLanguageString.MATCH_CATEGORY.tr,
                style: Get.textTheme.bodyText2!.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          AppSpaces.spaces_height_30,
          Obx(() {
            return HomeController.to.categoryModel.value.categories == null
                ? AppLoading()
                : Padding(
                    padding: EdgeInsets.only(
                      left: AppDimension.padding_16,
                      right: AppDimension.padding_16,
                    ),
                    child: CategoryCard(

                      category: HomeController
                          .to.categoryModel.value.categories!.edges!,
                      //need to null check
                      mainAxisSpace: 5.0,
                      crossAxisSpace: 5.0,
                      childCount: 2,
                      childAspectRatio: AppSizes.width3 / AppSizes.width3,
                      cardElavation: 1.0,
                      pageName: AppRoutes.PLACE_A_ADD,
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
