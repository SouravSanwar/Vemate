import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/app_routes/app_routes.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_assets/app_assets.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_snack_bar.dart';
import 'package:ketemaa/features/controller_page/presentattion/controller_page.dart';
import 'package:ketemaa/features/place_a_add/_controller/place_a_add_controller.dart';
import 'package:ketemaa/features/place_a_add/presentation/category_page.dart';

class PlaceAAdd extends StatelessWidget {
  PlaceAAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PlaceAddController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: FlatButton(
          onPressed: () {
            PlaceAddController.to.currentPage.value = 0;
          },
          child: Image.asset(
            AppAsset.cross_icon,
            height: 18.0,
            width: 18.0,
          ),
        ),
      ),
      body: _cityList(),
    );
  }

  Widget _cityList() {
    return ListView(
      children: [
        Column(
          children: [
            AppSpaces.spaces_height_5,
            Text(
              AppLanguageString.SELECT_CITY.tr,
              style: Get.textTheme.headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            AppSpaces.spaces_height_5,
            Text(
              AppLanguageString.PLACEYOURADD.tr,
              style: Get.textTheme.bodyText2!.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        AppSpaces.spaces_height_30,
        Padding(
          padding: EdgeInsets.only(
              left: AppDimension.padding_16, right: AppDimension.padding_16),
          child: Obx(() {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    PlaceAddController.to.cityModel.value.cities!.totalCount,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.CATEGORYFORADD);
                      PlaceAddController.to.cityCheckedIndex.value = index;
                      AppSnackBar.showSuccessMessage(
                          title: "City Clicked",
                          body:
                              "You Selected ${PlaceAddController.to.cityModel.value.cities!.edges![index].node!.city.toString()}");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(PlaceAddController.to.cityModel.value.cities!
                                .edges![index].node!.city
                                .toString()),
                            PlaceAddController.to.cityCheckedIndex.value ==
                                    index
                                ? Image.asset(
                                    AppAsset.tic_icon,
                                    width: 20.0,
                                    height: 20.0,
                                  )
                                : const Icon(null),
                          ],
                        ),
                        AppSpaces.spaces_height_15,
                        Divider(
                          thickness: AppDimension.city_divider_tickness,
                          //thickness: .5,
                          color: AppColors.grey,
                          //height: 1.0,
                        ),
                        AppSpaces.spaces_height_10,
                      ],
                    ),
                  );
                });
          }),
        ),
      ],
    );
  }
}
