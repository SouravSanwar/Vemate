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
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(PlaceAddController());
    Get.put(ControllerPageController());
    HomeController.to.fetchHomeCategoryData();

    SharedPreferenceController.to.getToken();

    return const Scaffold(
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
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
