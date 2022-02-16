import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_dimension.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/_global/sharedpreference/sp_controller.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/home/Components/category_card.dart';
import 'package:ketemaa/features/home/Components/category_item_card.dart';
import 'package:ketemaa/features/home/Components/name_row.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/app_assets/app_assets.dart';
import '../../../core/utilities/app_colors/app_colors.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    var fetchData = Provider.of<GetData>(context, listen: false);

    fetchData.getCollectibles();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());

    SharedPreferenceController.to.getToken();

    return Scaffold(
      /*appBar: AppBar(
        //leading: null,
        // The search area here
        leading: Container(
          width: Get.width,
          height: Get.height * .35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text('AppBar'),
          ),
        ),
      ),*/
      body: Consumer<GetData>(builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.all(AppDimension.padding_16),
          child: ListView(
            children: [
              CategoryCard(
                name: 'Category Name',
              ),
              AppSpaces.spaces_height_10,
              NameRow(
                name: 'Collectibles',
              ),
              AppSpaces.spaces_height_10,
              CategoryItemCard(
                image: AppAsset.main_auth_image_2,
              ),
              AppSpaces.spaces_height_10,
              NameRow(
                name: 'Comics',
              ),
              AppSpaces.spaces_height_10,
              CategoryItemCard(
                image: AppAsset.main_auth_image_3,
              ),
            ],
          ),
        );
      }),
    );
  }
}
