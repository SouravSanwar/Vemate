import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/language/language_string.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/core/utilities/common_widgets/app_loading.dart';
import 'package:ketemaa/core/utilities/common_widgets/shimmer.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/home/_controller/home_controller.dart';
import 'package:ketemaa/core/utilities/common_widgets/category_card.dart';
import 'package:ketemaa/features/home/presentation/widgets/porperty_for_rent_listview.dart';
import 'package:ketemaa/features/place_a_add/_controller/place_a_add_controller.dart';

class Home extends StatelessWidget {
  var cityId;

  Home({this.cityId});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(PlaceAddController());
    Get.put(ControllerPageController());
    HomeController.to.fetchHomeCategoryData();

    SharedPreferenceController.to.getToken();

    return Scaffold(
      /*appBar: AppBar(
        //leading: null,
        // The search area here
        leading: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppDimension.padding_8,
            left: AppDimension.padding_16,
            right: AppDimension.padding_16,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: AppSizes.width8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.hintColor,
                        //color: Colors.grey,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primaryColor,
                              ),
                              hintText: AppLanguageString.SEARCH_HINT.tr,
                              hintStyle: Get.textTheme.bodyText1!
                                  .copyWith(color: AppColors.primaryColor),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_none)),
                    )
                  ],
                ),
                AppSpaces.spaces_height_10,
                Obx(() {
                  return HomeController.to.categoryModel.value.categories ==
                          null
                      ? AppLoading()
                      : CategoryCard(
                          category: HomeController
                              .to.categoryModel.value.categories!.edges!,
                          //need to null check
                          mainAxisSpace: 3.0,
                          crossAxisSpace: 3.0,
                          childCount: 3,
                          childAspectRatio: AppSizes.width3 / 130,
                          cardElavation: 3.0,
                        );
                }),
                AppSpaces.spaces_height_10,
                HomeController.to.propertyRentModel.value
                            .propertyRentAdvertises ==
                        null
                    ? AppLoading()
                    :  PropertyListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
